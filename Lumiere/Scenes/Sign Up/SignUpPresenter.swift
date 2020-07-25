//
//  SignUpPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 03/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol SignUpPresentationLogic {
    func didFetchMovieStyles(_ styles: [MovieStyle])
    func presentError(_ response: SignUp.Error.SignUpErrors)
    func presentLoading(_ loading: Bool)
}

class SignUpPresenter: SignUpPresentationLogic {
    
    private unowned var viewController: SignUpDisplayLogic
    
    init(viewController: SignUpDisplayLogic) {
        self.viewController = viewController
    }
    
    func didFetchMovieStyles(_ styles: [MovieStyle]) {
        viewController.displayMovieStyles(styles)
    }
    
    func presentError(_ response: SignUp.Error.SignUpErrors) {
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
        viewController.displayLoading(loading)
    }
}
