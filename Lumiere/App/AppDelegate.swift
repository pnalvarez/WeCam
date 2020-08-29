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
        UITabBar.setupTabBarUI()
        FirebaseHelper().registerUser(request: ["email": "pedroemail@hotmail.com", "password": "123456"]){ _ in
            FirebaseHelper().signInUser(request: ["email": "pedronalvarezs@hotmail.com", "password": "123456"]) {
                _ in
                FirebaseHelper().updateUserInfo(request: ["name": "Pedrinho Alvarez", "phone_number": "203933", "ocupation": "Artist", "profile_image": UIImage(named: "logo-apenas")?.jpegData(compressionQuality: 0.5), "interest_cathegories": ["Dança"]]) { response in
                    switch response {
                    case .success:
                        break
                    case .error:
                        break
                    }
                }
            }
        }
        return true
    }
}

