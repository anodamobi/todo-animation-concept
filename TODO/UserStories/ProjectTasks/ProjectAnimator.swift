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

        let startFrame = CGRect(x: ProjectTasksConstants.margin, y: navigationViewFrame.maxY, width: width, height: height)
        let projectViewStartFrame = presentationStyle == .present ? originFrame : startFrame
        let projectView = createProjectView(frame: projectViewStartFrame)
        
        let endFrame = CGRect(x: ProjectTasksConstants.margin, y: navigationViewFrame.maxY, width: width, height: height)
        let projectViewEndFrame = presentationStyle == .present ? endFrame : originFrame
        let projectViewAnimation = POPBasicAnimation.frameAnimation(duration: duration, frame: projectViewEndFrame)
        projectView.pop_add(projectViewAnimation, forKey: AnimationKeyName.projectViewAnimation)
        containerView.addSubview(projectView)
        
        let moreButtonAnimation = POPBasicAnimation.alphaAnimation(duration: duration, hide: presentationStyle == .present)
        projectView.moreButton.pop_add(moreButtonAnimation, forKey: AnimationKeyName.moreButtonAnimation)

        taskView.projectView.isHidden = true
        taskView.layer.cornerRadius = 8.0
        taskView.clipsToBounds = true
        let containerViewFrame = presentationStyle == .present ? finalFrame : originFrame
        let containerViewAnimation = POPBasicAnimation.frameAnimation(duration: duration, frame: containerViewFrame)
        switch presentationStyle {
        case .present:
            animatePresentation(taskView: taskView)
            toView.pop_add(containerViewAnimation, forKey: AnimationKeyName.containerViewAnimation)
        case .dismiss:
            fromView.pop_add(containerViewAnimation, forKey: AnimationKeyName.containerViewAnimation)
            animateDismissal(taskView: taskView)
        }
        
        containerViewAnimation?.completionBlock = { (_, _) in
            projectView.removeFromSuperview()
            taskView.subviews.forEach { $0.isHidden = false }
            taskView.projectView.moreButton.isHidden = true
            toView.subviews.forEach { $0.isHidden = false }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    private func animatePresentation(taskView: ProjectTasksView) {
        taskView.newTaskButton.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        taskView.navigationView.alpha = 0.0
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: [], animations: {
            taskView.layer.cornerRadius = 0.0
            UIView.addKeyframe(withRelativeStartTime: 3/4, relativeDuration: 1/4) {
                taskView.newTaskButton.transform = .identity
                taskView.navigationView.alpha = 1.0
            }
        }, completion: nil)
    }
    
    private func animateDismissal(taskView: ProjectTasksView) {
        let navigationViewAnimation = POPBasicAnimation.alphaAnimation(duration: duration / 8)
        taskView.navigationView.pop_add(navigationViewAnimation, forKey: AnimationKeyName.navigationViewAnimation)
        let points = (from: CGPoint(x: 1, y: 1), to: CGPoint.zero)
        let taskButtonAnimation = POPBasicAnimation.scaleAnimation(points: points, duration: duration / 4)
        taskView.newTaskButton.pop_add(taskButtonAnimation, forKey: AnimationKeyName.taskButtonAnimation)
        let taskButtonAlphaAnimation = POPBasicAnimation.alphaAnimation(duration: duration / 4)
        taskView.newTaskButton.pop_add(taskButtonAlphaAnimation, forKey: AnimationKeyName.taskButtonAlphaAnimation)
    }
    
    private func createProjectView(frame: CGRect) -> ProjectView {
        let projectView = ProjectView(viewModel: projectViewModel)
        projectView.frame = frame
        projectView.backgroundColor = UIColor.white
        projectView.layer.cornerRadius = 8
        projectView.clipsToBounds = true
        return projectView
    }
}
