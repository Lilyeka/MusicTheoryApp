//
//  AppDelegate.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 29.04.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //Create a window that is the same size as the screen
        window = UIWindow(frame: UIScreen.main.bounds)
        // Create a view controller
        let nav = UINavigationController()
       // nav.edgesForExtendedLayout = .all;
        let mainVC = MainViewController()
        let configurator = MainConfigurator()
        configurator.configure(with: mainVC)
        nav.viewControllers = [mainVC]
        // Assign the view controller as `window`'s root view controller
        window?.rootViewController = nav
        // Show the window
        window?.makeKeyAndVisible()
        return true
    }

}

