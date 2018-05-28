//
//  ProjectCell.swift
//  TODO
//
//  Created by Simon Kostenko on 5/25/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import UIKit
import ANODA_Alister

class ProjectCellViewModel: NSObject {
    
    let projectName: String
    let outlineIcon: UIImage
    
    init(project: Project) {
        projectName = project.name
        outlineIcon = project.outlineIcon
        super.init()
    }
}

class ProjectCell: ANBaseTableViewCell {
    
    private let outlineIconImageView: UIImageView = UIImageView()
    private let projectTitleLabel: UILabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(withModel model: Any!) {
        guard let viewModel = model as? ProjectCellViewModel else {
            assert(false, "❌ viewModel for cell is incorrect")
            return
        }
        outlineIconImageView.setImage(viewModel.outlineIcon)
        projectTitleLabel.text = viewModel.projectName
    }
    
    private func setupLayout() {
        
        contentView.addSubview(outlineIconImageView)
        outlineIconImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(47)
            make.size.equalTo(18)
        }
        
        contentView.addSubview(projectTitleLabel)
        projectTitleLabel.font = UIFont.romanBody
        projectTitleLabel.textColor = UIColor.dark
        projectTitleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(outlineIconImageView.snp.right).offset(25)
        }
    }
}
