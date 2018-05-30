//
//  ProjectView.swift
//  Todo
//
//  Created by ANODA on 1/16/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import UIKit
import SnapKit

class ProjectView: UIView {
    
    private static let dotsImage = UIImage.originalSizeImage(withPDFNamed: R.file.dotsPdf.name)
    
    let projectImageView = UIImageView()
    let moreButton = UIButton()
    let tasksLabel = UILabel()
    let nameLabel = UILabel()
    let progressView = UIProgressView()
    let progressLabel = UILabel()
    
    convenience init(viewModel: ProjectTasksViewModel) {
        self.init(frame: .zero)
        update(viewModel)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ viewModel: ProjectTasksViewModel) {
        nameLabel.text = viewModel.name
        let taskNumber = viewModel.project.tasks.count
        tasksLabel.text = Localizable.projectTasksTasks(taskNumber)
        progressView.progress = Float(viewModel.progress)
        progressView.progressTintColor = viewModel.style.color
        progressLabel.text = "\(viewModel.progress * 100)%"
        projectImageView.setImage(viewModel.style.icon)
    }
    
    private func setupLayout() {
        
        addSubview(projectImageView)
        projectImageView.snp.makeConstraints { (make) in
            make.size.equalTo(44)
            make.left.top.equalToSuperview().offset(16)
        }
        
        addSubview(moreButton)
        moreButton.setImage(ProjectView.dotsImage, for: .normal)
        moreButton.snp.makeConstraints { (make) in
            make.size.equalTo(30)
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        addSubview(progressView)
        progressView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        addSubview(progressLabel)
        progressLabel.font = UIFont.romanFootnote
        progressLabel.textColor = UIColor.dark
        progressLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalTo(progressView)
            make.left.equalTo(progressView.snp.right).offset(8)
        }
        
        addSubview(nameLabel)
        nameLabel.font = UIFont.romanTitle
        nameLabel.textColor = UIColor.dark
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(progressView)
            make.bottom.equalTo(progressView.snp.top).offset(-20)
        }
        
        addSubview(tasksLabel)
        tasksLabel.font = UIFont.romanSubnote
        tasksLabel.textColor = UIColor.dark
        tasksLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.bottom.equalTo(nameLabel.snp.top).offset(-8)
        }
    }
}
