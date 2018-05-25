//
//  NewTaskAnimator.swift
//  TODO
//
//  Created by Simon Kostenko on 5/23/18.
//  Copyright © 2018 Simon Kostenko. All rights reserved.
//

import UIKit

class NewTaskAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 0.6
    var presenting = true
    var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(willShow(_:)), name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func willShow(_ notification: Notification) {
        rect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
    }
    
    private var rect: CGRect?
    
    private func animateDismissingTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        let newTaskView = transitionContext.view(forKey: .from)! as! NewTaskView
        let projectView = transitionContext.view(forKey: .to)! as! ProjectTasksView
        
        newTaskView.taskDetailsTextView.resignFirstResponder()
        
        containerView.addSubview(projectView)
        
        let dismissView = self.dismissView()
        containerView.addSubview(dismissView)
        
        containerView.bringSubview(toFront: newTaskView)
        
        let animatedAddTaskButton = UIButton()
        animatedAddTaskButton.frame = newTaskView.addNewTaskButton.frame
        animatedAddTaskButton.clipsToBounds = true
        animatedAddTaskButton.backgroundColor = newTaskView.addNewTaskButton.backgroundColor
        animatedAddTaskButton.setTitle(newTaskView.addNewTaskButton.titleLabel?.text, for: .normal)
        animatedAddTaskButton.setTitleColor(newTaskView.addNewTaskButton.titleColor(for: .normal), for: .normal)
        containerView.addSubview(animatedAddTaskButton)
        newTaskView.addNewTaskButton.isHidden = true
        projectView.newTaskButton.isHidden = true

        UIView.animateKeyframes(withDuration: duration, delay: 0.0,
                                animations: {
                                    
                                    UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.3,
                                                       animations: {
                                                        newTaskView.alpha = 0.0
                                                        newTaskView.center.y += 40.0
                                    }
                                    )
                                    
                                    UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.75,
                                                       animations: {
                                                        dismissView.frame.origin.y = UIScreen.main.bounds.height
                                    }
                                    )
        },
                                completion: { _ in
                                    projectView.newTaskButton.isHidden = false
                                    animatedAddTaskButton.removeFromSuperview()
                                    dismissView.removeFromSuperview()
                                    transitionContext.completeTransition(true)
                                    
        }
        )
        
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.init(rawValue: 7), animations: {
            animatedAddTaskButton.frame.size.width = projectView.newTaskButton.frame.width
            animatedAddTaskButton.center.x = projectView.newTaskButton.center.x
            animatedAddTaskButton.frame.origin.y = projectView.newTaskButton.frame.origin.y
        })
        let round = CABasicAnimation(keyPath: "cornerRadius")
        round.fromValue = 0.0
        round.toValue = projectView.newTaskButton.layer.cornerRadius
        round.duration = 0.3
        animatedAddTaskButton.layer.add(round, forKey: nil)
        animatedAddTaskButton.layer.cornerRadius = projectView.newTaskButton.layer.cornerRadius
    }
    
    private func animatePresentingTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        let newTaskView = transitionContext.view(forKey: .to)! as! NewTaskView
        let finalFrame = transitionContext.finalFrame(for: transitionContext.viewController(forKey: .to)!)
        newTaskView.frame = finalFrame
        
        newTaskView.taskDetailsTextView.becomeFirstResponder()
        newTaskView.addNewTaskButton.isHidden = true
        
        let dismissView = self.dismissView()
        containerView.addSubview(dismissView)
        
        containerView.addSubview(newTaskView)
        newTaskView.alpha = 0.0
        newTaskView.center.y += 40.0
        
        let projectView = transitionContext.view(forKey: .from) as! ProjectTasksView
        projectView.newTaskButton.isHidden = true
        let animatedAddTaskButton = UIButton()
        animatedAddTaskButton.frame = projectView.newTaskButton.frame
        animatedAddTaskButton.clipsToBounds = true
        animatedAddTaskButton.layer.cornerRadius = animatedAddTaskButton.frame.width / 2.0
        animatedAddTaskButton.backgroundColor = projectView.newTaskButton.backgroundColor
        animatedAddTaskButton.setTitle(projectView.newTaskButton.titleLabel?.text, for: .normal)
        animatedAddTaskButton.setTitleColor(UIColor.white, for: .normal)
        containerView.addSubview(animatedAddTaskButton)
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0,
                                animations: {
                                    
                                    UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.75,
                                                       animations: {
                                                        dismissView.frame.origin = CGPoint.init(x: 0, y: -30)
                                    }
                                    )
                                    
                                    UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.3,
                                                       animations: {
                                                        newTaskView.alpha = 1.0
                                                        newTaskView.center.y -= 40.0
                                    }
                                    )
        },
                                completion: { _ in
                                    newTaskView.addNewTaskButton.isHidden = false
                                    projectView.newTaskButton.isHidden = false
                                    animatedAddTaskButton.removeFromSuperview()
                                    dismissView.removeFromSuperview()
                                    transitionContext.completeTransition(true)
                                    
        }
        )
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.init(rawValue: 7), animations: {
            animatedAddTaskButton.frame.size.width = UIScreen.main.bounds.width
            animatedAddTaskButton.center.x = UIScreen.main.bounds.width / 2.0
            animatedAddTaskButton.frame.origin.y = self.rect!.origin.y - animatedAddTaskButton.frame.height
        })
        let round = CABasicAnimation(keyPath: "cornerRadius")
        round.fromValue = animatedAddTaskButton.layer.cornerRadius
        round.toValue = 0.0
        round.duration = 0.3
        animatedAddTaskButton.layer.add(round, forKey: nil)
        animatedAddTaskButton.layer.cornerRadius = 0.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        presenting ? animatePresentingTransition(using: transitionContext) : animateDismissingTransition(using: transitionContext)
        return
    }
    
    private func dismissView() -> UIView {
        let resultView = UIView(frame: UIScreen.main.bounds)
        resultView.frame.size.height += 30
        
        let firstView = UIView(frame: CGRect(x: 0, y: 0, width: resultView.frame.width, height: 10))
        firstView.backgroundColor = UIColor(white: 1.0, alpha: 0.2)
        
        let secondView = UIView(frame: CGRect(x: 0, y: 10, width: resultView.frame.width, height: 10))
        secondView.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        
        let thirdView = UIView(frame: CGRect(x: 0, y: 20, width: resultView.frame.width, height: 10))
        thirdView.backgroundColor = UIColor(white: 1.0, alpha: 0.8)
        
        let whiteView = UIView.init(frame: UIScreen.main.bounds)
        whiteView.frame.origin.y += 30
        whiteView.backgroundColor = .white
        
        resultView.addSubview(firstView)
        resultView.addSubview(secondView)
        resultView.addSubview(thirdView)
        resultView.addSubview(whiteView)
        
        resultView.frame.origin = CGPoint(x: 0, y: presenting ? UIScreen.main.bounds.height : -30.0)
        return resultView
    }
}
