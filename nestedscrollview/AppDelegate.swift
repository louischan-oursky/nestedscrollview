//
//  AppDelegate.swift
//  nestedscrollview
//
//  Created by Louis Chan on 3/11/2017.
//  Copyright © 2017 Louis Chan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = ViewController()
        self.window = window
        window.makeKeyAndVisible()
        return true
    }

}

