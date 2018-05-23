//
//  NewTaskVC.swift
//  TODO
//
//  Created by ANODA on 1/29/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import UIKit

class NewTaskVC: UIViewController {

    let contentView: NewTaskView = NewTaskView()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.cancelButton.addTargetClosure { [unowned self] _ in
            self.dismiss(animated: true, completion: nil)
        }
    }
}
