//
//  AppDelegate.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit
import Firebase
import ObjectMapper

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        InternetManager.shared.setupInternetMonitor()
        let firebaseFile: String! = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist")
        let options = FirebaseOptions(contentsOfFile: firebaseFile)!
        FirebaseApp.configure(options: options)
        Database.database().isPersistenceEnabled = true
        UITabBar.setupTabBarUI()
        UISegmentedControl.setupSegmentedControlUI()
        return true
    }
}

