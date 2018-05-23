//
//  NewTaskAnimator.swift
//  TODO
//
//  Created by Simon Kostenko on 5/23/18.
//  Copyright © 2018 Simon Kostenko. All rights reserved.
//

import UIKit

class NewTaskAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 1.0
    var presenting = true
    var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        let toView = transitionContext.view(forKey: .to)!
        
        let newTaskView = presenting ? toView : transitionContext.view(forKey: .from)!
        let projectView = presenting ? transitionContext.view(forKey: .from)! : toView
        
        
        containerView.addSubview(toView)
        toView.alpha = 0.0
        let hidingView = dismissView
        containerView.addSubview(hidingView)
        
        UIView.animate(withDuration: duration,
                       animations: {
//                        toView.alpha = 1.0
                        hidingView.frame.origin = CGPoint.init(x: 0, y: -30)
        },
                       completion: { _ in
                        transitionContext.completeTransition(true)
        }
        )
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
