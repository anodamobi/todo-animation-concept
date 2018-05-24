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
    var viewModel: ProjectTasksCellViewModel?
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "TODO"
        
        controller = ANCollectionController(collectionView: contentView.collectionView)
        controller.attachStorage(storage)
        controller.configureCells { (config) in
            config?.registerCellClass(ProjectTasksCell.self, forModelClass: ProjectTasksCellViewModel.self)
        }
        
        let viewModel1 = ProjectTasksCellViewModel()
        viewModel1.color = UIColor.red
        viewModel1.name = "Personal"
        viewModel1.numberOfTasks = 9
        viewModel1.progress = 0.83
        
        let viewModel2 = ProjectTasksCellViewModel()
        viewModel2.color = UIColor.blue
        viewModel2.name = "Work"
        viewModel2.numberOfTasks = 12
        viewModel2.progress = 0.24
        
        let viewModel3 = ProjectTasksCellViewModel()
        viewModel3.color = UIColor.green
        viewModel3.name = "Home"
        viewModel3.numberOfTasks = 7
        viewModel3.progress = 0.32
        controller.configureItemSelectionBlock { [unowned self] (viewModel, indexPath) in
            guard let viewModel = viewModel as? ProjectTasksCellViewModel else { return }
            guard let cell = self.controller.collectionView.cellForItem(at: indexPath!) as? ProjectTasksCell else { return }
            let convertedRect = self.controller.collectionView.convert(cell.frame,
                                                                       to: self.view)
            self.rect = convertedRect
            self.viewModel = viewModel
//            cell.projectView.heroID = "proj" 

            let vc = ProjectTasksVC(viewModel: viewModel) // UINavigationController.init(rootViewController: ProjectTasksVC())
//            vc.isHeroEnabled = true
//            vc.contentView.projectView.heroID = "proj"
//            vc.contentView.projectView.heroModifiers = [HeroModifier.forceAnimate]
//            vc.contentView.tableView.heroID = "tv"
//            vc.contentView.tableView.heroModifiers = [HeroModifier.cascade(delta: 0.5, direction: CascadeDirection.bottomToTop, delayMatchedViews: true)]
//            vc.contentView.heroModifiers = [HeroModifier.useNoSnapshot, ]
//            vc.contentView.projectView.heroModifiers = [.useGlobalCoordinateSpace,
//                                                        .size(CGSize.init(width: UIScreen.main.bounds.width, height: 135)),
//                                                        .position(CGPoint.init(x: 0, y: 88))]
            
//            vc.modalPresentationStyle = .custom
            vc.transitioningDelegate = self
            self.present(vc, animated: true, completion: nil)
        }
        
        storage.updateWithoutAnimationChange { (change) in
            change?.addItem(viewModel1)
            change?.addItem(viewModel2)
            change?.addItem(viewModel3)
        }
        
        contentView.backgroundColor = viewModel1.color
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(HomeVC.swipeLeft(_:)))
        swipeLeft.direction = .left
        contentView.collectionView.addGestureRecognizer(swipeLeft)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(HomeVC.swipeRight(_:)))
        swipeRight.direction = .right
        contentView.collectionView.addGestureRecognizer(swipeRight)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
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
            if let viewModel = storage.object(at: indexPath) as? ProjectTasksCellViewModel {
                UIView.animate(withDuration: 0.5, animations: {
                    self.contentView.backgroundColor = viewModel.color
                })
            }
        }
    }
}

extension HomeVC: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let viewModel = viewModel else { return nil }
        return ProjectTasksAnimator(duration: 0.75, presentationStyle: .present,
                                    originFrame: rect, projectViewModel: viewModel)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let viewModel = viewModel else { return nil }
        return ProjectTasksAnimator(duration: 0.75, presentationStyle: .dismiss,
                                    originFrame: rect, projectViewModel: viewModel)
    }
}
