//
//  NewTaskVC.swift
//  Todo
//
//  Created by ANODA on 1/29/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import UIKit
import ANODA_Alister
import Closures

class NewTaskVC: UIViewController {

    let contentView: NewTaskView = NewTaskView()
    private var controller: ANTableController!
    private let storage: ANStorage = ANStorage()
    var project: Project
    
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
        
        controller = ANTableController(tableView: contentView.tableView)
        controller.configureCells { (config) in
            config?.registerCellClass(ProjectCell.self, forModelClass: ProjectCellViewModel.self)
        }
        controller.attachStorage(storage)

        let dismissClosure: () -> Void = { [unowned self] in
            self.dismiss(animated: true, completion: nil)
        }
        
        contentView.addNewTaskButton.backgroundColor = project.styleColor
        contentView.addNewTaskButton.onTap { [unowned self] in
            guard let title = self.contentView.taskDetailsTextView.text, !title.isEmpty else { return }
            let task = Task(title: self.contentView.taskDetailsTextView.text)
            self.project.tasks = [task]
            dismissClosure()
        }
        
        storage.updateWithoutAnimationChange { (updater) in
            let viewModels = Project.projects.map { ProjectCellViewModel(project: $0) }
            updater?.addItems(viewModels)
        }
    
        let navigationAppearance = NavigationViewAppearance(title: Localizable.newTaskTitle(),
                                                            leftItemAppearance: (navItemType: .cancel, closure: dismissClosure))
        contentView.navigationView.apply(appearance: navigationAppearance)
    }
}
