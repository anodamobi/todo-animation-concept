//
//  HomeVC.swift
//  TODO
//
//  Created by Simon Kostenko on 1/16/18.
//  Copyright © 2018 Simon Kostenko. All rights reserved.
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
        controller.configureItemSelectionBlock { [unowned self] (_, indexPath) in
            
            guard let cell = self.controller.collectionView.cellForItem(at: indexPath!) as? ProjectTasksCell else { return }
            let convertedRect = self.controller.collectionView.convert(cell.frame,
                                                                       to: self.view)
            self.rect = convertedRect
            
//            cell.projectView.heroID = "proj"

            let vc = UINavigationController.init(rootViewController: ProjectTasksVC())
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
        let animator = ProjectTasksAnimator()
        animator.originFrame = self.rect
        animator.isPresenting = true
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = ProjectTasksAnimator()
        animator.originFrame = self.rect
        animator.isPresenting = false
        return animator
    }
    
//    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController!, sourceViewController source: UIViewController) -> UIPresentationController? {
//        let presentationController = DetailPresentationController(presentedViewController: presented,
//                                                                  presenting: source)
//        presentationController.setupDimmingView()
//        return presentationController
//    }
}

//class DetailPresentationController: UIPresentationController {
//
//    var dimmingView: UIView!
//
//    func setupDimmingView() {
//        dimmingView = UIView(frame: presentingViewController.view.bounds)
//
//        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
//        visualEffectView.frame = dimmingView.bounds
//        visualEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//        dimmingView.addSubview(visualEffectView)
//
//        let tapRecognizer = UITapGestureRecognizer.init(target: self,
//                                                        action: #selector(dimmingViewTapped(tapRecognizer:)))
//        dimmingView.addGestureRecognizer(tapRecognizer)
//    }
//
//    @objc func dimmingViewTapped(tapRecognizer: UITapGestureRecognizer) {
//        presentingViewController.dismiss(animated: true, completion: nil)
//    }
//
//    override func presentationTransitionWillBegin() {
//        let containerView = self.containerView!
//        let presentedViewController = self.presentedViewController
//
//        dimmingView.frame = containerView.bounds
//        dimmingView.alpha = 0.0
//
//        containerView.insertSubview(dimmingView, at: 0)
//        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (coordinatorContext) -> Void in
//            self.dimmingView.alpha = 1.0
//        }, completion: nil)
//    }
//
//    override func dismissalTransitionWillBegin() {
//        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (coordinatorContext) -> Void in
//            self.dimmingView.alpha = 0.0
//        }, completion: nil)
//    }
//
//    override func containerViewWillLayoutSubviews() {
//        dimmingView.frame = containerView!.bounds
//        presentedView?.frame = frameOfPresentedViewInContainerView
//    }
//
//    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
//        return CGSize.init(width: parentSize.width - 40.0, height: parentSize.height - 80.0)
//    }
//
//    override var frameOfPresentedViewInContainerView: CGRect {
//        var presentedViewFrame = CGRect.zero
//        let containerBounds = containerView!.bounds
//
//        let contentContainer = presentedViewController
//
//        presentedViewFrame.size = size(forChildContentContainer: contentContainer,
//                                       withParentContainerSize:containerBounds.size) //CGSizeMake(428.0, presentedView().frame.size.height) //
//        presentedViewFrame.origin.x = 20.0
//        presentedViewFrame.origin.y = 40.0
//
//        return presentedViewFrame
//    }
//}

