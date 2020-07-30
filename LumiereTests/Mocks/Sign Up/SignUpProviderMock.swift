//
//  SignUpProviderMock.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 28/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

@testable import Lumiere

final class SignUpProviderMock: SignUpProviderProtocol {
    
    enum ErrorMock: Error {
        case generic
    }
    
    func fetchSignUp(_ request: SignUp.Request.CreateUser,
                     completion: @escaping (SignUp.Response.RegisterUser) -> Void) {
        if request.email == "ERROR" {
            completion(.error(ErrorMock.generic))
        } else if request.email == "server_error@hotmail.com" {
            completion(.success(SignUp.Response.UserResponse(uid: "ERROR")))
        } else if request.email == "server_error2@hotmail.com" {
            completion(.success(SignUp.Response.UserResponse(uid: "GENERIC ERROR")))
        } else {
            completion(.success(SignUp.Response.UserResponse(uid: "id")))
        }
    }
    
    func saveUserInfo(_ request: SignUp.Request.SignUpProviderRequest,
                      completion: @escaping (SignUp.Response.SaveUserInfo) -> Void) {
        if request.userId == "ERROR" {
            completion(.error(ErrorMock.generic))
        } else if request.userId == "GENERIC ERROR" {
            completion(.genericError)
        } else {
            completion(.success)
        }
    }
}
