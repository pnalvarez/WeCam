//
//  SignInRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 02/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import Foundation

typealias SignInRouterProtocol = NSObject & SignInRoutingLogic & SignInDataTransfer

protocol SignInRoutingLogic {
    func routeToSignUp()
    func routeToHome()
}

protocol SignInDataTransfer {
    var dataStore: SignInDataStore? { get set }
}

class SignInRouter: NSObject, SignInDataTransfer {
    
    weak var viewController: SignInController?
    var dataStore: SignInDataStore?
}

extension SignInRouter: SignInRoutingLogic {
    
    func routeToSignUp() {
           let signUpController = SignUpController()
           viewController?.navigationController?.pushViewController(signUpController, animated: true)
       }
    
    func routeToHome() {
        
    }
}
