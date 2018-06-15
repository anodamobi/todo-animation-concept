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
import SnapKit
import ANODA_Alister
import Hero

struct ProjectTasksConstants {
    static let rowHeight: CGFloat = 44.0
    static let sectionHeaderHeight: CGFloat = 44.0
    static let margin: CGFloat = 20.0
    static let buttonSize: CGFloat = 54.0
    static let projectViewHeight: Int = 200
}

class ProjectTasksView: BaseView {
    let projectView: ProjectView = ProjectView()
    let tableView: UITableView = UITableView()
    let newTaskButton: UIButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        backgroundColor = .white
        
        addSubview(projectView)
        projectView.snp.makeConstraints { (make) in
            make.top.equalTo(navigationView.snp.bottom)
            make.left.equalTo(safeAreaLayoutGuide.snp.left).offset(ProjectTasksConstants.margin)
            make.right.equalTo(safeAreaLayoutGuide.snp.right).offset(-ProjectTasksConstants.margin)
            make.height.equalTo(ProjectTasksConstants.projectViewHeight)
        }
        
        addSubview(tableView)
        tableView.rowHeight = ProjectTasksConstants.rowHeight
        tableView.sectionHeaderHeight = ProjectTasksConstants.sectionHeaderHeight
        tableView.snp.makeConstraints { (make) in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(safeAreaLayoutGuide.snp.left)
            make.right.equalTo(safeAreaLayoutGuide.snp.right)
            make.top.equalTo(projectView.snp.bottom)
        }
        
        insertSubview(newTaskButton, aboveSubview: tableView)
        newTaskButton.clipsToBounds = true
        newTaskButton.layer.cornerRadius = ProjectTasksConstants.buttonSize / 2.0
        newTaskButton.setTitle("＋", for: .normal)
        newTaskButton.titleLabel?.font = .romanTitle
        newTaskButton.setTitleColor(UIColor.white, for: .normal)
        newTaskButton.snp.makeConstraints { (make) in
            make.size.equalTo(ProjectTasksConstants.buttonSize)
            make.right.equalToSuperview().offset(-22)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-80.0.verticalProportional)
        }
    }
}
