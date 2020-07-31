//
//  SignInProviderMock.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 28/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
@testable import Lumiere

final class SignInProviderMock: SignInProviderProtocol {
    
    enum ErrorMock: Error {
        case generic
    }
    
    func fetchSignIn(request: SignIn.Models.Request, completion: @escaping (SignIn.Response.SignInResponse) -> Void) {
        if request.email == "ERROR@hotmail.com" {
            completion(.error(SignIn.Errors.ServerError(error: ErrorMock.generic)))
        } else {
            completion(.success)
        }
    }
}
