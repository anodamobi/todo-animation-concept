//
//  HomeVC.swift
//  TODO
//
//  Created by Simon Kostenko on 1/16/18.
//  Copyright © 2018 Simon Kostenko. All rights reserved.
//

import UIKit
import ANODA_Alister

class HomeVC: UIViewController {
    
    let contentView = HomeView()
    
    let storage: ANStorage = ANStorage()
    var controller: ANCollectionController!
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        controller = ANCollectionController(collectionView: contentView.collectionView)
        controller.attachStorage(storage)
        controller.configureCells { (config) in
            config?.registerCellClass(ProjectTasksCell.self, forModelClass: NSString.self)
        }
        
        storage.updateWithoutAnimationChange { (change) in
            change?.addItem("gwegewg")
            change?.addItem("gwegewg")
            change?.addItem("gwegweg")
            change?.addItem("fwegwe")
        }
    }
}
