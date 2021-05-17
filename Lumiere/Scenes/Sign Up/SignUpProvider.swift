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
    func registerUser(_ request: SignUp.Request.RegisterUser,
                      completion: @escaping (EmptyResponse) -> Void)
}

class SignUpProvider: SignUpProviderProtocol {
    
    private let reference: DatabaseReference
    private let helper: FirebaseManagerProtocol
    
    init(helper: FirebaseManagerProtocol = FirebaseManager()) {
        self.reference = Database.database().reference()
        self.helper = helper
    }
    
    func fetchSignUp(_ request: SignUp.Request.CreateUser,
                     completion: @escaping (SignUp.Response.RegisterUser) -> Void) {
        let newRequest = CreateUserRequest(email: request.email, password: request.password)
        helper.createUser(request: newRequest, completion: completion)
    }
    
    func saveUserInfo(_ request: SignUp.Request.SignUpProviderRequest,
                      completion: @escaping (SignUp.Response.SaveUserInfo) -> Void) {
        let newRequest = SaveUserInfoRequest(image: request.userData.image,
                                             name: request.userData.name,
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
    
    func registerUser(_ request: SignUp.Request.RegisterUser,
                      completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["email": request.email, "password": request.password, "image": request.image, "name": request.name, "phoneNumber": request.phoneNumber, "ocupation": request.ocupation, "interestCathegories": request.interestCathegories]
        helper.createUser(request: headers, completion: completion)
    }
}
