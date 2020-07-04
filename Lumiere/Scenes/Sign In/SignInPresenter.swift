//
//  SignInPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 02/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol SignInPresentationLogic {
    func didFetchLoginResponse(response: SignIn.Models.Response.LoggedUser)
    func didFetchForgetResponse()
    func didFetchSignUpResponse()
}

class SignInPresenter: SignInPresentationLogic {
    
    private unowned var viewController: SignInDisplayLogic
    
    init(viewController: SignInDisplayLogic) {
        self.viewController = viewController
    }
    
    func didFetchLoginResponse(response: SignIn.Models.Response.LoggedUser) {
        viewController.didFetchLoginResponse()
    }
    
    func didFetchForgetResponse() {
        viewController.didFetchForgot()
    }
    
    func didFetchSignUpResponse() {
        viewController.didFetchSignUp()
    }
}


