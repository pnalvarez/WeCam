//
//  AppDelegate.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        FirebaseAuthHelper().createUser(user: UserModel(name: "name", email: "de0108@hotmail.com", password: "12345678", phoneNumber: "21998920668", professionalArea: "Computer Scientist")) { response in
        }
        return true
    }
}

