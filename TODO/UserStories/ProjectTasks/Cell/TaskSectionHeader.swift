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

import Foundation
import SnapKit
import ANODA_Alister

class TaskSectionHeaderViewModel: NSObject {
    let dateString: String
    init(dateString: String) {
        self.dateString = dateString
        super.init()
    }
}

class TaskSectionHeader: ANBaseTableHeaderView {
    private let dateLabel: UILabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundView = UIView(frame: .zero)
        backgroundView?.backgroundColor = UIColor.white
        
        addSubview(dateLabel)
        dateLabel.font = UIFont.romanSubnote
        dateLabel.textColor = UIColor.dark.withAlphaComponent(0.7)
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(ProjectTasksConstants.margin * 2)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
    
    override func update(withModel model: Any!) {
        guard let viewModel = model as? TaskSectionHeaderViewModel else {
            fatalError("❌ viewModel for header is incorrect")
        }
        dateLabel.text = viewModel.dateString
    }
}
