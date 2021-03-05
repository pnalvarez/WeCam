//
//  DeepLink.swift
//  WeCam
//
//  Created by Pedro Alvarez on 01/03/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//
import UIKit

enum DeepLink {
    case passwordChange(email: String)
}

class DeepLinkManager {

    private var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func genericRoute(withDeeplink deeplink: DeepLink) {
        switch deeplink {
        case .passwordChange(let email):
            routeToPasswordChange(email: email)
        }
    }
    
    private func routeToPasswordChange(email: String) {
        //TO DO
    }
}
