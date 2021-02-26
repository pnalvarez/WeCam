//
//  AccountRecoveryPresenter.swift
//  WeCam
//
//  Created by Pedro Alvarez on 25/02/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol AccountRecoveryPresentationLogic {
    
}

class AccountRecoveryPresenter: AccountRecoveryPresentationLogic {
    
    private unowned var viewController: AccountRecoveryDisplayLogic
    
    init(viewController: AccountRecoveryDisplayLogic) {
        self.viewController = viewController
    }
}
