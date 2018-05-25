//
//  HomeView.swift
//  TODO
//
//  Created by Simon Kostenko on 1/16/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import UIKit
import SnapKit
import UIImagePDF

private enum SwipeDirection {
    case left
    case right
}

class HomeView: BaseView {
    
    let backgroundImageView: UIImageView = UIImageView()
    let avatarImageView = UIImageView()
    let helloLabel = UILabel()
    let todayInfoLabel = UILabel()
    let todayDateLabel = UILabel()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout())
    
    var appearanceChangingClosure: ((IndexPath) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        insertSubview(backgroundImageView, at: 0)
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        let burger = UIImage.originalSizeImage(withPDFNamed: "burger")
        navigationView.leftButton.setImage(burger, for: .normal)
        let search = UIImage.originalSizeImage(withPDFNamed: "search")
        navigationView.rightButton.setImage(search, for: .normal)
        navigationView.title = "TODO"
        navigationView.titleLabel.textColor = .white
        
        addSubview(avatarImageView)
        avatarImageView.setImage(#imageLiteral(resourceName: "avatar"))
        avatarImageView.layer.cornerRadius = 35.0
        avatarImageView.snp.makeConstraints { (make) in
            make.size.equalTo(70)
            make.left.equalToSuperview().offset(32)
            make.top.equalTo(navigationView.snp.bottom).offset(37.0.verticalProportional)
        }
        
        addSubview(helloLabel)
        helloLabel.text = "Hello, Megan."
        helloLabel.font = UIFont.mediumTitle
        helloLabel.textColor = .white
        helloLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(44)
            make.top.equalTo(avatarImageView.snp.bottom).offset(34.0.verticalProportional)
        }
        
        addSubview(todayInfoLabel)
        todayInfoLabel.numberOfLines = 0
        todayInfoLabel.font = UIFont.romanBody
        todayInfoLabel.textColor = .white
        todayInfoLabel.text = "Looks like feel good.\nYou have 3 tasks to do today."
        todayInfoLabel.snp.makeConstraints { (make) in
            make.left.equalTo(helloLabel)
            make.top.equalTo(helloLabel.snp.bottom).offset(16.0.verticalProportional)
        }
        
        addSubview(collectionView)
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height * 0.40)
            make.bottom.equalToSuperview().offset(-72.0.verticalProportional)
        }
        
        addSubview(todayDateLabel)
        todayDateLabel.textColor = .white
        todayDateLabel.font = UIFont.heavySubnote
        todayDateLabel.text = "TODAY: SEPTEMBER 12, 2017"
        todayDateLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(collectionView.snp.top).offset(-8.0.verticalProportional)
            make.left.equalTo(helloLabel)
        }
        
        setupGestures()
    }
    
    //MARK: - Gestures -
    
    private func setupGestures() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft(_:)))
        swipeLeft.direction = .left
        collectionView.addGestureRecognizer(swipeLeft)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight(_:)))
        swipeRight.direction = .right
        collectionView.addGestureRecognizer(swipeRight)
    }
    
    @objc private func swipeLeft(_ gestureRecognizer: UISwipeGestureRecognizer) {
        swipeTo(.left)
    }
    
    @objc private func swipeRight(_ gestureRecognizer: UISwipeGestureRecognizer) {
        swipeTo(.right)
    }
    
    private func swipeTo(_ direction: SwipeDirection) {
        if let indexPath = currentProjectIndexPath() {
            let row = indexPath.row + ( direction == .left ? 1 : -1 )
            let nextIndexPath = IndexPath(row: row, section: indexPath.section)
            scrollToProject(at: nextIndexPath)
        }
    }
    
    private func currentProjectIndexPath() -> IndexPath? {
        let x = collectionView.contentOffset.x + collectionView.frame.width / 2
        let y = collectionView.frame.height / 2
        return collectionView.indexPathForItem(at: CGPoint(x: x, y: y))
    }
    
    private func scrollToProject(at indexPath: IndexPath) {
        if collectionView.cellForItem(at: indexPath) != nil {
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            appearanceChangingClosure?(indexPath)
        }
    }
    
    //MARK: - Collection View Layout -
    
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
        let height = UIScreen.main.bounds.height * 0.399
        
        return CGSize(width: width, height: height)
    }
}
