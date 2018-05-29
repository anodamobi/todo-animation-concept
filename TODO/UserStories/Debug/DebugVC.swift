//
//  DebugVC.swift
//  TODO
//
//  Created by Simon Kostenko on 1/16/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import UIKit
import ANODA_Alister
import SnapKit

class DebugVC: UIViewController {
    
    enum DebugScreens: String {
        case main
        case projectTasks
        case addNew
    }
    
    let storage: ANStorage = ANStorage()
    let tableView: UITableView = UITableView(frame: CGRect.zero, style: .plain)
    
    var controller: ANTableController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        controller = ANTableController(tableView: tableView)
        controller.attachStorage(storage)
        controller.configureCells { (config) in
            config?.registerCellClass(ANBaseTableViewCell.self, forModelClass: NSString.self)
        }
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        storage.updateWithoutAnimationChange { (change) in
            change?.addItem(DebugScreens.main.rawValue)
            change?.addItem(DebugScreens.projectTasks.rawValue)
            change?.addItem(DebugScreens.addNew.rawValue)
        }
        
        controller.configureItemSelectionBlock { (_, indexPath) in
            guard let indexPath = indexPath else {
                fatalError()
            }
            
            switch indexPath.row {
            case 0:
                self.present(HomeVC(), animated: true, completion: nil)
            case 1:
                let navVC = UINavigationController(rootViewController: ProjectTasksVC(project: .today))
                self.present(navVC, animated: true, completion: nil)
            default:
                break
            }
        }
    }

}
