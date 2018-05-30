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
    let checkBoxClosure: () -> Void
    let taskTitle: String
    var isCanBeExpired: Bool
    
    init(task: Task, checkBoxClosure: @escaping () -> Void) {
        taskTitle = task.title
        isCanBeExpired = task.endDate != nil
        self.checkBoxClosure = checkBoxClosure
        super.init()
    }
}

class TaskCell: ANBaseTableViewCell {
    private let checkBoxButton: UIButton = UIButton()
    private let taskTitleLabel: UILabel = UILabel()
    private let timerImageView: UIImageView = UIImageView()
    private static let checkBoxImage = UIImage(pdfNamed: R.file.checkboxPdf.name, atWidth: 20)
    private static let timerImage = UIImage.originalSizeImage(withPDFNamed: R.file.timerPdf.name)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(withModel model: Any!) {
        guard let viewModel = model as? TaskCellViewModel else {
            assert(false, "❌ viewModel for cell is incorrect")
            return
        }
        
        timerImageView.isHidden = !viewModel.isCanBeExpired
        taskTitleLabel.text = viewModel.taskTitle
        checkBoxButton.onTap {
            viewModel.checkBoxClosure()
        }
    }
    
    private func setupLayout() {
        
        contentView.addSubview(checkBoxButton)
        checkBoxButton.setImage(TaskCell.checkBoxImage, for: .normal)
        checkBoxButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -ProjectTasksConstants.margin, bottom: 0, right: 0)
        checkBoxButton.snp.makeConstraints { (make) in
            make.size.equalTo(ProjectTasksConstants.rowHeight)
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(ProjectTasksConstants.margin * 2)
        }
        
        contentView.addSubview(taskTitleLabel)
        taskTitleLabel.textColor = UIColor.dark
        taskTitleLabel.font = UIFont.romanBody
        taskTitleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(checkBoxButton.snp.right).offset(10)
        }
        
        contentView.addSubview(timerImageView)
        timerImageView.setImage(TaskCell.timerImage)
        timerImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(taskTitleLabel.snp.right).offset(10)
            make.width.equalTo(18)
            make.height.equalTo(20)
            make.right.equalToSuperview().offset(-ProjectTasksConstants.margin)
        }
    }
}
