/*
  The MIT License (MIT)￼
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
                return TestDataGenerator.todayTasks
            case .personal:
                return TestDataGenerator.personalTasks
            case .work:
                return TestDataGenerator.workTasks
            }
        }
        set {
            switch self {
            case .today:
                TestDataGenerator.todayTasks.append(contentsOf: newValue)
            case .work:
                TestDataGenerator.workTasks.append(contentsOf: newValue)
            case .personal:
                TestDataGenerator.personalTasks.append(contentsOf: newValue)
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
