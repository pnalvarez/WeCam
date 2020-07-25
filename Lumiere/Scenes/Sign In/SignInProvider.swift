//
//  SignInProvider.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 02/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol SignInProviderProtocol {
    func fetchSignIn(request: SignIn.Models.Request, completion: @escaping (SignIn.Response.SignInResponse) -> Void)
}

class SignInProvider: SignInProviderProtocol {
    
    private let builder: FirebaseAuthHelper
    
    init() {
        self.builder = FirebaseAuthHelper()
    }
    
    func fetchSignIn(request: SignIn.Models.Request, completion: @escaping (SignIn.Response.SignInResponse) -> Void) {
        let newRequest = SignInRequest(email: request.email, password: request.password)
        builder.signInUser(request: newRequest, completion: completion)
    }
}
