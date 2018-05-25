//
//  String+Ext.swift
//  TODO
//
//  Created by Maxim Danilov on 5/25/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import Foundation

extension String {
 
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
