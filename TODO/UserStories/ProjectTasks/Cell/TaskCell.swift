//
//  TaskCell.swift
//  TODO
//
//  Created by ANODA on 1/16/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import Foundation
import ANODA_Alister
import SnapKit

class TaskCellViewModel: NSObject {
    let checkBoxClosure: UIButtonTargetClosure
    let taskTitle: String
    let isCanBeExpired: Bool = false
    
    init(title: String, checkBoxClosure: @escaping UIButtonTargetClosure) {
        taskTitle = title
        self.checkBoxClosure = checkBoxClosure
        super.init()
    }
}

class TaskCell: ANBaseTableViewCell {
    private let checkBoxButton: UIButton = UIButton()
    private let taskTitleLabel: UILabel = UILabel()
    private let timerImageView: UIImageView = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(withModel model: Any!) {
        guard let viewModel = model as? TaskCellViewModel else {
            fatalError("❌ viewModel for cell is incorrect")
        }
        
        timerImageView.isHidden = viewModel.isCanBeExpired
        taskTitleLabel.text = viewModel.taskTitle
        checkBoxButton.addTargetClosure(closure: viewModel.checkBoxClosure)
    }
    
    func setupLayout() {
        contentView.addSubview(checkBoxButton)
        //        checkBoxButton.setImage(UIImage(), for: .normal)
        //        checkBoxButton.setImage(UIImage(), for: .selected)
        checkBoxButton.snp.makeConstraints { (make) in
            make.size.equalTo(ProjectTasksConstants.rowHeight)
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(ProjectTasksConstants.leftOffset)
        }
        
        contentView.addSubview(taskTitleLabel)
        taskTitleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(checkBoxButton.snp.right).offset(10)
        }
        
        contentView.addSubview(timerImageView)
        timerImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(taskTitleLabel.snp.right).offset(10)
            make.size.equalTo(20)
            make.right.equalToSuperview().offset(-ProjectTasksConstants.leftOffset)
        }
    }
}
