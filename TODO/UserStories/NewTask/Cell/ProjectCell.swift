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

class ProjectCellViewModel: NSObject {
    
    let projectName: String
    let outlineIcon: UIImage
    
    init(project: Project) {
        projectName = project.name
        outlineIcon = project.outlineIcon
        super.init()
    }
}

class ProjectCell: ANBaseTableViewCell {
    
    private let outlineIconImageView: UIImageView = UIImageView()
    private let projectTitleLabel: UILabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(withModel model: Any!) {
        guard let viewModel = model as? ProjectCellViewModel else {
            assert(false, "❌ viewModel for cell is incorrect")
            return
        }
        outlineIconImageView.setImage(viewModel.outlineIcon)
        projectTitleLabel.text = viewModel.projectName
    }
    
    private func setupLayout() {
        
        contentView.addSubview(outlineIconImageView)
        outlineIconImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(47)
            make.size.equalTo(18)
        }
        
        contentView.addSubview(projectTitleLabel)
        projectTitleLabel.font = UIFont.romanBody
        projectTitleLabel.textColor = UIColor.dark
        projectTitleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(outlineIconImageView.snp.right).offset(25)
        }
    }
}
