//
//  SignInProvider.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 02/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol SignInProviderProtocol {
    func fetchSignIn(request: SignIn.Models.Request,
                     completion: @escaping (BaseResponse<SignIn.Response.LoggedUser>) -> Void)
}

class SignInProvider: SignInProviderProtocol {
    
    private let builder: FirebaseAuthHelperProtocol
    
    init(builder: FirebaseAuthHelperProtocol = FirebaseAuthHelper()) {
        self.builder = builder
    }
    
    func fetchSignIn(request: SignIn.Models.Request,
                     completion: @escaping (BaseResponse<SignIn.Response.LoggedUser>) -> Void) {
        let headers: [String : Any] = ["email": request.email,
                                       "password": request.password]
        builder.fetchSignInUser(request: headers, completion: completion)
    }
}
