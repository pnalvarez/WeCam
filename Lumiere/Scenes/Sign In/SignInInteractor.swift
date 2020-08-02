//
//  SignInInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 02/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol SignInBusinessRules {
    func fetchSignIn(request: SignIn.Models.Request)
}

protocol SignInDataStore {
    var dataStore: SignIn.Home.Response? { get set }
}

class SignInInteractor: SignInDataStore {
    
    var presenter: SignInPresentationLogic
    var provider: SignInProviderProtocol
    
    var dataStore: SignIn.Home.Response?
    
    init(viewController: SignInDisplayLogic,
         provider: SignInProviderProtocol = SignInProvider()) {
        self.presenter = SignInPresenter(viewController: viewController)
        self.provider = provider
    }
}

extension SignInInteractor {
    
    private func checkErrors(_ request: SignIn.Models.Request) -> Bool{
        guard !request.email.isEmpty else {
            presenter.didFetchInputError(.emailEmpty)
            return true
        }
        guard request.email.isValidEmail() else {
            presenter.didFetchInputError(.emailInvalid)
            return true
        }
        guard !request.password.isEmpty else {
            presenter.didFetchInputError(.passwordEmpty)
            return true
        }
        return false
    }
}

extension SignInInteractor: SignInBusinessRules {
    
    func fetchSignIn(request: SignIn.Models.Request) {
        presenter.presentLoading(true)
        guard !checkErrors(request) else {
            presenter.presentLoading(false)
            return
        }
        provider.fetchSignIn(request: request) { response in
            switch response {
            case .success:
                self.presenter.presentLoading(false)
                self.presenter.didFetchSuccessLogin()
                break
            case .error(let error):
                self.presenter.presentLoading(false)
                self.presenter.didFetchServerError(error)
                break
            }
        }
    }
}

