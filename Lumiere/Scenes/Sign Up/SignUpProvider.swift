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
    func fetchSignUp(_ request: SignUp.Request.CreateUser,
                     completion: @escaping (SignUp.Response.RegisterUser) -> Void)
    func saveUserInfo(_ request: SignUp.Request.SignUpProviderRequest,
                      completion: @escaping (SignUp.Response.SaveUserInfo) -> Void)
}

class SignUpProvider: SignUpProviderProtocol {
    
    private let reference: DatabaseReference
    private let helper: FirebaseAuthHelper
    
    init() {
        self.reference = Database.database().reference()
        self.helper = FirebaseAuthHelper()
    }
    
    func fetchSignUp(_ request: SignUp.Request.CreateUser,
                     completion: @escaping (SignUp.Response.RegisterUser) -> Void) {
        let newRequest = CreateUserRequest(email: request.email, password: request.password)
        helper.createUser(request: newRequest, completion: completion)
    }
    
    func saveUserInfo(_ request: SignUp.Request.SignUpProviderRequest,
                      completion: @escaping (SignUp.Response.SaveUserInfo) -> Void) {
        let newRequest = SaveUserInfoRequest(name: request.userData.email,
                                             email: request.userData.email,
                                             password: request.userData.password,
                                             phoneNumber: request.userData.cellPhone,
                                             professionalArea: request.userData.professionalArea,
                                             interestCathegories: request
                                                .userData
                                                .interestCathegories
                                                .cathegories
                                                .map({$0.rawValue}),
                                             userId: request.userId)
        helper.registerUserData(request: newRequest, completion: completion)
    }
}
