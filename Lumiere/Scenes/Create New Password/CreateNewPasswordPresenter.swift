//
//  CreateNewPasswordPresenter.swift
//  WeCam
//
//  Created by Pedro Alvarez on 07/03/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol CreateNewPasswordPresentationLogic {
    func presentError(_ response: CreateNewPassword.Info.Model.Error)
    func presentLoading(_ loading: Bool)
    func presentSuccessAlert()
}

class CreateNewPasswordPresenter: CreateNewPasswordPresentationLogic {
    
    private unowned var viewController: CreateNewPasswordDisplayLogic
    
    init(viewController: CreateNewPasswordDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentError(_ response: CreateNewPassword.Info.Model.Error) {
        let viewModel = CreateNewPassword.Info.ViewModel.Error(type: response.type, title: response.title, message: response.message)
        viewController.displayError(viewModel)
    }
    
    func presentLoading(_ loading: Bool) {
        viewController.displayLoading(loading)
    }
    
    func presentSuccessAlert() {
        viewController.displaySuccessAlert()
    }
}


