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

class ProjectView: UIView {
    
    private static let dotsImage = UIImage.originalSizeImage(withPDFNamed: R.file.dotsPdf.name)
    
    let projectImageView = UIImageView()
    let moreButton = UIButton()
    let tasksLabel = UILabel()
    let nameLabel = UILabel()
    let progressView = UIProgressView()
    let progressLabel = UILabel()
    
    convenience init(viewModel: ProjectTasksViewModel) {
        self.init(frame: .zero)
        update(viewModel)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ viewModel: ProjectTasksViewModel) {
        nameLabel.text = viewModel.name
        let taskNumber = viewModel.project.tasks.count
        tasksLabel.text = Localizable.projectTasksTasks(taskNumber)
        progressView.progress = Float(viewModel.progress)
        progressView.progressTintColor = viewModel.style.color
        progressLabel.text = "\(viewModel.progress * 100)%"
        projectImageView.setImage(viewModel.style.icon)
    }
    
    private func setupLayout() {
        
        addSubview(projectImageView)
        projectImageView.snp.makeConstraints { (make) in
            make.size.equalTo(44)
            make.left.top.equalToSuperview().offset(16)
        }
        
        addSubview(moreButton)
        moreButton.setImage(ProjectView.dotsImage, for: .normal)
        moreButton.snp.makeConstraints { (make) in
            make.size.equalTo(30)
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        addSubview(progressView)
        progressView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        addSubview(progressLabel)
        progressLabel.font = UIFont.romanFootnote
        progressLabel.textColor = UIColor.dark
        progressLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalTo(progressView)
            make.left.equalTo(progressView.snp.right).offset(8)
        }
        
        addSubview(nameLabel)
        nameLabel.font = UIFont.romanTitle
        nameLabel.textColor = UIColor.dark
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(progressView)
            make.bottom.equalTo(progressView.snp.top).offset(-20)
        }
        
        addSubview(tasksLabel)
        tasksLabel.font = UIFont.romanSubnote
        tasksLabel.textColor = UIColor.dark
        tasksLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.bottom.equalTo(nameLabel.snp.top).offset(-8)
        }
    }
}
