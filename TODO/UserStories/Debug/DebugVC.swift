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
