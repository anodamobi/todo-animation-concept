//
//  ProjectView.swift
//  TODO
//
//  Created by ANODA on 1/16/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import UIKit
import SnapKit

enum ProjectViewState {
    case expanded
    case collapsed
}

class ProjectView: UIView {
    
    let projectImageView = UIImageView()
    let moreButton = UIButton()
    let tasksLabel = UILabel()
    let nameLabel = UILabel()
    let progressView = UIProgressView()
    let progressLabel = UILabel()
    
    convenience init(viewModel: ProjectTasksCellViewModel) {
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
    
    override func updateConstraints() {
        
        super.updateConstraints()
    }
    
    private func setupLayout() {
        
        addSubview(projectImageView)
        projectImageView.backgroundColor = UIColor.gray
        projectImageView.snp.makeConstraints { (make) in
            make.size.equalTo(30)
            make.left.top.equalToSuperview().offset(16)
        }
        
        addSubview(moreButton)
        moreButton.setTitle("♙", for: .normal)
        moreButton.setTitleColor(UIColor.black, for: .normal)
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
        progressLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalTo(progressView)
            make.left.equalTo(progressView.snp.right).offset(8)
        }
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(progressView)
            make.bottom.equalTo(progressView.snp.top).offset(-20)
        }
        
        addSubview(tasksLabel)
        tasksLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.bottom.equalTo(nameLabel.snp.top).offset(-8)
        }
    }
    
    func update(_ viewModel: ProjectTasksCellViewModel) {
        nameLabel.text = viewModel.name
        tasksLabel.text = "\(viewModel.numberOfTasks!) Tasks"
        progressView.progress = Float(viewModel.progress)
        progressView.progressTintColor = viewModel.color
        progressLabel.text = "\(viewModel.progress * 100)%"
        //        projectTasksView.projectImageView.image = viewModel.icon
    }
    
}
