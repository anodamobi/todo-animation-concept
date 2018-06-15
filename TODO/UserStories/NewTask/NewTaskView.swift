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

private struct NewTaskConstants {
    static let rowHeight: CGFloat = 44.0
    static let taskDetailsHeight: CGFloat = 80.0
    static let newTaskButtonHeight: CGFloat = 54.0
}

class NewTaskView: BaseView {
    
    private let detailsLabel: UILabel = UILabel()
    let taskDetailsTextView: UITextView = UITextView()
    let tableView: UITableView = UITableView()
    let addNewTaskButton: UIButton = UIButton()
    
    private var keyboardRect: CGRect?

    override init(frame: CGRect) {
        super.init(frame: frame)
        NotificationCenter.default.addObserver(self, selector: #selector(willShow(_:)),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func willShow(_ notification: Notification) {
        keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        addNewTaskButton.snp.remakeConstraints { (make) in
            make.width.centerX.equalToSuperview()
            make.height.equalTo(NewTaskConstants.newTaskButtonHeight)
            if let keyboardHeight = keyboardRect?.size.height {
                make.bottom.equalToSuperview().offset(-keyboardHeight)
            } else {
                make.bottom.equalToSuperview()
            }
        }
        super.updateConstraints()
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        backgroundColor = UIColor.white
        
        addSubview(detailsLabel)
        detailsLabel.textColor = UIColor.dark
        detailsLabel.font = UIFont.romanSubnote
        detailsLabel.text = Localizable.newTaskHint()
        detailsLabel.snp.makeConstraints { (make) in
            make.left.equalTo(safeAreaLayoutGuide.snp.left).offset(45)
            make.right.equalTo(safeAreaLayoutGuide.snp.right).offset(-20)
            make.top.equalTo(navigationView.snp.bottom).offset(20)
        }
        
        addSubview(taskDetailsTextView)
        taskDetailsTextView.font = UIFont.mediumTitle
        taskDetailsTextView.textColor = UIColor.dark
        taskDetailsTextView.backgroundColor = UIColor.clear
        taskDetailsTextView.keyboardAppearance = .dark
        taskDetailsTextView.snp.makeConstraints { (make) in
            make.left.right.equalTo(detailsLabel)
            make.top.equalTo(detailsLabel.snp.bottom).offset(4)
            make.height.equalTo(NewTaskConstants.taskDetailsHeight)
        }
        
        addSubview(tableView)
        tableView.rowHeight = NewTaskConstants.rowHeight
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        tableView.snp.makeConstraints { (make) in
            make.centerX.width.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.top.equalTo(taskDetailsTextView.snp.bottom).offset(20)
        }
        
        addSubview(addNewTaskButton)
        addNewTaskButton.setTitle("＋", for: .normal)
        addNewTaskButton.titleLabel?.font = .romanTitle
        addNewTaskButton.setTitleColor(UIColor.white, for: .normal)
        addNewTaskButton.snp.makeConstraints { (make) in
            make.width.centerX.equalToSuperview()
            make.height.equalTo(NewTaskConstants.newTaskButtonHeight)
            if let keyboardHeight = keyboardRect?.size.height {
                make.bottom.equalToSuperview().offset(-keyboardHeight)
            } else {
                make.bottom.equalToSuperview()
            }
        }
    }
}
