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
    static let leftOffset: CGFloat = 40.0
    static let buttonSize: CGFloat = 44.0
}

class ProjectTasksView: UIView {
    let projectView: ProjectView = ProjectView()
    let tableView: UITableView = UITableView()
    let newTaskButton: UIButton = UIButton()
    let cancelButton: UIButton = UIButton()
    let navigationView: UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = UIColor.white
        
        navigationView.backgroundColor = UIColor.white
        addSubview(navigationView)
        navigationView.snp.makeConstraints { (make) in
            make.height.equalTo(44)
            make.width.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.equalTo(safeAreaLayoutGuide.snp.left)
            make.right.equalTo(safeAreaLayoutGuide.snp.right)
        }
        
        navigationView.addSubview(cancelButton)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(UIColor.black, for: .normal)
        cancelButton.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(44)
        }
        
        addSubview(projectView)
        projectView.snp.makeConstraints { (make) in
            make.top.equalTo(navigationView.snp.bottom)
            make.left.equalTo(safeAreaLayoutGuide.snp.left)
            make.right.equalTo(safeAreaLayoutGuide.snp.right)
            make.height.equalTo(135)
        }
        
        addSubview(tableView)
        let leftOffset = ProjectTasksConstants.rowHeight + ProjectTasksConstants.leftOffset
        tableView.separatorInset = UIEdgeInsetsMake(0, leftOffset, 0, 0)
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
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-100)
        }
    }
}
