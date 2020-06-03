//
//  AppDelegate.swift
//  ShakeAnimation
//
//  Created by Holo on 2020/6/3.
//  Copyright © 2020 Holo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = ShakeViewController()
        self.window?.backgroundColor = .white
        self.window?.makeKeyAndVisible()
        return true
    }


}

