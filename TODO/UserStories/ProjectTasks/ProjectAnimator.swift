//
//  ProjectAnimator.swift
//  Todo
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
    
    private struct AnimationKeyName {
        static let projectViewAnimation = "projectViewAnimation"
        static let moreButtonAnimation = "moreButtonAnimation"
        static let containerViewAnimation = "containerViewAnimation"
        static let navigationViewAnimation = "navigationViewAnimation"
        static let taskButtonAnimation = "taskButtonAnimation"
        static let taskButtonAlphaAnimation = "taskButtonAlphaAnimation"
    }
    
    private let originFrame: CGRect
    private let duration: TimeInterval
    private let presentationStyle: PresentationStyle
    private let projectViewModel: ProjectTasksViewModel
    
    init(duration: TimeInterval, presentationStyle: PresentationStyle,
         originFrame: CGRect, project: Project) {
        self.duration = duration
        self.presentationStyle = presentationStyle
        self.originFrame = originFrame
        self.projectViewModel = ProjectTasksViewModel(project: project)
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toViewController = transitionContext.viewController(forKey: .to),
        let toView = transitionContext.viewController(forKey: .to)?.view,
        let fromView = transitionContext.viewController(forKey: .from)?.view,
        let taskView = (presentationStyle == .present ? toView : fromView) as? ProjectTasksView,
        let navigationView = (fromView as? BaseView)?.navigationView  else { return }
        
        let navigationViewFrame = navigationView.superview?.convert(navigationView.frame, to: nil) ?? CGRect.zero
        let width = presentationStyle == .present ? originFrame.width + ProjectTasksConstants.margin * 2 :
                                                    taskView.projectView.bounds.width
        let height = CGFloat(ProjectTasksConstants.projectViewHeight)
        
        let finalFrame = transitionContext.finalFrame(for: toViewController)
        let containerView = transitionContext.containerView
        toView.frame = presentationStyle == .present ? originFrame : finalFrame
        containerView.addSubview(toView)
        if presentationStyle == .dismiss {
            containerView.addSubview(fromView)
        }

        let projectViewStartFrame = presentationStyle == .present ? originFrame : CGRect(x: ProjectTasksConstants.margin,
                                                                                         y: navigationViewFrame.maxY,
                                                                                         width: width, height: height)
        let projectView = ProjectView(viewModel: projectViewModel)
        projectView.frame = projectViewStartFrame
        projectView.backgroundColor = UIColor.white
        projectView.layer.cornerRadius = 8
        projectView.clipsToBounds = true
        
        let projectViewAnimation = POPBasicAnimation(propertyNamed: kPOPViewFrame)
        let projectViewEndFrame = presentationStyle == .present ? CGRect(x: ProjectTasksConstants.margin,
                                                                         y: navigationViewFrame.maxY,
                                                                         width: width, height: height) : originFrame
        projectViewAnimation?.toValue = NSValue(cgRect: projectViewEndFrame)
        projectViewAnimation?.duration = duration
        projectView.pop_add(projectViewAnimation, forKey: AnimationKeyName.projectViewAnimation)
        containerView.addSubview(projectView)
        
        let moreButtonAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        moreButtonAnimation?.toValue = presentationStyle == .present ? 0.0 : 1.0
        moreButtonAnimation?.fromValue = presentationStyle == .present ? 1.0 : 0.0
        moreButtonAnimation?.duration = duration
        projectView.moreButton.pop_add(moreButtonAnimation, forKey: AnimationKeyName.moreButtonAnimation)

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
            toView.pop_add(containerViewAnimation, forKey: AnimationKeyName.containerViewAnimation)
            UIView.animateKeyframes(withDuration: duration, delay: 0, options: [], animations: {
                taskView.layer.cornerRadius = 0.0
                UIView.addKeyframe(withRelativeStartTime: 3/4, relativeDuration: 1/4) {
                    taskView.newTaskButton.transform = .identity
                    taskView.navigationView.alpha = 1.0
                }
            }, completion: nil)
        case .dismiss:
            fromView.pop_add(containerViewAnimation, forKey: AnimationKeyName.containerViewAnimation)
            
            let navigationViewAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
            navigationViewAnimation?.fromValue = 1.0
            navigationViewAnimation?.toValue = 0.0
            navigationViewAnimation?.duration = duration / 8
            taskView.navigationView.pop_add(navigationViewAnimation, forKey: AnimationKeyName.navigationViewAnimation)
            
            let taskButtonAnimation = POPBasicAnimation(propertyNamed: kPOPViewScaleXY)
            taskButtonAnimation?.fromValue = NSValue(cgPoint: CGPoint(x: 1.0, y: 1.0))
            taskButtonAnimation?.toValue = NSValue(cgPoint: .zero)
            taskButtonAnimation?.duration = duration / 4
            taskView.newTaskButton.pop_add(taskButtonAnimation, forKey: AnimationKeyName.taskButtonAnimation)
            
            let taskButtonAlphaAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
            taskButtonAlphaAnimation?.fromValue = 1.0
            taskButtonAlphaAnimation?.toValue = 0.0
            taskButtonAlphaAnimation?.duration = duration / 4
            taskView.newTaskButton.pop_add(taskButtonAlphaAnimation, forKey: AnimationKeyName.taskButtonAlphaAnimation)
        }
        
        containerViewAnimation?.completionBlock = { (_, _) in
            projectView.removeFromSuperview()
            taskView.subviews.forEach { $0.isHidden = false }
            taskView.projectView.moreButton.isHidden = true
            toView.subviews.forEach { $0.isHidden = false }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
