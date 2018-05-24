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
    let addNewTaskButton: UIButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        NotificationCenter.default.addObserver(self, selector: #selector(willShow(_:)), name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
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
        
        addSubview(addNewTaskButton)
        addNewTaskButton.backgroundColor = UIColor(red: 0.36, green: 0.55, blue: 0.89, alpha: 1.00)
        addNewTaskButton.setTitle("＋", for: .normal)
        addNewTaskButton.setTitleColor(UIColor.white, for: .normal)
        addNewTaskButton.snp.makeConstraints { (make) in
            make.width.centerX.equalToSuperview()
            make.height.equalTo(44)
            make.bottom.equalToSuperview()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func willShow(_ notification: Notification) {
        keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        addNewTaskButton.snp.updateConstraints { (make) in
            make.bottom.equalToSuperview().offset(-keyboardRect!.size.height)
        }
    }
    
    private var keyboardRect: CGRect?
}
