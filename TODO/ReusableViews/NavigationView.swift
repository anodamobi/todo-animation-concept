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
        addSubview(leftButton)
        leftButton.snp.makeConstraints { (make) in
            make.size.equalTo(44)
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(20)
        }
        
        addSubview(rightButton)
        rightButton.snp.makeConstraints { (make) in
            make.size.equalTo(44)
            make.top.bottom.equalTo(leftButton)
            make.right.equalToSuperview().offset(-20)
        }
        
        addSubview(titleLabel)
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.heavyBody
        titleLabel.textColor = UIColor.dark
        titleLabel.snp.makeConstraints { (make) in
            make.top.bottom.height.equalTo(leftButton)
            make.left.equalTo(leftButton.snp.right)
            make.right.equalTo(rightButton.snp.left)
        }
    }
}
