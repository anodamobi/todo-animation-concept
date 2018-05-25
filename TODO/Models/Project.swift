//
//  Project.swift
//  TODO
//
//  Created by Maxim Danilov on 5/24/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import UIKit

enum Project {
    case today
    case work
    case personal
    
    private static let todayBackground: UIImage = UIImage.originalSizeImage(withPDFNamed: R.file.background1Pdf.name)
    private static let personalBackground: UIImage = UIImage.originalSizeImage(withPDFNamed: R.file.background2Pdf.name)
    private static let workBackground: UIImage = UIImage.originalSizeImage(withPDFNamed: R.file.background3Pdf.name)
    
    private static let todayIcon: UIImage = UIImage.originalSizeImage(withPDFNamed: R.file.todayPdf.name)
    private static let personalIcon: UIImage = UIImage.originalSizeImage(withPDFNamed: R.file.personalPdf.name)
    private static let workIcon: UIImage = UIImage.originalSizeImage(withPDFNamed: R.file.workPdf.name)
    
    private static let outlineTodayIcon: UIImage = UIImage.originalSizeImage(withPDFNamed: R.file.today_outlinePdf.name)
    private static let outlinePersonalIcon: UIImage = UIImage.originalSizeImage(withPDFNamed: R.file.personal_outlinePdf.name)
    private static let outlineWorkIcon: UIImage = UIImage.originalSizeImage(withPDFNamed: R.file.work_outlinePdf.name)
    
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
    
    var outlineIcon: UIImage {
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
        set {
            switch self {
            case .today:
                Task.todayTasks.append(contentsOf: newValue)
            case .work:
                Task.workTasks.append(contentsOf: newValue)
            case .personal:
                Task.personalTasks.append(contentsOf: newValue)
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
