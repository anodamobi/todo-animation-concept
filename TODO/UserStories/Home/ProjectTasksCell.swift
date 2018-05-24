//
//  ProjectTasksCell.swift
//  TODO
//
//  Created by Simon Kostenko on 1/16/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import UIKit
import ANODA_Alister

class ProjectTasksCellViewModel: NSObject {
    
    var name: String!
    var iconName: String = ""
    var color: UIColor!
    var numberOfTasks: Int!
    var progress: Double!

}

class ProjectTasksCell: ANCollectionViewCell {
    
    let projectView = ProjectView()
    
    override func update(withModel model: Any!) {
        guard let viewModel = model as? ProjectTasksCellViewModel else {
            assert(false, "❌ viewModel for cell is incorrect")
            return
        }
        projectView.update(viewModel)
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
    }
    
}
