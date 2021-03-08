//
//  CreateNewPasswordRouter.swift
//  WeCam
//
//  Created by Pedro Alvarez on 07/03/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit

typealias CreateNewPasswordRouterProtocol = NSObject & CreateNewPasswordRoutingLogic & CreateNewPasswordDataTransfer

protocol CreateNewPasswordRoutingLogic {
    func routeToSignIn()
}

protocol CreateNewPasswordDataTransfer {
    var dataStore: CreateNewPasswordDataStore? { get }
}

class CreateNewPasswordRouter: NSObject, CreateNewPasswordDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: CreateNewPasswordDataStore?
}

extension CreateNewPasswordRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        
    }
}

extension CreateNewPasswordRouter: CreateNewPasswordRoutingLogic {
    
    func routeToSignIn() {
        
    }
}
