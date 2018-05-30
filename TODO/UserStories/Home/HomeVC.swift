//
//  HomeVC.swift
//  Todo
//
//  Created by Simon Kostenko on 1/16/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

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
