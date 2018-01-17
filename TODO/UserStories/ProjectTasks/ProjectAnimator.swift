//
//  ProjectAnimator.swift
//  TODO
//
//  Created by ANODA on 1/17/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import UIKit

class ProjectTasksAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var originFrame: CGRect = .zero
    let duration: TimeInterval = 1.0
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.viewController(forKey: .from)?.view else { return }
        guard let toViewController = transitionContext.viewController(forKey: .to),
            let toView = transitionContext.viewController(forKey: .to)?.view,
            let taskView = (toViewController as? UINavigationController)?.visibleViewController?.view as? ProjectTasksView else { return }
        
        for subview in toView.subviews where subview is UINavigationBar {
            subview.isHidden = true
        }
        
        let finalFrame = transitionContext.finalFrame(for: toViewController)
        let containerView = transitionContext.containerView
        
        
        let backgroundView = UIView()
        backgroundView.frame = originFrame
        backgroundView.backgroundColor = UIColor.white
        backgroundView.layer.cornerRadius = 8
        backgroundView.clipsToBounds = true
        containerView.addSubview(backgroundView)
        
        toView.frame = finalFrame
        guard let snapshot = toView.resizableSnapshotView(from: finalFrame,
                                                          afterScreenUpdates: true,
                                                          withCapInsets: .zero) else { return }
        
        ///Getting project view from subviews, cause presenting with UINavigationController
        guard let snap = toView.subviews[0].subviews[0].subviews[0].subviews[0].resizableSnapshotView(from: taskView.projectView.frame,
                                                                                     afterScreenUpdates: true,
                                                                                     withCapInsets: .zero) else { return }
        
        
        ///Template view to animate
        //        let projectView = ProjectView()
        //        projectView.frame = originFrame
        //        projectView.frame = CGRect.init(origin: originFrame.origin,
        //                                        size: taskView.projectView.frame.size)
        //        projectView.transform = CGAffineTransform(scaleX: projectView.frame.size.width / originFrame.size.width,
        //                                                  y: originFrame.size.height / projectView.frame.size.height)
        //        projectView.backgroundColor = UIColor.white
        //        projectView.layer.cornerRadius = 8
        //        projectView.clipsToBounds = true
        //        containerView.addSubview(projectView)
        
        //originFrame.origin
        
        snap.frame = originFrame
        snap.backgroundColor = UIColor.white
        containerView.addSubview(snap)
        containerView.addSubview(toView)
        
        toView.alpha = 0.0
        //        taskView.newTaskButton.transform = CGAffineTransform(scaleX: 0, y: 0)
        //        taskView.newTaskButton.alpha = 0.0
        
        
        UIView.animate(withDuration: duration/2, animations: {
            snap.frame.origin = CGPoint(x: 0, y: 88)
        }, completion: { (finished) -> Void in
            snap.removeFromSuperview()
            
            UIView.animate(withDuration: self.duration/2, animations: {
                toView.alpha = 1.0
            }, completion: { (_) in
                transitionContext.completeTransition(true)
            })
        })
        
        
        
        //        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
        //            toView.alpha = 1.0
        //    //        toView.transform = CGAffineTransform.identity
        //
        ////            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1, animations: {
        ////
        ////            })
        //
        //
        //            UIView.addKeyframe(withRelativeStartTime: 3.0/4.0, relativeDuration: 1.0/4.0, animations: {
        //                taskView.newTaskButton.transform = .identity
        //                taskView.newTaskButton.alpha = 1.0
        //            })
        //
        //        }) { (_) in
        //            transitionContext.completeTransition(true)
        //        }
        
        //        UIView.animate(withDuration: duration / 2, animations: {
        ////            projectView.transform = CGAffineTransform(scaleX: UIScreen.main.bounds.size.width / projectView.bounds.size.width,
        ////                                                      y: taskView.projectView.bounds.size.height * 1.5 / projectView.bounds.size.height)
        ////            projectView.frame.origin = CGPoint(x: 0.0, y: 88.0)
        ////            projectView.setNeedsLayout()
        //            backgroundView.transform = CGAffineTransform(scaleX: finalFrame.size.width / 295,
        //                                                         y: finalFrame.size.height / backgroundView.frame.size.height)
        //        }, completion: { _ in
        //            UIView.animateKeyframes(withDuration: self.duration / 2, delay: 0, options: [], animations: {
        //                toView.alpha = 1.0
        //
        //                UIView.addKeyframe(withRelativeStartTime: 3.0/4.0, relativeDuration: 1.0/4.0, animations: {
        //                    taskView.newTaskButton.transform = .identity
        //                    taskView.newTaskButton.alpha = 1.0
        //                })
        //
        //            }) { (_) in
        //                backgroundView.removeFromSuperview()
        ////                projectView.removeFromSuperview()
        //                transitionContext.completeTransition(true)
        //            }
        //        })
    }
    
}
