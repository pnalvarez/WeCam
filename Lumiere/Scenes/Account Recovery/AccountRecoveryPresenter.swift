//
//  AccountRecoveryPresenter.swift
//  WeCam
//
//  Created by Pedro Alvarez on 25/02/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol AccountRecoveryPresentationLogic {
    func presentLoading(_ loading: Bool)
    func presentUserResult(_ response: AccountRecovery.Info.Model.Account)
    func presentSuccessfullySentEmailAlert()
    func presentError(_ response: AccountRecovery.Info.Model.Error)
}

class AccountRecoveryPresenter: AccountRecoveryPresentationLogic {
    
    private unowned var viewController: AccountRecoveryDisplayLogic
    
    init(viewController: AccountRecoveryDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentLoading(_ loading: Bool) {
        viewController.defaultScreenLoading(!loading)
    }
    
    func presentUserResult(_ response: AccountRecovery.Info.Model.Account) {
        let viewModel = AccountRecovery.Info.ViewModel.Account(name: response.name, image: response.image, phone: response.phone, email: response.email, ocupation: response.ocupation)
        viewController.displayUserData(viewModel)
    }
    
    func presentSuccessfullySentEmailAlert() {
        viewController.displaySuccessfullySentEmailAlert()
    }
    
    func presentError(_ response: AccountRecovery.Info.Model.Error) {
        viewController.showAlertError(title: response.title,
                                      description: response.message,
                                      doneText: WCConstants.Strings.ok)
    }
}
