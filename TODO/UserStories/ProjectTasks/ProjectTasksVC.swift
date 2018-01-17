//
//  ProjectTasksVC.swift
//  TODO
//
//  Created by ANODA on 1/16/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import UIKit
import ANODA_Alister
import SnapKit

class ProjectTasksVC: UIViewController {
    
    private let contentView: ProjectTasksView = ProjectTasksView()
    private var controller: ANTableController!
    private let storage: ANStorage = ANStorage()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controller = ANTableController(tableView: contentView.tableView)
        controller.attachStorage(storage)

        storage.updateWithoutAnimationChange { (updater) in }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self,
                                                           action: #selector(close))
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }

}
