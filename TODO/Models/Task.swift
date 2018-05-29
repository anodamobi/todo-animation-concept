//
//  Task.swift
//  TODO
//
//  Created by Maxim Danilov on 5/25/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import Foundation

class Task {
    let title: String
    var startDate: Date = Date()
    var endDate: Date? = nil
    var isCompleted: Bool = false
    
    init(title: String) {
        self.title = title
    }
    
    init(title: String, startDate: Date, endDate: Date) {
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
    }
    
    convenience init(title: String, startDate: Date) {
        self.init(title: title)
        self.startDate = startDate
    }
    
    convenience init(title: String, endDate: Date) {
        self.init(title: title)
        self.endDate = endDate
    }
}
