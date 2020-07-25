//
//  FirebaseAuthHelper.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import FirebaseAuth
import FirebaseAnalytics
import FirebaseFirestore
import FirebaseDatabase

class FirebaseAuthHelper {
    
    func createUser(request: CreateUserRequest,
                    completion: @escaping (SignUp.Response.RegisterUser) -> Void) {
        Auth.auth().createUser(withEmail: request.email, password: request.password) { (response, error) in
            if let error = error {
                completion(.error(error))
                return
            } else {
                if let result = response {
                    completion(.success(result))
                }
            }
        }
    }
    
    func registerUserData(request: SaveUserInfoRequest,
                          completion: @escaping (SignUp.Response.SaveUserInfo) -> Void) {
        Database.database().reference().child(Constants.usersPath).child(request.userId).updateChildValues( ["name": request.name, "email" : request.email, "password" : request.password, "phone_number": request.phoneNumber, "professional_area": request.professionalArea, "interest_cathegories": request.interestCathegories]) {
            (error, ref) in
                if let error = error {
                    completion(.error(error))
                } else {
                    completion(.success)
                }
            }
    }
    
    func signInUser(request: SignInRequest,
                    completion: @escaping (SignIn.Response.SignInResponse) -> Void) {
        Auth.auth().signIn(withEmail: request.email, password: request.password) { (credentials, error) in
            if let error = error {
                completion(.error(SignIn.Errors.ServerError(error: error)))
            } else {
                completion(.success)
            }
        }
    }
}
