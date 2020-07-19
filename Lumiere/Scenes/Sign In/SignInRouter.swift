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
}

protocol SignInDataTransfer {
    
}

class SignInRouter: NSObject, SignInDataTransfer {
    
    weak var viewController: SignInController?
}

extension SignInRouter: SignInRoutingLogic {
    
    func routeToSignUp() {
           let signUpController = SignUpController()
           viewController?.navigationController?.pushViewController(signUpController, animated: true)
       }
    
}
