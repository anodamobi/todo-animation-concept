//
//  AppDelegate.swift
//  TODO
//
//  Created by Simon Kostenko on 1/16/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let vc = UINavigationController(rootViewController: DebugVC())
        window?.rootViewController = vc
        
        return true
    }
}

