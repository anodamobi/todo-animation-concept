/*
  The MIT License (MIT)
  Copyright (c) 2018 ANODA Mobile Development Agency. http://anoda.mobi <info@anoda.mobi>
  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:
  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.
  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
*/

import UIKit

class NewTaskAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 0.75
    var presenting = true
    private var keyboardRect: CGRect?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        presenting ? animatePresentingTransition(using: transitionContext) : animateDismissingTransition(using: transitionContext)
        return
    }
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(willShow(_:)),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func willShow(_ notification: Notification) {
        keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
    }
    
    private func animateDismissingTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let newTaskView = transitionContext.view(forKey: .from) as? NewTaskView else { return }
        guard let projectView = transitionContext.view(forKey: .to) as? ProjectTasksView else { return }
        
        newTaskView.taskDetailsTextView.resignFirstResponder()
        
        containerView.addSubview(projectView)
        let dismissView = self.dismissView()
        containerView.addSubview(dismissView)
        containerView.bringSubview(toFront: newTaskView)
        
        let animatedAddTaskButton = animatedNewTaskButtonForDismissing(newTaskView: newTaskView)
        containerView.addSubview(animatedAddTaskButton)
        newTaskView.addNewTaskButton.isHidden = true
        projectView.newTaskButton.isHidden = true

        UIView.animateKeyframes(withDuration: duration, delay: 0.0, animations: {
                                    
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.3, animations: {
                newTaskView.alpha = 0.0
                newTaskView.center.y += 40.0
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.75, animations: {
                dismissView.frame.origin.y = UIScreen.main.bounds.height
            })
        }, completion: { _ in
            projectView.newTaskButton.isHidden = false
            animatedAddTaskButton.removeFromSuperview()
            dismissView.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
        animateNewTaskButton(animatedAddTaskButton, to: projectView.newTaskButton.frame)
    }
    
    private func animatePresentingTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let newTaskView = transitionContext.view(forKey: .to) as? NewTaskView else { return }
        guard let toVC = transitionContext.viewController(forKey: .to) else { return }
        let finalFrame = transitionContext.finalFrame(for: toVC)
        newTaskView.frame = finalFrame
//        newTaskView.taskDetailsTextView.becomeFirstResponder()
        newTaskView.addNewTaskButton.isHidden = true
        let dismissView = self.dismissView()
        containerView.addSubview(dismissView)
        containerView.addSubview(newTaskView)
        newTaskView.alpha = 0.0
        newTaskView.center.y += 40.0
        
//        guard let projectView = transitionContext.view(forKey: .from) as? ProjectTasksView else { return }
//        projectView.newTaskButton.isHidden = true
        let animatedAddTaskButton = animatedNewTaskButtonForPresenting(newTaskView: newTaskView)
        containerView.addSubview(animatedAddTaskButton)
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.75, animations: {
                dismissView.frame.origin = CGPoint.init(x: 0, y: -30)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.3, animations: {
                newTaskView.alpha = 1.0
                newTaskView.center.y -= 40.0
            })
        }, completion: { _ in
//            newTaskView.taskDetailsTextView.becomeFirstResponder()
            
            
//            projectView.newTaskButton.isHidden = false
//            animatedAddTaskButton.removeFromSuperview()
            dismissView.removeFromSuperview()
//            newTaskView.addNewTaskButton.isHidden = false
//            transitionContext.completeTransition(true)
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration / 2) {
            newTaskView.taskDetailsTextView.becomeFirstResponder()
            UIView.animate(withDuration: 0.35, delay: 0.0, options: UIViewAnimationOptions(rawValue: 7), animations: {
                animatedAddTaskButton.frame.origin.y = (self.keyboardRect?.origin.y)! - animatedAddTaskButton.frame.height
            }, completion: { _ in
                newTaskView.addNewTaskButton.isHidden = false
                transitionContext.completeTransition(true)
            })
        }
        
        
