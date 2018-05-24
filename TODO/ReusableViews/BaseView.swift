//
//  BaseView.swift
//  TODO
//
//  Created by Maxim Danilov on 5/24/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import UIKit

class BaseView: UIView {
    let navigationView: NavigationView = NavigationView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        
        addSubview(navigationView)
        navigationView.snp.makeConstraints { (make) in
            make.height.equalTo(44)
            make.width.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin)
            make.left.equalTo(safeAreaLayoutGuide.snp.left)
            make.right.equalTo(safeAreaLayoutGuide.snp.right)
        }
    }
}
