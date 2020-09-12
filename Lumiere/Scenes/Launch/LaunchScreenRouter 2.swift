//
//  LaunchScreenCoordinator.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol LaunchScreenRouterProtocol: BaseRouterProtocol {
    var window: UIWindow? { get set }
    func routeToLoginScreen()
}

protocol ScreenTestingProtocol {
    func routeToProfileDetails()
}

class LaunchScreenRouter: BaseRouterProtocol {
    
    weak var viewController: UIViewController?
    var window: UIWindow?
    
    func routeTo(nextVC: UIViewController) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.window?.rootViewController = nextVC
        }
    }
}

extension LaunchScreenRouter: LaunchScreenRouterProtocol {
    
    func routeToLoginScreen() {
//        routeToProfileDetails()
        routeTo(nextVC: UINavigationController(rootViewController: SignInController()))
    }
}
