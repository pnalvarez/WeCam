//
//  FirebaseHelperMock.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 28/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
@testable import Lumiere

enum ErrorMock: Error {
    case generic
}

final class FirebaseHelperMock: FirebaseAuthHelperProtocol {
    
    func createUser(request: CreateUserRequest,
                    completion: @escaping (SignUp.Response.RegisterUser) -> Void) {
        if request.password == "ERROR" {
            completion(.error(ErrorMock.generic))
        } else {
            completion(.success(SignUp.Response.UserResponse(uid: "12xy4")))
        }
    }
    
    func registerUserData(request: SaveUserInfoRequest,
                          completion: @escaping (SignUp.Response.SaveUserInfo) -> Void) {
        if request.name == "ERROR" {
            completion(.error(ErrorMock.generic))
        } else {
            completion(.success)
        }
    }
    
    func signInUser(request: SignInRequest,
                    completion: @escaping (SignIn.Response.SignInResponse) -> Void) {
        if request.email == "ERROR" {
            completion(.error(.init(error: ErrorMock.generic)))
        } else {
            completion(.success)
        }
    }
}
