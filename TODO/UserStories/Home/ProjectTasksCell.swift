//
//  ProjectTasksCell.swift
//  TODO
//
//  Created by Simon Kostenko on 1/16/18.
//  Copyright © 2018 Simon Kostenko. All rights reserved.
//

import UIKit
import ANODA_Alister

class ProjectTasksCell: ANCollectionViewCell {
    
    let projectTasksView = ProjectTasksView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        backgroundColor = UIColor.white
        layer.cornerRadius = 8
        clipsToBounds = true
        
        
        addSubview(projectTasksView)
        projectTasksView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
//        backgroundView = UIView.init(frame: CGRect.zero)
//        backgroundView?.backgroundColor = UIColor.phPaleGreyTwo
//        selectedBackgroundView = backgroundView
    }
    
}
