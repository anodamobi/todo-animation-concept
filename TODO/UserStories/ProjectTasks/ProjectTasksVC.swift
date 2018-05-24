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
    
    let transition = NewTaskAnimator()
    
    init(viewModel: ProjectTasksViewModel) {
        super.init(nibName: nil, bundle: nil)
        contentView.projectView.update(viewModel)
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
        
        contentView.navigationView.leftButton.addTargetClosure { [unowned self] (_) in
            self.dismiss(animated: true, completion: nil)
        }
        
        contentView.newTaskButton.addTargetClosure { [unowned self] _ in
            let vc = NewTaskVC()
            vc.transitioningDelegate = self
            self.present(vc, animated: true, completion: nil)
        }

        storage.updateWithoutAnimationChange { (updater) in
            let vm =  TaskCellViewModel.init(title: "First", checkBoxClosure: { (_) in
                
            })
            
            let vm1 = TaskCellViewModel.init(title: "First", checkBoxClosure: { (_) in
                
            })
            
            let header = TaskSectionHeaderViewModel.init(dateString: "TODAY")
            
            updater?.addItems([vm, vm1])
            updater?.updateSectionHeaderModel(header, forSectionIndex: 0)
        }
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

extension ProjectTasksVC: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return nil
    }
}
