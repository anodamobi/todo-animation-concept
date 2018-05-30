//
//  Date+Ext.swift
//  Todo
//
//  Created by Maxim Danilov on 5/25/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import Foundation

extension Date {
    static let dateFormatter: DateFormatter = DateFormatter()
    
    var longDateFormatted: String {
        Date.dateFormatter.dateStyle = .long
        Date.dateFormatter.timeStyle = .none
        return Date.dateFormatter.string(from: self)
    }
}
