//
//  AccountRecoveryRouter.swift
//  WeCam
//
//  Created by Pedro Alvarez on 25/02/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit

typealias AccountRecoveryRouterProtocol = NSObject & AccountRecoveryRoutingLogic & AccountRecoveryDataTransfer

protocol AccountRecoveryRoutingLogic {
    func routeToSignIn()
}

protocol AccountRecoveryDataTransfer {
    var dataStore: AccountRecoveryDataStore? { get }
}

class AccountRecoveryRouter: NSObject, AccountRecoveryDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: AccountRecoveryDataStore?
}

extension AccountRecoveryRouter: AccountRecoveryRoutingLogic {
    
    func routeToSignIn() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
