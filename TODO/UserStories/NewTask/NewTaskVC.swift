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
