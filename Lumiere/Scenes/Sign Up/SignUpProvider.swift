//
//  SignUpProvider.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 03/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import FirebaseDatabase
import FirebaseAuth

protocol SignUpProviderProtocol {
    func fetchSignUp(_ request: SignUp.Request.SignUp)
}

class SignUpProvider: SignUpProviderProtocol {
    
    private let reference: DatabaseReference
    private let helper: FirebaseAuthHelper
    
    init() {
        self.reference = Database.database().reference()
        self.helper = FirebaseAuthHelper()
    }
    
    func fetchSignUp(_ request: SignUp.Request.SignUp) {
        let user = UserModel(name: request.name,
                             email: request.email,
                             password: request.password,
                             phoneNumber: request.phoneNumber,
                             professionalArea: request.professionalArea)
        helper.createUser(user: user) { success in
            
        }
    }
}
