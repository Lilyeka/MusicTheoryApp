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
        do {
            sleep(2)
         }
       
        //self.clearLocalCache()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let mainVC = MainViewController()
        window?.rootViewController = UINavigationController(rootViewController: mainVC)
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
        return true
    }
    
    func clearLocalCache() {
        // Clear UserDefaults to start all articles again
         UserDefaults.standard.removeObject(forKey: "first_article_done_tasks")
         UserDefaults.standard.removeObject(forKey: "second_article_done_tasks")
         UserDefaults.standard.removeObject(forKey: "third_article_done_tasks")
    }
}

