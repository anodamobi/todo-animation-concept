//
//  Constants.swift
//  TODO
//
//  Created by Maxim Danilov on 5/25/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import UIKit

typealias Localizable = R.string.localizable

struct CollectionViewLayout {
    
    private static let offset: CGFloat = 40
    private static let itemWidth = UIScreen.main.bounds.width - offset * 2
    private static let itemHeight = UIScreen.main.bounds.height * 0.4
    
    static var flowLayout: UICollectionViewFlowLayout {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: offset, bottom: 0.0, right: offset)
        layout.minimumLineSpacing = offset / 2.0
        layout.itemSize = itemSize()
        
        return layout
    }
    
    static private func itemSize() -> CGSize {
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

