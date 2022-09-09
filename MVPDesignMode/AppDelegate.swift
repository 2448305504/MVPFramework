//
//  AppDelegate.swift
//  MVPDesignMode
//
//  Created by 林文俊 on 2022/9/6.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        if #available(iOS 13.0, *) {
            window?.backgroundColor = .systemBackground
        } else {
            window?.backgroundColor = .black
        }
        window?.rootViewController = WJBaseNavigationController(rootViewController: ViewController())
        window?.makeKeyAndVisible()
        return true
    }

    


}

