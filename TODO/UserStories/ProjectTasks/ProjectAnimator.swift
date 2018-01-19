//
//  ProjectAnimator.swift
//  TODO
//
//  Created by ANODA on 1/17/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import UIKit
import pop

class ProjectTasksAnimator: NSObject, UIViewControllerAnimatedTransitioning, POPAnimationDelegate {
    
    var originFrame: CGRect = .zero
    let duration: TimeInterval = 2.0
    var isPresenting: Bool = true
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if isPresenting {
        
        guard let fromView = transitionContext.viewController(forKey: .from)?.view else { return }
        guard let toViewController = transitionContext.viewController(forKey: .to),
        let toView = transitionContext.viewController(forKey: .to)?.view,
        let taskView = (toViewController as? UINavigationController)?.visibleViewController?.view as? ProjectTasksView else { return }
        
        for subview in toView.subviews where subview is UINavigationBar {
            subview.alpha = 0.0
        }
        
        let finalFrame = transitionContext.finalFrame(for: toViewController)
        let containerView = transitionContext.containerView
       
        toView.frame = originFrame
        containerView.addSubview(toView)
        
        let projectView = ProjectView()
        projectView.frame = originFrame
//        projectView.frame = CGRect.init(origin: originFrame.origin,
//                                        size: taskView.projectView.frame.size)
//        projectView.transform = CGAffineTransform(scaleX: projectView.frame.size.width / originFrame.size.width,
//                                                  y: originFrame.size.height / projectView.frame.size.height)
        projectView.backgroundColor = UIColor.white
        projectView.layer.cornerRadius = 8
        projectView.clipsToBounds = true
        
        let anim = POPBasicAnimation(propertyNamed: kPOPViewFrame)
        anim?.toValue = NSValue(cgRect: CGRect(x: 0, y: 88, width: UIScreen.main.bounds.width, height: 135))
        anim?.duration = 2.0
        projectView.pop_add(anim, forKey: "ProjectViewAnimation")
        containerView.addSubview(projectView)
            
        
        
        //originFrame.origin
        
//        snap.frame = originFrame
//        snap.backgroundColor = UIColor.white
//        containerView.addSubview(snap)
        
        taskView.projectView.isHidden = true
//        toView.subviews.forEach { $0.isHidden = true }
        taskView.newTaskButton.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        //        taskView.newTaskButton.alpha = 0.0
        
            

            
        let an = POPBasicAnimation(propertyNamed: kPOPViewFrame)
        an?.toValue = NSValue(cgRect: finalFrame)
        an?.duration = 2.0
        an?.delegate = self
        
        let tbAnimation = POPBasicAnimation(propertyNamed: kPOPViewScaleXY)
        tbAnimation?.fromValue = NSValue.init(cgPoint: CGPoint.init(x: 0.1, y: 0.1))
        tbAnimation?.toValue = NSValue.init(cgPoint: CGPoint.init(x: 1, y: 1))
        tbAnimation?.duration = 1.5
        tbAnimation?.beginTime = CACurrentMediaTime() + 0.5
        taskView.tableView.pop_add(tbAnimation, forKey: "TBA")
        
            
//        if let snapshot = taskView.snapshotView(afterScreenUpdates: true) {
//            
//        snapshot.layer.cornerRadius = 8.0
//        snapshot.clipsToBounds = true
//        let cornerRadiusAnimation = POPBasicAnimation(propertyNamed: kPOPLayerCornerRadius)
//        cornerRadiusAnimation?.fromValue = 8.0
//        cornerRadiusAnimation?.fromValue = 0.0
//        cornerRadiusAnimation?.duration = duration
//        snapshot.pop_add(cornerRadiusAnimation, forKey: "cornerRadiusAnimation")
//        }
        
        an?.completionBlock = { (_, _) in
            projectView.removeFromSuperview()
            taskView.subviews.forEach { $0.isHidden = false }
            toView.subviews.forEach { $0.alpha = 1.0 }
            transitionContext.completeTransition(true)
        }
        toView.pop_add(an, forKey: "ContV")
            
            //            let a = POPBasicAnimation(propertyNamed: kPOPViewScaleXY)
            //            a?.fromValue = NSValue.init(cgPoint: CGPoint.init(x: 0.1, y: 0.1))
            //            a?.toValue = NSValue.init(cgPoint: CGPoint.init(x: 1, y: 1))
            //            a?.duration = 0.25
            //            a?.timingFunction = CAMediaTimingFunction.easeIn
            //            a?.completionBlock = { (_,_) in
            //                    transitionContext.completeTransition(true)
            //            }
            //            taskView.newTaskButton.pop_add(a, forKey: "TaskButton")
        
        UIView.animateKeyframes(withDuration: 2.0, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 3/4, relativeDuration: 1/4) {
                taskView.newTaskButton.transform = .identity
            }
        }, completion: { _ in
            
        })
        
