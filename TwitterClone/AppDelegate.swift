//
//  AppDelegate.swift
//  TwitterClone
//
//  Created by Yossa Bourne on 8/10/19.
//  Copyright © 2019 Yossa Bourne. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let vc = MainViewController()
        window.rootViewController = vc
        self.window = window
        window.makeKeyAndVisible()
        return true
    }
}

