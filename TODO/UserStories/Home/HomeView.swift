//
//  HomeView.swift
//  TODO
//
//  Created by Simon Kostenko on 1/16/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import UIKit
import SnapKit

class HomeView: UIView {
    
    let avatarImageView = UIImageView()
    let helloLabel = UILabel()
    let todayInfoLabel = UILabel()
    
    let todayDateLabel = UILabel()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        
        addSubview(avatarImageView)
        avatarImageView.image = #imageLiteral(resourceName: "avatar")
        avatarImageView.layer.cornerRadius = 35.0
        avatarImageView.snp.makeConstraints { (make) in
            make.size.equalTo(70)
            make.left.equalToSuperview().offset(32)
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin).offset(37)
        }
        
        addSubview(helloLabel)
        helloLabel.text = "Hello, Megan."
        helloLabel.font = UIFont.mediumTitle
        helloLabel.textColor = .white
        helloLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(44)
            make.top.equalTo(avatarImageView.snp.bottom).offset(34)
        }
        
        addSubview(todayInfoLabel)
        todayInfoLabel.numberOfLines = 0
        todayInfoLabel.font = UIFont.romanBody
        todayInfoLabel.textColor = .white
        todayInfoLabel.text = "Looks like feel good.\nYou have 3 tasks to do today."
        todayInfoLabel.snp.makeConstraints { (make) in
            make.left.equalTo(helloLabel)
            make.top.equalTo(helloLabel.snp.bottom).offset(16)
        }
        
        addSubview(collectionView)
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height * 0.45)
            make.bottom.equalToSuperview().offset(-UIScreen.main.bounds.height * 0.1)
        }
        
        addSubview(todayDateLabel)
        todayDateLabel.textColor = .white
        todayDateLabel.font = UIFont.heavySubnote
        todayDateLabel.text = "TODAY: SEPTEMBER 12, 2017"
        todayDateLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(collectionView.snp.top).offset(-8)
            make.left.equalToSuperview().offset(40)
        }
    }
    
    static private func collectionLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 40.0, bottom: 0.0, right: 40.0)
        layout.minimumLineSpacing = 20.0
        layout.itemSize = collectionItemSize()
        
        return layout
    }
    
    static private func collectionItemSize() -> CGSize {
        
        let width = UIScreen.main.bounds.width - 80.0
        let height = UIScreen.main.bounds.height * 0.45
        
        return CGSize(width: width, height: height)
    }
}
