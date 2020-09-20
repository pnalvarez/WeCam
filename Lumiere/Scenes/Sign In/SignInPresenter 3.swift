//
//  SignInPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 02/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol SignInPresentationLogic {
    func didFetchSuccessLogin()
    func didFetchServerError(_ error: SignIn.Errors.ServerError)
    func didFetchInputError(_ error: SignIn.Errors.InputError)
    func presentLoading(_ loading: Bool)
}

class SignInPresenter: SignInPresentationLogic {
    
    private unowned var viewController: SignInDisplayLogic
    
    init(viewController: SignInDisplayLogic) {
        self.viewController = viewController
    }
    
    func didFetchSuccessLogin() {
        viewController.displaySuccessfulLogin()
    }
    
    func presentLoading(_ loading: Bool) {
        viewController.displayLoading(loading)
    }
    
    func didFetchServerError(_ error: SignIn.Errors.ServerError) {
        let viewModel = SignIn.ViewModel.SignInError(description: error.error.localizedDescription)
        viewController.displayServerError(viewModel)
    }

    func didFetchInputError(_ error: SignIn.Errors.InputError) {
        let viewModel = SignIn.ViewModel.SignInError(description: error.rawValue)
        switch error {
        case .emailEmpty,
             .emailInvalid:
            viewController.displayEmailError(viewModel)
            break
        case .passwordEmpty:
            viewController.displaypasswordError(viewModel)
        }
    }
}


