//
//  HomeVC.swift
//  TODO
//
//  Created by Simon Kostenko on 1/16/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import UIKit
import ANODA_Alister
import Hero

class HomeVC: UIViewController {
    
    let contentView = HomeView()
    let storage: ANStorage = ANStorage()
    var controller: ANCollectionController!
    var rect: CGRect = .zero

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
            let convertedRect = self.controller.collectionView.convert(cell.frame, to: self.view)
            self.rect = convertedRect

            let vc = ProjectTasksVC(project: viewModel.project)
            vc.transitioningDelegate = self
            self.present(vc, animated: true, completion: nil)
        }
        
        storage.updateWithoutAnimationChange { (change) in
            let items = Project.projects.map ({ ProjectTasksViewModel(project: $0) })
            change?.addItems(items)
        }
        
        contentView.backgroundImageView.setImage(Project.today.background)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(HomeVC.swipeLeft(_:)))
        swipeLeft.direction = .left
        contentView.collectionView.addGestureRecognizer(swipeLeft)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(HomeVC.swipeRight(_:)))
        swipeRight.direction = .right
        contentView.collectionView.addGestureRecognizer(swipeRight)
    }
    
    @objc func swipeLeft(_ gestureRecognizer : UISwipeGestureRecognizer) {
        print("swipeLeft")
        if let indexPath = currentProjectIndexPath() {
            let nextIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
            scrollToProject(at: nextIndexPath)
        }
    }
    
    @objc func swipeRight(_ gestureRecognizer : UISwipeGestureRecognizer) {
        print("swipeRight")
        if let indexPath = currentProjectIndexPath() {
            let nextIndexPath = IndexPath(row: indexPath.row - 1, section: indexPath.section)
            scrollToProject(at: nextIndexPath)
        }
    }
    
    private func currentProjectIndexPath() -> IndexPath? {
        let x = contentView.collectionView.contentOffset.x + contentView.collectionView.frame.width / 2
        let y = contentView.collectionView.frame.height / 2
        
        return contentView.collectionView.indexPathForItem(at: CGPoint(x: x, y: y))
    }
    
    private func scrollToProject(at indexPath: IndexPath) {
        if contentView.collectionView.cellForItem(at: indexPath) != nil {
            contentView.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            if let viewModel = storage.object(at: indexPath) as? ProjectTasksViewModel {
                
                UIView.transition(with: self.contentView, duration: 0.25, options: [.curveLinear],
                                  animations: {
                    self.contentView.backgroundImageView.setImage(viewModel.background)
                }, completion: nil)
            }
        }
    }
}

extension HomeVC: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let project = (presented as? ProjectTasksVC)?.project else { return nil }
        return ProjectTasksAnimator(duration: 0.75, presentationStyle: .present, originFrame: rect, project: project)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let project = (dismissed as? ProjectTasksVC)?.project else { return nil }
        return ProjectTasksAnimator(duration: 0.75, presentationStyle: .dismiss, originFrame: rect, project: project)
    }
}
