//
//  HomeVC.swift
//  TODO
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
            guard let viewModel = viewModel as? ProjectTasksViewModel else { return }
            guard let indexPath = indexPath else { return }
            guard let cell = self.controller.collectionView.cellForItem(at: indexPath) as? ProjectTasksCell else { return }
            self.projectCellRect = self.controller.collectionView.convert(cell.frame, to: self.view)

            let projectTasksVC = ProjectTasksVC(project: viewModel.project)
            projectTasksVC.transitioningDelegate = self
            self.present(projectTasksVC, animated: true, completion: nil)
        }
        
        contentView.backgroundImageView.setImage(Project.today.background)
        contentView.appearanceChangingClosure = { [unowned self] indexPath in
            if let viewModel = self.storage.object(at: indexPath) as? ProjectTasksViewModel {
                UIView.transition(with: self.contentView, duration: 0.25, options: [.curveLinear], animations: {
                    self.contentView.backgroundImageView.setImage(viewModel.background)
                })
            }
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
