//
//  NavigationView+Style.swift
//  Todo
//
//  Created by Maxim Danilov on 5/25/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

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
