/*
 The MIT License (MIT)
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

enum NavItemType {
    case burger
    case search
    case back
    case cancel
    case more
    
    private static let moreIcon = UIImage.originalSizeImage(withPDFNamed: R.file.navigationDotsPdf.name)
    private static let crossIcon = UIImage.originalSizeImage(withPDFNamed: R.file.crossPdf.name)
    private static let burgerIcon = UIImage.originalSizeImage(withPDFNamed: R.file.burgerPdf.name)
    private static let searchIcon = UIImage.originalSizeImage(withPDFNamed: R.file.searchPdf.name)
    private static let backIcon = UIImage.originalSizeImage(withPDFNamed: R.file.backPdf.name)
    
    var icon: UIImage? {
        switch self {
        case .burger:
            return NavItemType.burgerIcon
        case .search:
            return NavItemType.searchIcon
        case .back:
            return NavItemType.backIcon
        case .cancel:
            return NavItemType.crossIcon
        case .more:
            return NavItemType.moreIcon
        }
    }
}

struct NavigationViewAppearance {
    
    typealias NavItemAppearance = (navItemType: NavItemType, closure:(() -> Void)?)
    
    let title: String
    let leftItemAppearance: NavItemAppearance?
    let rightItemAppearance: NavItemAppearance?
    
    init(title: String = "", leftItemAppearance: NavItemAppearance? = nil, rightItemAppearance: NavItemAppearance? = nil) {
        self.title = title
        self.leftItemAppearance = leftItemAppearance
        self.rightItemAppearance = rightItemAppearance
    }
}
