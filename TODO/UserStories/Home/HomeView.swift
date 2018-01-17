//
//  HomeView.swift
//  TODO
//
//  Created by Simon Kostenko on 1/16/18.
//  Copyright © 2018 Simon Kostenko. All rights reserved.
//

import UIKit
import SnapKit

class HomeView: UIView {
    
    let avatarImageView = UIImageView()
    let helloLabel = UILabel()
    let todayInfoLabel = UILabel()
    
    let todayDateLabel = UILabel()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout())
//    let collectionView = UICollectionView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        
        backgroundColor = UIColor.green
        
        addSubview(avatarImageView)
        avatarImageView.backgroundColor = UIColor.gray
        avatarImageView.layer.cornerRadius = 15.0
        avatarImageView.snp.makeConstraints { (make) in
            make.size.equalTo(30)
            make.left.equalToSuperview().offset(25)
            make.top.equalToSuperview().offset(80)
        }
        
        addSubview(helloLabel)
        helloLabel.text = "Hello, Jane"
        helloLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(25)
            make.top.equalTo(avatarImageView.snp.bottom).offset(25)
        }
        
        
        addSubview(collectionView)
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor.blue
        collectionView.snp.makeConstraints { (make) in
            make.width.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.45)
            make.bottom.equalToSuperview().offset(-50)
        }
    }
    
    static private func collectionLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 40.0, bottom: 0.0, right: 40.0)
        layout.minimumLineSpacing = 20
        layout.itemSize = collectionItemSize()
        
        return layout
    }
    
    static private func collectionItemSize() -> CGSize {
        
        let width = UIScreen.main.bounds.width - 80.0
        let height = width
        
        return CGSize(width: width, height: height)
    }
}
