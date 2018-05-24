//
//  NewTaskAnimator.swift
//  TODO
//
//  Created by Simon Kostenko on 5/23/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import UIKit

class NewTaskAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 1.0
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
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        let finalFrame = transitionContext.finalFrame(for: transitionContext.viewController(forKey: .to)!)
        toView.frame = finalFrame
        
//        containerView.addSubview(toView)
//        toView.alpha = 0.0
//        UIView.animate(withDuration: duration,
//                       animations: {
//                        toView.alpha = 1.0
//        },
//                       completion: { _ in
//                        transitionContext.completeTransition(true)
//        }
//        )
        
//        return
        
//        let newTaskView = presenting ? toView : transitionContext.view(forKey: .from)!
//        let projectView = presenting ? transitionContext.view(forKey: .from)! : toView
        
        if let taskView = toView as? NewTaskView {
            taskView.taskDetailsTextView.becomeFirstResponder()
        }
        
        
        let hidingView = dismissView
        containerView.addSubview(hidingView)
        
        containerView.addSubview(toView)
        toView.alpha = 0.0
        toView.center.y += 20.0
        
        
        
        let fromVC = transitionContext.viewController(forKey: .from) as! ProjectTasksVC
        fromVC.contentView.newTaskButton.isHidden = true
        let newTaskButton = UIButton()
        newTaskButton.frame = fromVC.contentView.newTaskButton.frame
        newTaskButton.clipsToBounds = true
        newTaskButton.layer.cornerRadius = newTaskButton.frame.width / 2.0
        newTaskButton.backgroundColor = UIColor(red: 0.36, green: 0.55, blue: 0.89, alpha: 1.00)
        newTaskButton.setTitle("＋", for: .normal)
        newTaskButton.setTitleColor(UIColor.white, for: .normal)
//        let frame = fromVC.contentView.convert(newTaskButton.frame, to: nil)
////        newTaskButton.removeFromSuperview()
//        newTaskButton.frame = frame
        containerView.addSubview(newTaskButton)
        
        UIView.animateKeyframes(withDuration: 1.5, delay: 0.0,
                                animations: {
                                    
                                    UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.8,
                                                       animations: {
                                                        hidingView.frame.origin = CGPoint.init(x: 0, y: -30)
                                    }
                                    )
                                    
                                    UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25,
                                                       animations: {
                                                        toView.alpha = 1.0
                                                        toView.center.y -= 20.0
                                    }
                                    )
                                    
//                                    UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25/1.5, animations: {
//                                        newTaskButton.frame.size.width = UIScreen.main.bounds.width
//                                        newTaskButton.center.x = UIScreen.main.bounds.width / 2.0
//                                        newTaskButton.frame.origin.y = self.rect!.origin.y - 44
//                                    })
        },
                                completion: { _ in
                                    hidingView.removeFromSuperview()
                                    transitionContext.completeTransition(true)
                                    
        }
        )
        UIView.animate (withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.init(rawValue: 7), animations: {
            newTaskButton.frame.size.width = UIScreen.main.bounds.width
            newTaskButton.center.x = UIScreen.main.bounds.width / 2.0
            newTaskButton.frame.origin.y = self.rect!.origin.y - 44
        })
        let round = CABasicAnimation(keyPath: "cornerRadius")
        round.fromValue = newTaskButton.layer.cornerRadius
        round.toValue = 0.0
        round.duration = 0.3
        newTaskButton.layer.add(round, forKey: nil)
        newTaskButton.layer.cornerRadius = 0.0
    }
    
    
    var dismissView: UIView {
        let resultView = UIView(frame: UIScreen.main.bounds)
        resultView.frame.size.height += 30
        resultView.frame.origin = CGPoint.init(x: 0, y: UIScreen.main.bounds.height)
        
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
        
        return resultView
    }
    
}
