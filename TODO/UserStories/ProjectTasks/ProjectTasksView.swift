//
//  ProjectTasksView.swift
//  TODO
//
//  Created by ANODA on 1/16/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import UIKit
import SnapKit
import ANODA_Alister
import Hero

struct ProjectTasksConstants {
    static let rowHeight: CGFloat = 44.0
    static let sectionHeaderHeight: CGFloat = 44.0
    static let margin: CGFloat = 20.0
    static let buttonSize: CGFloat = 54.0
    static let projectViewHeight: Int = 200
}

class ProjectTasksView: BaseView {
    let projectView: ProjectView = ProjectView()
    let tableView: UITableView = UITableView()
    let newTaskButton: UIButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        backgroundColor = .white
        
        let back = UIImage.originalSizeImage(withPDFNamed: "back")
        navigationView.leftButton.setImage(back, for: .normal)
        let navigationDots = UIImage.originalSizeImage(withPDFNamed: "navigationDots")
        navigationView.rightButton.setImage(navigationDots, for: .normal)
        navigationView.backgroundColor = .white
        
        addSubview(projectView)
        projectView.snp.makeConstraints { (make) in
            make.top.equalTo(navigationView.snp.bottom)
            make.left.equalTo(safeAreaLayoutGuide.snp.left).offset(ProjectTasksConstants.margin)
            make.right.equalTo(safeAreaLayoutGuide.snp.right).offset(-ProjectTasksConstants.margin)
            make.height.equalTo(ProjectTasksConstants.projectViewHeight)
        }
        
        addSubview(tableView)
        tableView.rowHeight = ProjectTasksConstants.rowHeight
        tableView.sectionHeaderHeight = ProjectTasksConstants.sectionHeaderHeight
        tableView.snp.makeConstraints { (make) in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(safeAreaLayoutGuide.snp.left)
            make.right.equalTo(safeAreaLayoutGuide.snp.right)
            make.top.equalTo(projectView.snp.bottom)
        }
        
        insertSubview(newTaskButton, aboveSubview: tableView)
        newTaskButton.clipsToBounds = true
        newTaskButton.layer.cornerRadius = ProjectTasksConstants.buttonSize / 2.0
        newTaskButton.backgroundColor = UIColor(red: 0.36, green: 0.55, blue: 0.89, alpha: 1.00)
        newTaskButton.setTitle("＋", for: .normal)
        newTaskButton.setTitleColor(UIColor.white, for: .normal)
        newTaskButton.snp.makeConstraints { (make) in
            make.size.equalTo(ProjectTasksConstants.buttonSize)
            make.right.equalToSuperview().offset(-22)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-80.0.verticalProportional)
        }
    }
}
