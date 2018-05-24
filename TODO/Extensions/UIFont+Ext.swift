//
//  UIFont+Ext.swift
//  TODO
//
//  Created by Maxim Danilov on 5/23/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import UIKit

extension UIFont {
    
    private struct Name {
        static let avenirMedium = "Avenir-Medium"
        static let avenirRoman = "Avenir-Roman"
        static let avenirHeavy = "Avenir-Heavy"
    }
    
    class var mediumTitle: UIFont? {
        return UIFont(name: UIFont.Name.avenirMedium, size: 24.0)
    }
    
    class var romanTitle: UIFont? {
        return UIFont(name: UIFont.Name.avenirRoman, size: 24.0)
    }
    
    class var romanBody: UIFont? {
        return UIFont(name: UIFont.Name.avenirRoman, size: 17.0)
    }
    
    class var heavySubnote: UIFont? {
        return UIFont(name: UIFont.Name.avenirHeavy, size: 13.0)
    }
    
    class var romanSubnote: UIFont? {
        return UIFont(name: UIFont.Name.avenirRoman, size: 13.0)
    }
    
    class var romanFootnote: UIFont? {
        return UIFont(name: UIFont.Name.avenirRoman, size: 11.0)
    }
    
    class var heavyBody: UIFont? {
        return UIFont(name: UIFont.Name.avenirHeavy, size: 17.0)
    }
}
