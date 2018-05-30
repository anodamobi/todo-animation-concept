//
//  POPBasicAnimation+Ext.swift
//  Todo
//
//  Created by Maxim Danilov on 5/30/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import Foundation
import pop

extension POPBasicAnimation {
    
    static func alphaAnimation(duration: TimeInterval, hide: Bool = true) -> POPBasicAnimation? {
        let alphaAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        alphaAnimation?.fromValue = hide ? 1.0 : 0.0
        alphaAnimation?.toValue = hide ? 0.0 : 1.0
        alphaAnimation?.duration = duration
        return alphaAnimation
    }
    
    static func scaleAnimation(points: (from: CGPoint, to: CGPoint), duration: TimeInterval) -> POPBasicAnimation? {
        let scaleAnimation = POPBasicAnimation(propertyNamed: kPOPViewScaleXY)
        scaleAnimation?.fromValue = NSValue(cgPoint: points.from)
        scaleAnimation?.toValue = NSValue(cgPoint: points.to)
        scaleAnimation?.duration = duration
        return scaleAnimation
    }
    
    static func frameAnimation(duration: TimeInterval, frame: CGRect) -> POPBasicAnimation? {
        let frameAnimation = POPBasicAnimation(propertyNamed: kPOPViewFrame)
        frameAnimation?.toValue = NSValue(cgRect: frame)
        frameAnimation?.duration = duration
        return frameAnimation
    }
}