//        UIView.animate(withDuration: 0.3, delay: duration * 0.8, animations: {
//            newTaskView.addNewTaskButton.alpha = 1.0
//        }) { _ in
//            transitionContext.completeTransition(true)
//        }
//        guard let keyboardRect = self.keyboardRect else { return }
//        let newFrame = CGRect(x: 0,
//                                   y: 300,//keyboardRect.origin.y - animatedAddTaskButton.frame.height,
//                                   width: UIScreen.main.bounds.width,
//                                   height: animatedAddTaskButton.frame.height)
//        animateNewTaskButton(animatedAddTaskButton, to: newFrame)
    }

    // MARK: - Private Methods
    
    private func animateNewTaskButton(_ animatedAddTaskButton: UIButton, to newFrame: CGRect) {
        UIView.animate(withDuration: duration / 2, delay: 0, options: UIViewAnimationOptions.init(rawValue: 7), animations: {
            animatedAddTaskButton.frame.size.width = newFrame.width
            animatedAddTaskButton.frame.origin = newFrame.origin
        })
        animateCornerRadius(for: animatedAddTaskButton)
    }
    
    private func animatedNewTaskButtonForPresenting(newTaskView: NewTaskView) -> UIButton {
        let animatedAddTaskButton = UIButton()
        animatedAddTaskButton.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 54.0)//newTaskView.addNewTaskButton.frame
//        animatedAddTaskButton.frame.origin.y = UIScreen.main.bounds.height
        animatedAddTaskButton.backgroundColor = newTaskView.addNewTaskButton.backgroundColor
        animatedAddTaskButton.setTitle(newTaskView.addNewTaskButton.titleLabel?.text, for: .normal)
        animatedAddTaskButton.setTitleColor(newTaskView.addNewTaskButton.titleColor(for: .normal), for: .normal)
        animatedAddTaskButton.titleLabel?.font = .romanTitle
        return animatedAddTaskButton
    }
    
    private func animatedNewTaskButtonForDismissing(newTaskView: NewTaskView) -> UIButton {
        let animatedAddTaskButton = UIButton()
        animatedAddTaskButton.frame = newTaskView.addNewTaskButton.frame
        animatedAddTaskButton.clipsToBounds = true
        animatedAddTaskButton.backgroundColor = newTaskView.addNewTaskButton.backgroundColor
        animatedAddTaskButton.setTitle(newTaskView.addNewTaskButton.titleLabel?.text, for: .normal)
        animatedAddTaskButton.setTitleColor(newTaskView.addNewTaskButton.titleColor(for: .normal), for: .normal)
        animatedAddTaskButton.titleLabel?.font = .romanTitle
        return animatedAddTaskButton
    }
    
    private func animateCornerRadius(for animatedAddTaskButton: UIButton) {
        let round = CABasicAnimation(keyPath: "cornerRadius")
        round.fromValue = animatedAddTaskButton.layer.cornerRadius
        round.toValue = presenting ? 0.0 : animatedAddTaskButton.frame.width / 2.0
        round.duration = duration / 2
        animatedAddTaskButton.layer.add(round, forKey: nil)
        animatedAddTaskButton.layer.cornerRadius = presenting ? 0.0 : animatedAddTaskButton.frame.width / 2.0
    }
    
    private func dismissView() -> UIView {
        let resultView = UIView(frame: UIScreen.main.bounds)
        resultView.frame.size.height += 30
        
        var frame = CGRect(x: 0, y: 0, width: resultView.frame.width, height: 10)
        let firstView = auxiliaryDismissView(frame: frame, alpha: 0.2)
        frame.origin.y += 10
        let secondView = auxiliaryDismissView(frame: frame, alpha: 0.5)
        frame.origin.y += 10
        let thirdView = auxiliaryDismissView(frame: frame, alpha: 0.8)
        
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
    
    private func auxiliaryDismissView(frame: CGRect, alpha: CGFloat) -> UIView {
        let view = UIView(frame: frame)
        view.backgroundColor = UIColor(white: 1.0, alpha: 0.2)
        return view
    }
}
