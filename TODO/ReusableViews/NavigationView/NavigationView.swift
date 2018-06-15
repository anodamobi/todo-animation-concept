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

class NavigationView: UIView {
    
    let leftButton: UIButton = UIButton()
    let rightButton: UIButton = UIButton()
    let titleLabel: UILabel = UILabel()
    var title: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        
        backgroundColor = .white
        
        addSubview(leftButton)
        leftButton.snp.makeConstraints { (make) in
            make.size.equalTo(44)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
        }
        
        addSubview(rightButton)
        rightButton.snp.makeConstraints { (make) in
            make.size.equalTo(44)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
        }
        
        addSubview(titleLabel)
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.heavyBody
        titleLabel.textColor = UIColor.dark
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.height.equalTo(leftButton)
            make.left.equalTo(leftButton.snp.right)
            make.right.equalTo(rightButton.snp.left)
        }
    }
    
    func apply(appearance: NavigationViewAppearance) {
        titleLabel.text = appearance.title
        if let leftNavAppearance = appearance.leftItemAppearance {
            leftButton.setImage(leftNavAppearance.navItemType.icon, for: .normal)
            if let closure = leftNavAppearance.closure {
                leftButton.onTap {
                    closure()
                }
            }
        }
        if let rightNavAppearance = appearance.rightItemAppearance {
            rightButton.setImage(rightNavAppearance.navItemType.icon, for: .normal)
            if let closure = rightNavAppearance.closure {
                rightButton.onTap {
                    closure()
                }
            }
        }
    }
}
