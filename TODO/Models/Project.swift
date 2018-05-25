//
//  Project.swift
//  TODO
//
//  Created by Maxim Danilov on 5/24/18.
//  Copyright © 2018 Simon Kostenko. All rights reserved.
//

import UIKit

enum Project {
    case today
    case work
    case personal
    
    private static let todayBackground: UIImage = UIImage.originalSizeImage(withPDFNamed: "background1")
    private static let personalBackground: UIImage = UIImage.originalSizeImage(withPDFNamed: "background2")
    private static let workBackground: UIImage = UIImage.originalSizeImage(withPDFNamed: "background3")
    
    private static let todayIcon: UIImage = UIImage.originalSizeImage(withPDFNamed: "today")
    private static let personalIcon: UIImage = UIImage.originalSizeImage(withPDFNamed: "personal")
    private static let workIcon: UIImage = UIImage.originalSizeImage(withPDFNamed: "work")
    
    private static let outlineTodayIcon: UIImage = UIImage.originalSizeImage(withPDFNamed: "today_outline")
    private static let outlinePersonalIcon: UIImage = UIImage.originalSizeImage(withPDFNamed: "personal_outline")
    private static let outlineWorkIcon: UIImage = UIImage.originalSizeImage(withPDFNamed: "work_outline")
    
    var name: String {
        return "\(self)".capitalized
    }
    
    var progress: Double {
        switch self {
        case .personal:
            return 0.89
        case .work:
            return 0.24
        case .today:
            return 0.52
        }
    }
    
    var background: UIImage? {
        switch self {
        case .today:
            return Project.todayBackground
        case .personal:
            return Project.personalBackground
        case .work:
            return Project.workBackground
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .today:
            return Project.todayIcon
        case .personal:
            return Project.personalIcon
        case .work:
            return Project.workIcon
        }
    }
    
    var outlineIcon: UIImage? {
        switch self {
        case .today:
            return Project.outlineTodayIcon
        case .personal:
            return Project.outlinePersonalIcon
        case .work:
            return Project.outlineWorkIcon
        }
    }
    
    var tasks: [Task] {
        get {
            switch self {
            case .today:
                return Task.todayTasks
            case .personal:
                return Task.personalTasks
            case .work:
                return Task.workTasks
            }
        }
    }
    
    var styleColor: UIColor {
        switch self {
        case .today:
            return UIColor.darkSkyBlue
        case .personal:
            return UIColor.fadedRed
        case .work:
            return UIColor.bluishPurple
        }
    }
    
    static let projects: [Project] = [.today, .personal, .work]
}
