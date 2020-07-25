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
        let viewModel = SignIn.ViewModel.ServerError(description: error.error.localizedDescription)
        viewController.displayServerError(viewModel)
    }
}


