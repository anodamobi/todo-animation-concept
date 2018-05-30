//
//  ProjectStyle.swift
//  Todo
//
//  Created by Maxim Danilov on 5/30/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import UIKit

class ProjectStyle {
    var icon: UIImage?
    var background: UIImage?
    var color: UIColor
    
    init(project: Project) {
        icon = project.icon
        background = project.background
        color = project.styleColor
    }
}
