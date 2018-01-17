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
    var state: ProjectViewState = .expanded
    
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
        progressView.progress = 0.3
        progressView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        addSubview(progressLabel)
        progressLabel.text = "32%"
        progressLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalTo(progressView)
            make.left.equalTo(progressView.snp.right).offset(8)
        }
        
        addSubview(nameLabel)
        nameLabel.text = "Work"
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(progressView)
            make.bottom.equalTo(progressView.snp.top).offset(-20)
        }
        
        addSubview(tasksLabel)
        tasksLabel.text = "12 Tasks"
        tasksLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.bottom.equalTo(nameLabel.snp.top).offset(-8)
        }
    }
    

}
