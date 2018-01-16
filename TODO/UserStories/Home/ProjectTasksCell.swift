//
//  ProjectTasksCell.swift
//  TODO
//
//  Created by Simon Kostenko on 1/16/18.
//  Copyright © 2018 Simon Kostenko. All rights reserved.
//

import UIKit
import ANODA_Alister

class ProjectTasksCellViewModel: NSObject {
    
    var name: String!
    var icon: UIImageView!
    var color: UIColor!
    var numberOfTasks: Int!
    var progress: Double!

}

class ProjectTasksCell: ANCollectionViewCell {
    
    let projectView = ProjectView()
    
    override func update(withModel model: Any!) {
        guard let viewModel = model as? ProjectTasksCellViewModel else {
            fatalError("incorrect view")
        }
        
        projectTasksView.nameLabel.text = viewModel.name
        projectTasksView.tasksLabel.text = "\(viewModel.numberOfTasks!) Tasks"
        projectTasksView.progressView.progress = Float(viewModel.progress)
        projectTasksView.progressView.progressTintColor = viewModel.color
        projectTasksView.progressLabel.text = "\(viewModel.progress * 100)%"
//        projectTasksView.projectImageView.image = viewModel.icon
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        backgroundColor = UIColor.white
        layer.cornerRadius = 8
        clipsToBounds = true
        
        
        addSubview(projectView)
        projectView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
//        backgroundView = UIView.init(frame: CGRect.zero)
//        backgroundView?.backgroundColor = UIColor.phPaleGreyTwo
//        selectedBackgroundView = backgroundView
    }
    
}
