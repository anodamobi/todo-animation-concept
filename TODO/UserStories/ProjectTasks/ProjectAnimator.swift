//
//  ProjectAnimator.swift
//  TODO
//
//  Created by ANODA on 1/17/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import UIKit
import pop

enum PresentationStyle {
    case present
    case dismiss
}

class ProjectTasksAnimator: NSObject, UIViewControllerAnimatedTransitioning, POPAnimationDelegate {
    
    let originFrame: CGRect
    let duration: TimeInterval
    let presentationStyle: PresentationStyle
    
    init(duration: TimeInterval, presentationStyle: PresentationStyle, originFrame: CGRect) {
        self.duration = duration
        self.presentationStyle = presentationStyle
        self.originFrame = originFrame
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toViewController = transitionContext.viewController(forKey: .to),
        let toView = transitionContext.viewController(forKey: .to)?.view,
        let fromView = transitionContext.viewController(forKey: .from)?.view,
        let taskView = (presentationStyle == .present ? toView : fromView) as? ProjectTasksView else { return }
        
        let finalFrame = transitionContext.finalFrame(for: toViewController)
        let containerView = transitionContext.containerView
        toView.frame = presentationStyle == .present ? originFrame : finalFrame
        containerView.addSubview(toView)
        if presentationStyle == .dismiss {
            containerView.addSubview(fromView)
        }
        
        let projectViewStartFrame = presentationStyle == .present ? originFrame :  CGRect(x: 0, y: 88, width: UIScreen.main.bounds.width, height: 135)
        let projectView = ProjectView()
        projectView.frame = projectViewStartFrame
        projectView.backgroundColor = UIColor.white
        projectView.layer.cornerRadius = 8
        projectView.clipsToBounds = true
        
        let projectViewAnimation = POPBasicAnimation(propertyNamed: kPOPViewFrame)
        let projectViewEndFrame = presentationStyle == .present ? CGRect(x: 0, y: 88, width: UIScreen.main.bounds.width, height: 135) : originFrame
        projectViewAnimation?.toValue = NSValue(cgRect: projectViewEndFrame)
        projectViewAnimation?.duration = duration
        projectView.pop_add(projectViewAnimation, forKey: "ProjectViewAnimation")
        containerView.addSubview(projectView)
    
        taskView.projectView.isHidden = true
        taskView.layer.cornerRadius = 8.0
        taskView.clipsToBounds = true
        
        let containerViewAnimation = POPBasicAnimation(propertyNamed: kPOPViewFrame)
        containerViewAnimation?.toValue = NSValue(cgRect: presentationStyle == .present ? finalFrame : originFrame)
        containerViewAnimation?.duration = duration
        switch presentationStyle {
        case .present:
            taskView.newTaskButton.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
            taskView.navigationView.alpha = 0.0
            toView.pop_add(containerViewAnimation, forKey: "containerViewAnimation")
            UIView.animateKeyframes(withDuration: duration, delay: 0, options: [], animations: {
                taskView.layer.cornerRadius = 0.0
                UIView.addKeyframe(withRelativeStartTime: 3/4, relativeDuration: 1/4) {
                    taskView.newTaskButton.transform = .identity
                    taskView.navigationView.alpha = 1.0
                }
            }, completion: nil)
        case .dismiss:
            fromView.pop_add(containerViewAnimation, forKey: "containerViewAnimation")
            
            let navigationViewAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
            navigationViewAnimation?.fromValue = 1.0
            navigationViewAnimation?.toValue = 0.0
            navigationViewAnimation?.duration = duration / 8
            taskView.navigationView.pop_add(navigationViewAnimation, forKey: "navigationViewAnimation")
            
            let taskButtonAnimation = POPBasicAnimation(propertyNamed: kPOPViewScaleXY)
            taskButtonAnimation?.fromValue = NSValue(cgPoint: CGPoint(x: 1.0, y: 1.0))
            taskButtonAnimation?.toValue = NSValue(cgPoint: .zero)
            taskButtonAnimation?.duration = duration / 4
            taskView.newTaskButton.pop_add(taskButtonAnimation, forKey: "taskButtonAnimation")
            let taskButtonAlphaAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
            taskButtonAlphaAnimation?.fromValue = 1.0
            taskButtonAlphaAnimation?.toValue = 0.0
            taskButtonAlphaAnimation?.duration = duration / 4
            taskView.newTaskButton.pop_add(taskButtonAlphaAnimation, forKey: "taskButtonAlphaAnimation")
        }
        
        containerViewAnimation?.completionBlock = { (_, _) in
            projectView.removeFromSuperview()
            taskView.subviews.forEach { $0.isHidden = false }
            toView.subviews.forEach { $0.isHidden = false }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        

//        let tbAnimation = POPBasicAnimation(propertyNamed: kPOPViewScaleXY)
//        tbAnimation?.fromValue = NSValue.init(cgPoint: CGPoint.init(x: 0.1, y: 0.1))
//        tbAnimation?.toValue = NSValue.init(cgPoint: CGPoint.init(x: 1, y: 1))
//        tbAnimation?.duration = 1.5
//        tbAnimation?.beginTime = CACurrentMediaTime() + 0.5
//        taskView.tableView.pop_add(tbAnimation, forKey: "TBA")
//
    }
    
}

