//
//  SignUpRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 03/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

typealias SignUpRouterProtocol = NSObject & SignUpRoutingLogic & SignUpDataTransfer

protocol SignUpRoutingLogic {
    func routeToHome()
    func routeBack()
}

protocol SignUpDataTransfer {
    var dataStore: SignUpDataStore? { get set }
}

class SignUpRouter: NSObject, SignUpDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: SignUpDataStore?
}

extension SignUpRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        viewController?.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension SignUpRouter: SignUpRoutingLogic {
    
    func routeToHome() {
        //ROUTE TO HOME
    }
    
    func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
