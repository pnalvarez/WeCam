//
//  SignUpRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 03/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import Foundation

typealias SignUpRouterProtocol = NSObject & SignUpRoutingLogic & SignUpDataTransfer

protocol SignUpRoutingLogic {
    
}

protocol SignUpDataTransfer {
    
}

class SignUpRouter: NSObject, SignUpRoutingLogic {
    
}

extension SignUpRouter: SignUpDataTransfer {
    
}
