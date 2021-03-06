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
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewLayout.flowLayout)
    
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
        
        let navigationAppearance = NavigationViewAppearance(title: Localizable.homeTitle(),
                                                            leftItemAppearance: (navItemType: .burger, closure: nil),
                                                            rightItemAppearance: (navItemType: .search, closure: nil))
        navigationView.apply(appearance: navigationAppearance)
        navigationView.titleLabel.textColor = .white
        navigationView.backgroundColor = .clear
        
        addSubview(avatarImageView)
        avatarImageView.setImage(R.image.avatar())
        avatarImageView.layer.cornerRadius = 35.0
        avatarImageView.snp.makeConstraints { (make) in
            make.size.equalTo(70)
            make.left.equalToSuperview().offset(32)
            make.top.equalTo(navigationView.snp.bottom).offset(37.0.verticalProportional)
        }
        
        addSubview(helloLabel)
        helloLabel.text = Localizable.homeWelcomeMessage("Megan")
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
        todayInfoLabel.text = Localizable.homeStatusMessage(Project.today.tasks.count)
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
            make.height.equalTo(UIScreen.main.bounds.height * 0.401)
            make.bottom.equalToSuperview().offset(-72.0.verticalProportional)
        }
        
        addSubview(todayDateLabel)
        todayDateLabel.textColor = .white
        todayDateLabel.font = UIFont.heavySubnote
        todayDateLabel.text = Localizable.homeToday(Date().longDateFormatted.uppercased())
        todayDateLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(collectionView.snp.top).offset(-8.0.verticalProportional)
            make.left.equalTo(helloLabel)
        }
        setupGestures()
    }
    
    // MARK: - Gestures
    
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
        let currentProjectX = collectionView.contentOffset.x + collectionView.frame.width / 2
        let currentProjectY = collectionView.frame.height / 2
        return collectionView.indexPathForItem(at: CGPoint(x: currentProjectX, y: currentProjectY))
    }
    
    private func scrollToProject(at indexPath: IndexPath) {
        if collectionView.cellForItem(at: indexPath) != nil {
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            appearanceChangingClosure?(indexPath)
        }
    }
}
