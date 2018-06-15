/*
  The MIT License (MIT)
  Copyright (c) 2018 ANODA Mobile Development Agency. http://anoda.mobi <info@anoda.mobi>
  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:
  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.
  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
*/

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
        
        let dismissClosure: () -> Void = { [unowned self] in
            self.dismiss(animated: true, completion: nil)
        }
        let navigationAppearance = NavigationViewAppearance(leftItemAppearance: (navItemType: .back, closure: dismissClosure),
                                                            rightItemAppearance: (navItemType: .more, closure: nil))
        contentView.navigationView.apply(appearance: navigationAppearance)
        
        contentView.newTaskButton.onTap { [unowned self] in
            let newTaskVC = NewTaskVC(project: self.project)
            newTaskVC.transitioningDelegate = self
            self.present(newTaskVC, animated: true, completion: nil)
        }
        
        contentView.newTaskButton.backgroundColor = project.styleColor
        storage.updateWithoutAnimationChange { [unowned self] (updater) in
            let viewModels = self.project.tasks.map { TaskCellViewModel(task: $0, checkBoxClosure: { }) }
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
                updater?.addItem(TaskCellViewModel(task: task, checkBoxClosure: { }))
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
