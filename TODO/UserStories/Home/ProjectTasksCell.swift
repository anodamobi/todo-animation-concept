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

class ProjectTasksViewModel: NSObject {
    
    var name: String
    var progress: Double
    let style: ProjectStyle
    let project: Project
    
    init(project: Project) {
        self.project = project
        name = project.name
        progress = project.progress
        style = ProjectStyle(project: project)
        super.init()
    }
}

class ProjectTasksCell: ANCollectionViewCell {
    
    let projectView = ProjectView()
    
    override func update(withModel model: Any!) {
        guard let viewModel = model as? ProjectTasksViewModel else {
            assert(false, "❌ viewModel for cell is incorrect")
            return
        }
        projectView.update(viewModel)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        backgroundColor = UIColor.white
        layer.cornerRadius = 8
        clipsToBounds = true
        
        addSubview(projectView)
        projectView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
