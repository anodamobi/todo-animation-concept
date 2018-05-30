//
//  Double+Ext.swift
//  Todo
//
//  Created by Maxim Danilov on 5/24/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import Foundation
import UIKit

extension Double {
    
    var verticalProportional: Double {
        return ( self * Double(UIScreen.main.bounds.height)) / 812.0
    }
}
