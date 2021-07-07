//
//  SignUpPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 03/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol SignUpPresentationLogic {
    func didFetchMovieStyles(_ styles: [WCMovieStyle])
    func presentError(_ response: SignUp.Errors.SignUpErrors)
    func presentLoading(_ loading: Bool)
    func didSignUpUser()
    func didFetchServerError(_ error: SignUp.Errors.ServerError)
    func didFetchGenericError()
}

class SignUpPresenter: SignUpPresentationLogic {
    
    private unowned var viewController: SignUpDisplayLogic
    
    init(viewController: SignUpDisplayLogic) {
        self.viewController = viewController
    }
    
    func didFetchMovieStyles(_ styles: [WCMovieStyle]) {
        viewController.displayMovieStyles(styles)
    }
    
    func presentError(_ response: SignUp.Errors.SignUpErrors) {
        switch response {
        case .cellPhoneIncomplete,
             .cellPhoneInvalid,
             .confirmationIncomplete,
             .emailAlreadyRegistered,
             .emailIncomplete,
             .emailInvalid,
             .genericError,
             .movieStyles,
             .nameIncomplete,
             .nameInvalid,
             .passwordIncomplete,
             .passwordInvalid,
             .professional:
            viewController.displayInformationError(SignUp.Info.ViewModel.Error(description: response.rawValue))
            break
        case .passwordMatch:
            viewController.displayConfirmationMatchError()
        }
    }
    
    func presentLoading(_ loading: Bool) {
        viewController.fullScreenLoading(!loading)
    }
    
    func didSignUpUser() {
        viewController.displayDidSignUpUser()
    }
    
    func didFetchServerError(_ error: SignUp.Errors.ServerError) {
        let viewModel = SignUp.Info.ViewModel.Error(description: error.error.description)
        viewController.displayServerError(viewModel)
    }
    
    func didFetchGenericError() {
        let viewModel = SignUp.Info.ViewModel.Error(description: SignUp.Constants.Texts.genericError)
        viewController.displayServerError(viewModel)
    }
}