//        UIView.animate(withDuration: self.duration, animations: {
//            toView.alpha = 1.0
//        }, completion: { (_) in
//            transitionContext.completeTransition(true)
//        })
        
        
//        UIView.animate(withDuration: duration/2, animations: {
////            snap.frame.origin = CGPoint(x: 0, y: 88)
//        }, completion: { (finished) -> Void in
//   //         snap.removeFromSuperview()
//            for subview in toView.subviews where subview is UINavigationBar {
//                subview.isHidden = false
//            }
//            UIView.animate(withDuration: self.duration/2, animations: {
//                toView.alpha = 1.0
//
//            }, completion: { (_) in
//                transitionContext.completeTransition(true)
//            })
//        })
        
        
        
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
        } else {
            guard let fromViewController = transitionContext.viewController(forKey: .from) else { return }
            guard let toViewController = transitionContext.viewController(forKey: .to),
                let toView = transitionContext.viewController(forKey: .to)?.view,
                let taskView = (fromViewController as? UINavigationController)?.visibleViewController?.view as? ProjectTasksView else { return }
            
            for subview in fromViewController.view.subviews where subview is UINavigationBar {
                subview.isHidden = true
            }
            
            let finalFrame = transitionContext.finalFrame(for: toViewController)
            let containerView = transitionContext.containerView
            
            toView.frame = finalFrame
            containerView.addSubview(toView)
            containerView.addSubview(fromViewController.view)
            
            let projectView = ProjectView()
            projectView.frame = CGRect.init(x: 0, y: 88, width: UIScreen.main.bounds.width, height: 135)
            projectView.backgroundColor = UIColor.white
            projectView.layer.cornerRadius = 8
            projectView.clipsToBounds = true
            
            let anim = POPBasicAnimation(propertyNamed: kPOPViewFrame)
            anim?.toValue = NSValue(cgRect: originFrame)
            anim?.duration = 2.0
            projectView.pop_add(anim, forKey: "ProjectViewAnimationDismiss")
            containerView.addSubview(projectView)
            
            let a = POPBasicAnimation(propertyNamed: kPOPViewScaleXY)
            a?.fromValue = NSValue.init(cgPoint: CGPoint.init(x: 1.0, y: 1.0))
            a?.toValue = NSValue.init(cgPoint: CGPoint.init(x: 0, y: 0))
            a?.duration = 0.25
            a?.timingFunction = CAMediaTimingFunction.easeIn
            taskView.newTaskButton.pop_add(a, forKey: "TaskButton")
            
//            let cornerRadiusAnimation = POPBasicAnimation(propertyNamed: kPOPLayerCornerRadius)
//            cornerRadiusAnimation?.fromValue = 0.0
//            cornerRadiusAnimation?.fromValue = 8.0
//            cornerRadiusAnimation?.duration = duration
//            fromViewController.view.pop_add(cornerRadiusAnimation, forKey: "cornerRadiusAnimation")
            
            
            let an = POPBasicAnimation(propertyNamed: kPOPViewFrame)
            an?.toValue = NSValue(cgRect: originFrame)
            an?.duration = 2.0
            an?.delegate = self
            
            let tbAnimation = POPBasicAnimation(propertyNamed: kPOPViewScaleXY)
            tbAnimation?.fromValue = NSValue.init(cgPoint: CGPoint.init(x: 1, y: 1))
            tbAnimation?.toValue = NSValue.init(cgPoint: CGPoint.init(x: 0, y: 0))
            tbAnimation?.duration = 1.5
            tbAnimation?.beginTime = CACurrentMediaTime() + 0.5
            taskView.tableView.pop_add(tbAnimation, forKey: "TBA")
            
            
            an?.completionBlock = { (_, _) in
                projectView.removeFromSuperview()
                taskView.subviews.forEach { $0.isHidden = false }
                toView.subviews.forEach { $0.isHidden = false }
                transitionContext.completeTransition(true)
                
                //            let a = POPBasicAnimation(propertyNamed: kPOPViewScaleXY)
                //            a?.fromValue = NSValue.init(cgPoint: CGPoint.init(x: 0.1, y: 0.1))
                //            a?.toValue = NSValue.init(cgPoint: CGPoint.init(x: 1, y: 1))
                //            a?.duration = 0.25
                //            a?.timingFunction = CAMediaTimingFunction.easeIn
                //            a?.completionBlock = { (_,_) in
                //                    transitionContext.completeTransition(true)
                //            }
                //            taskView.newTaskButton.pop_add(a, forKey: "TaskButton")
                
            }
            fromViewController.view.pop_add(an, forKey: "ContV")

        }
    }
    
}

extension ProjectTasksAnimator {
    func pop_animationDidReach(toValue anim: POPAnimation!) {
        guard let animation = anim as? POPBasicAnimation else { return }
        print("Current value \(animation.fromValue)")
    }
}
