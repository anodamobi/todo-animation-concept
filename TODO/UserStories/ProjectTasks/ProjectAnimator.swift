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
        projectViewAnimation?.duration = 2.0
        projectView.pop_add(projectViewAnimation, forKey: "ProjectViewAnimation")
        containerView.addSubview(projectView)
    
        taskView.projectView.isHidden = true
        taskView.newTaskButton.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)

        let containerViewAnimation = POPBasicAnimation(propertyNamed: kPOPViewFrame)
        containerViewAnimation?.toValue = NSValue(cgRect: presentationStyle == .present ? finalFrame : originFrame)
        containerViewAnimation?.duration = 2.0
        containerViewAnimation?.delegate = self
        switch presentationStyle {
        case .present:
            toView.pop_add(containerViewAnimation, forKey: "containerViewAnimation")
            UIView.animateKeyframes(withDuration: duration, delay: 0, options: [], animations: {
                UIView.addKeyframe(withRelativeStartTime: 3/4, relativeDuration: 1/4) {
                    taskView.newTaskButton.transform = .identity
                }
            }, completion: nil)
        case .dismiss:
            fromView.pop_add(containerViewAnimation, forKey: "containerViewAnimation")
            
            let taskButtonAnimation = POPBasicAnimation(propertyNamed: kPOPViewScaleXY)
            taskButtonAnimation?.fromValue = NSValue(cgPoint: CGPoint(x: 1.0, y: 1.0))
            taskButtonAnimation?.toValue = NSValue(cgPoint: .zero)
            taskButtonAnimation?.duration = duration / 4
            taskButtonAnimation?.timingFunction = CAMediaTimingFunction.easeIn
            taskView.newTaskButton.pop_add(taskButtonAnimation, forKey: "taskButtonAnimation")
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

