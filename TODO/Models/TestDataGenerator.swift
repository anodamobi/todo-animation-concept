//
//  TestDataGenerator.swift
//  Todo
//
//  Created by Simon Kostenko on 5/29/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import Foundation

class TestDataGenerator {
    
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
