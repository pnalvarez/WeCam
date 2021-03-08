//
//  AppDelegate.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import Firebase
import ObjectMapper

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true
        UITabBar.setupTabBarUI()
        UISegmentedControl.setupSegmentedControlUI()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        guard let host = url.host else {
            return true
        }
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        if host == "passwordChange" {
            if let userId = components?.queryItems?.first?.value, let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                let window = sceneDelegate.window
                DeepLinkManager(window: window).genericRoute(withDeeplink: .passwordChange(userId: userId))
            }
        }
        return true
    }
}

