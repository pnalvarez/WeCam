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
    func fetchSignUp(_ request: SignUp.Request.SignUpProviderRequest)
}

class SignUpProvider: SignUpProviderProtocol {
    
    private let reference: DatabaseReference
    private let helper: FirebaseAuthHelper
    
    init() {
        self.reference = Database.database().reference()
        self.helper = FirebaseAuthHelper()
    }
    
    func fetchSignUp(_ request: SignUp.Request.SignUpProviderRequest) {
        let user = UserModel(name: request.userData.name,
                             email: request.userData.email,
                             password: request.userData.password,
                             phoneNumber: request.userData.cellPhone,
                             professionalArea: request.userData.professionalArea,
                             interestCathegories: request.userData.interestCathegories.cathegories)
        helper.createUser(user: user) { success in
            //ROUTE TO HOME
        }
    }
}
