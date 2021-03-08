//
//  DeepLink.swift
//  WeCam
//
//  Created by Pedro Alvarez on 01/03/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//
import UIKit

enum DeepLink {
    case passwordChange(userId: String)
}

class DeepLinkManager {

    private var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func genericRoute(withDeeplink deeplink: DeepLink) {
        switch deeplink {
        case .passwordChange(let email):
            routeToPasswordChange(userId: email)
        }
    }
    
    private func routeToPasswordChange(userId: String) {
        let signInVC = SignInController()
        let createNewPasswordVC = CreateNewPasswordController()
        createNewPasswordVC.router?.dataStore?.receivedAccount = CreateNewPassword.Info.Received.Account(userId: userId)
        let navigation = UINavigationController(rootViewController: signInVC)
        navigation.pushViewController(createNewPasswordVC, animated: false)
        window?.rootViewController = navigation
    }
}
