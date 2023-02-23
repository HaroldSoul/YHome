//
//  AppDelegate.swift
//  YHome
//
//  Created by kangho lee on 2023/02/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let naviVC = UINavigationController(rootViewController: ViewController())
        window.rootViewController = naviVC
        window.makeKeyAndVisible()
        self.window = window
        return true
    }

    
}

