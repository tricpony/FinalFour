//
//  AppDelegate.swift
//  FinalFourLab
//
//  Created by aarthur on 7/27/21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        let root = UISplitViewController(style: .doubleColumn)
        let master = MasterViewController()
//        let nav = UINavigationController()
//        nav.setViewControllers([master] animated: false)
        root.setViewController(master, for: .primary)
        
        window.rootViewController = root
        window.makeKeyAndVisible()
        
        return true
    }
}
