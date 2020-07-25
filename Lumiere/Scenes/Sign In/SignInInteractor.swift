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
    
    private var presenter: SignInPresentationLogic
    private var provider: SignInProviderProtocol
    
    var dataStore: SignIn.Home.Response?
    
    init(viewController: SignInDisplayLogic) {
        self.presenter = SignInPresenter(viewController: viewController)
        self.provider = SignInProvider()
    }
}

extension SignInInteractor: SignInBusinessRules {
    
    func fetchSignIn(request: SignIn.Models.Request) {
        presenter.presentLoading(true)
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
        presenter.didFetchSuccessLogin()
    }
}

