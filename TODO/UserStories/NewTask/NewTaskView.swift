//
//  NewTaskView.swift
//  TODO
//
//  Created by ANODA on 1/29/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import UIKit

class NewTaskView: UIView {
    
    private let detailsLabel: UILabel = UILabel()
    let navigationView: UIView = UIView()
    let cancelButton: UIButton = UIButton()
    let taskDetailsTextView: UITextView = UITextView()
    let tableView: UITableView = UITableView()

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
        
        addSubview(detailsLabel)
        detailsLabel.text = "What tasks are you planning to perform?"
        detailsLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        detailsLabel.snp.makeConstraints { (make) in
            make.left.equalTo(safeAreaLayoutGuide.snp.left).offset(20)
            make.right.equalTo(safeAreaLayoutGuide.snp.right).offset(-20)
            make.top.equalTo(navigationView.snp.bottom).offset(20)
        }
        
        addSubview(taskDetailsTextView)
        taskDetailsTextView.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        taskDetailsTextView.backgroundColor = UIColor.cyan
        taskDetailsTextView.snp.makeConstraints { (make) in
            make.left.right.equalTo(detailsLabel)
            make.top.equalTo(detailsLabel.snp.bottom).offset(4)
            make.height.equalTo(120)
        }
        
        addSubview(tableView)
        tableView.keyboardDismissMode = .onDrag
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(detailsLabel)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.top.equalTo(taskDetailsTextView.snp.bottom).offset(20)
        }
    }
}
