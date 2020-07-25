//
//  SignUpProvider.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 03/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import FirebaseDatabase
import FirebaseAuth
import Firebase

protocol SignUpProviderProtocol {
    func fetchSignUp(_ request: SignUp.Request.SignUpProviderRequest,
                     completion: @escaping (SignUpResponse) -> Void)
    func saveUserInfo(_ request: SignUp.Request.SignUpProviderRequest,
                      completion: @escaping (SignUpResponse) -> Void)
}

enum SignUpResponse {
    case success
    case error(Error)
}

class SignUpProvider: SignUpProviderProtocol {
    
    private let reference: DatabaseReference
    private let helper: FirebaseAuthHelper
    
    init() {
        self.reference = Database.database().reference()
        self.helper = FirebaseAuthHelper()
    }
    
    func fetchSignUp(_ request: SignUp.Request.SignUpProviderRequest,
                     completion: @escaping (SignUpResponse) -> Void) {
        let user = UserModel(name: request.userData.name,
                             email: request.userData.email,
                             password: request.userData.password,
                             phoneNumber: request.userData.cellPhone,
                             professionalArea: request.userData.professionalArea,
                             interestCathegories: request.userData.interestCathegories.cathegories.map({$0.rawValue}))
        helper.createUser(user: user, completion: completion)
    }
    
    func saveUserInfo(_ request: SignUp.Request.SignUpProviderRequest,
                      completion: @escaping (SignUpResponse) -> Void) {
        let user = UserModel(name: request.userData.name,
                             email: request.userData.email,
                             password: request.userData.password,
                             phoneNumber: request.userData.cellPhone,
                             professionalArea: request.userData.professionalArea,
                             interestCathegories: request.userData.interestCathegories.cathegories.map({$0.rawValue}))
        helper.registerUserData(user: user, completion: completion)
    }
}
