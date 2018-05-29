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
    
    let contentView: ProjectTasksView = ProjectTasksView()
    private var controller: ANTableController!
    private let storage: ANStorage = ANStorage()
    let project: Project
    
    let transition = NewTaskAnimator()
    
    init(project: Project) {
        self.project = project
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controller = ANTableController(tableView: contentView.tableView)
        controller.configureCells { (config) in
            config?.registerCellClass(TaskCell.self, forModelClass: TaskCellViewModel.self)
            config?.registerHeaderClass(TaskSectionHeader.self, forModelClass: TaskSectionHeaderViewModel.self)
        }
        controller.attachStorage(storage)
        
        let dismissClosure: UIButtonTargetClosure = { [unowned self] (_) in
            self.dismiss(animated: true, completion: nil)
        }
        let navigationAppearance = NavigationViewAppearance(leftItemAppearance: (navItemType: .back, closure: dismissClosure),
                                                            rightItemAppearance: (navItemType: .more, closure: nil))
        contentView.navigationView.apply(appearance: navigationAppearance)
        
        contentView.newTaskButton.addTargetClosure { [unowned self] _ in
            let newTaskVC = NewTaskVC(project: self.project)
            newTaskVC.transitioningDelegate = self
            self.present(newTaskVC, animated: true, completion: nil)
        }
        
        contentView.newTaskButton.backgroundColor = project.styleColor
        storage.updateWithoutAnimationChange { [unowned self] (updater) in
            
            let viewModels = self.project.tasks.map { TaskCellViewModel(task: $0, checkBoxClosure: { _ in }) }
            let header = TaskSectionHeaderViewModel.init(dateString: Localizable.projectTasksToday())
            
            updater?.addItems(viewModels)
            updater?.updateSectionHeaderModel(header, forSectionIndex: 0)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let viewModel = ProjectTasksViewModel(project: project)
        contentView.projectView.update(viewModel)
        storage.update { (updater) in
            guard let items = self.storage.items(inSection: 0), self.project.tasks.count != items.count else { return }
            if let task = self.project.tasks.last {
                updater?.addItem(TaskCellViewModel(task: task, checkBoxClosure: { _ in }))
            }
        }
    }
}

extension ProjectTasksVC: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
}
