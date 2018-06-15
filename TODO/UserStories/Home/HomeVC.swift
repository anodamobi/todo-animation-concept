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

class HomeVC: UIViewController {
    
    let contentView = HomeView()
    let storage: ANStorage = ANStorage()
    var controller: ANCollectionController!
    var projectCellRect: CGRect = .zero

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
                
        controller = ANCollectionController(collectionView: contentView.collectionView)
        controller.attachStorage(storage)
        controller.configureCells { (config) in
            config?.registerCellClass(ProjectTasksCell.self, forModelClass: ProjectTasksViewModel.self)
        }

        controller.configureItemSelectionBlock { [unowned self] (viewModel, indexPath) in
            guard let viewModel = viewModel as? ProjectTasksViewModel, let indexPath = indexPath else { return }
            guard let collectionView = self.controller.collectionView,
            let cell = collectionView.cellForItem(at: indexPath) as? ProjectTasksCell else { return }
            self.projectCellRect = collectionView.convert(cell.frame, to: self.view)
            self.selectProject(viewModel.project)
        }
        
        contentView.backgroundImageView.setImage(Project.today.background)
        contentView.appearanceChangingClosure = { [unowned self] indexPath in
            guard let viewModel = self.storage.object(at: indexPath) as? ProjectTasksViewModel else { return }
            self.animateBackgroundChanging(to: viewModel.style.background)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        storage.updateWithoutAnimationChange { (change) in
            change?.removeAllItemsAndSections()
            let items = Project.projects.map ({ ProjectTasksViewModel(project: $0) })
            change?.addItems(items)
        }
    }
    
    private func animateBackgroundChanging(to image: UIImage?) {
        UIView.transition(with: contentView, duration: 0.25, options: [.curveLinear], animations: {
            self.contentView.backgroundImageView.setImage(image)
        })
    }
    
    private func selectProject(_ project: Project) {
        let projectTasksVC = ProjectTasksVC(project: project)
        projectTasksVC.transitioningDelegate = self
        present(projectTasksVC, animated: true, completion: nil)
    }
}

extension HomeVC: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let project = (presented as? ProjectTasksVC)?.project else { return nil }
        return ProjectTasksAnimator(duration: 0.55, presentationStyle: .present, originFrame: projectCellRect, project: project)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let project = (dismissed as? ProjectTasksVC)?.project else { return nil }
        return ProjectTasksAnimator(duration: 0.55, presentationStyle: .dismiss, originFrame: projectCellRect, project: project)
    }
}
