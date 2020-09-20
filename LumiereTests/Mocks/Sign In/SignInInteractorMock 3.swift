//
//  SignInInteractorMock.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 28/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

@testable import Lumiere

final class SignInInteractorMock: SignInBusinessRules {
    
    enum ErrorMock: Error {
        case generic
    }
    
    var presenter: SignInPresentationLogic?
    
    func fetchSignIn(request: SignIn.Models.Request) {
        if request.email == "input_error@hotmail.com" {
            presenter?.didFetchInputError(.emailEmpty)
        } else if request.email == "server_error@hotmail.com" {
            presenter?.didFetchServerError(SignIn.Errors.ServerError(error: ErrorMock.generic))
        } else {
            presenter?.didFetchSuccessLogin()
        }
    }
}
