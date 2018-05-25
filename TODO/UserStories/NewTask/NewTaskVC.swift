//
//  NewTaskVC.swift
//  TODO
//
//  Created by ANODA on 1/29/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import UIKit

class NewTaskVC: UIViewController {

    let contentView: NewTaskView = NewTaskView()
    let project: Project
    
    override func loadView() {
        view = contentView
    }
    
    init(project: Project) {
        self.project = project
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.addNewTaskButton.backgroundColor = project.styleColor
        
        contentView.navigationView.leftButton.addTargetClosure { [unowned self] _ in
            self.dismiss(animated: true, completion: nil)
        }
    }
}


