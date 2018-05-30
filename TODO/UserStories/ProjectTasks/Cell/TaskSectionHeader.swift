//
//  TaskSectionHeader.swift
//  Todo
//
//  Created by ANODA on 1/16/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import Foundation
import SnapKit
import ANODA_Alister

class TaskSectionHeaderViewModel: NSObject {
    let dateString: String
    init(dateString: String) {
        self.dateString = dateString
        super.init()
    }
}

class TaskSectionHeader: ANBaseTableHeaderView {
    private let dateLabel: UILabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundView = UIView(frame: .zero)
        backgroundView?.backgroundColor = UIColor.white
        
        addSubview(dateLabel)
        dateLabel.font = UIFont.romanSubnote
        dateLabel.textColor = UIColor.dark.withAlphaComponent(0.7)
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(ProjectTasksConstants.margin * 2)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
    
    override func update(withModel model: Any!) {
        guard let viewModel = model as? TaskSectionHeaderViewModel else {
            fatalError("❌ viewModel for header is incorrect")
        }
        dateLabel.text = viewModel.dateString
    }
}
