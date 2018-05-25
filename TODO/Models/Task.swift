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
    
    static var todayTasks: [Task] = [Task(title: "Meet Clients"),
                                     Task(title: "Weekly Report"),
                                     Task(title: "HTML/CSS Study", endDate: Date(timeIntervalSinceNow: 48 * 3600)),
                                     Task(title: "Design Meeting"),
                                     Task(title: "Quick Prototyping", endDate: Date(timeIntervalSinceNow: 24 * 3600))]
    
    static var workTasks: [Task] = [Task(title: "Create custom transition"),
                                    Task(title: "Upload build for beta testing", endDate: Date(timeIntervalSinceNow: 18 * 3600)),
                                    Task(title: "Create merge request"),
                                    Task(title: "Integrate third party library", endDate: Date(timeIntervalSinceNow: 40 * 3600))]
    
    static var personalTasks: [Task] = [Task(title: "Buy cheese"), Task(title: "Watch TV")]
}
