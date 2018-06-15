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
