//
//  NavigationView.swift
//  TODO
//
//  Created by Maxim Danilov on 5/24/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import UIKit
import SnapKit

class NavigationView: UIView {
    
    let leftButton: UIButton = UIButton()
    let rightButton: UIButton = UIButton()
    let titleLabel: UILabel = UILabel()
    var title: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        
        backgroundColor = .white
        
        addSubview(leftButton)
        leftButton.snp.makeConstraints { (make) in
            make.size.equalTo(44)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
        }
        
        addSubview(rightButton)
        rightButton.snp.makeConstraints { (make) in
            make.size.equalTo(44)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
        }
        
        addSubview(titleLabel)
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.heavyBody
        titleLabel.textColor = UIColor.dark
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.height.equalTo(leftButton)
            make.left.equalTo(leftButton.snp.right)
            make.right.equalTo(rightButton.snp.left)
        }
    }
    
    func apply(appearance: NavigationViewAppearance) {
        titleLabel.text = appearance.title
        if let leftNavAppearance = appearance.leftItemAppearance {
            leftButton.setImage(leftNavAppearance.navItemType.icon, for: .normal)
            if let closure = leftNavAppearance.closure {
                leftButton.onTap {
                    closure()
                }
            }
        }
        if let rightNavAppearance = appearance.rightItemAppearance {
            rightButton.setImage(rightNavAppearance.navItemType.icon, for: .normal)
            if let closure = rightNavAppearance.closure {
                rightButton.onTap {
                    closure()
                }
            }
        }
    }
}
