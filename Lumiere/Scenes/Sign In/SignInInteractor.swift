//
//  SignInInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 02/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol SignInBusinessRules {
    func signIn(request: SignIn.Models.Request)
    func didForget()
    func didTapSignUp()
}

protocol SignInDataStore {
    var dataStore: SignIn.Home.Response? { get set }
}

class SignInInteractor: SignInDataStore {
    
    private var presenter: SignInPresentationLogic
    private var provider: SignInProviderProtocol
    
    var dataStore: SignIn.Home.Response?
    
    init(viewController: SignInDisplayLogic) {
        self.presenter = SignInPresenter(viewController: viewController)
        self.provider = SignInProvider()
    }
}

extension SignInInteractor: SignInBusinessRules {
    
    func signIn(request: SignIn.Models.Request) {
        presenter.didFetchLoginResponse(response: SignIn.Models.Response.LoggedUser())
    }
    
    func didForget() {
        presenter.didFetchForgetResponse()
    }
    
    func didTapSignUp() {
        presenter.didFetchSignUpResponse()
    }
}

