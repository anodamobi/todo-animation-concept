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
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        presenting ? animatePresentingTransition(using: transitionContext) : animateDismissingTransition(using: transitionContext)
        return
    }
    
    private func animateDismissingTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let newTaskView = transitionContext.view(forKey: .from) as? NewTaskView else { return }
        guard let projectView = transitionContext.view(forKey: .to) as? ProjectTasksView else { return }
        
        containerView.addSubview(projectView)
        let dismissView = self.dismissView()
        containerView.addSubview(dismissView)
        containerView.bringSubview(toFront: newTaskView)
        
        let animatedAddTaskButton = animatedNewTaskButtonForDismissing(newTaskView: newTaskView)
        containerView.addSubview(animatedAddTaskButton)
        newTaskView.addNewTaskButton.isHidden = true

        UIView.animateKeyframes(withDuration: duration, delay: 0.0, animations: {
                                    
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.3, animations: {
                newTaskView.alpha = 0.0
                newTaskView.center.y += 40.0
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.75, animations: {
                dismissView.frame.origin.y = UIScreen.main.bounds.height
            })
        }, completion: { _ in
            animatedAddTaskButton.removeFromSuperview()
            dismissView.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
        
        newTaskView.taskDetailsTextView.resignFirstResponder()
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.75)
        if let curve = UIViewAnimationCurve(rawValue: 7) {
            UIView.setAnimationCurve(curve)
        }
        UIView.setAnimationBeginsFromCurrentState(true)
        animatedAddTaskButton.frame.origin.y = UIScreen.main.bounds.height
        UIView.commitAnimations()
    }
    
    private func animatePresentingTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let newTaskView = transitionContext.view(forKey: .to) as? NewTaskView else { return }
        guard let toVC = transitionContext.viewController(forKey: .to) else { return }
        let finalFrame = transitionContext.finalFrame(for: toVC)
        newTaskView.frame = finalFrame
        let dismissView = self.dismissView()
        containerView.addSubview(dismissView)
        containerView.addSubview(newTaskView)
        newTaskView.alpha = 0.0
        newTaskView.center.y += 40.0
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.75, animations: {
                dismissView.frame.origin = CGPoint.init(x: 0, y: -30)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.3, animations: {
                newTaskView.alpha = 1.0
                newTaskView.center.y -= 40.0
            })
        }, completion: { _ in
            dismissView.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
        
        newTaskView.addNewTaskButton.frame.origin.y = UIScreen.main.bounds.height
        DispatchQueue.main.asyncAfter(deadline: .now() + duration / 2) {
            newTaskView.taskDetailsTextView.becomeFirstResponder()
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.75)
            if let curve = UIViewAnimationCurve(rawValue: 7) {
                UIView.setAnimationCurve(curve)
            }
            UIView.setAnimationBeginsFromCurrentState(true)
            newTaskView.layoutIfNeeded()
            UIView.commitAnimations()
        }
    }

    // MARK: - Private Methods
    
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
