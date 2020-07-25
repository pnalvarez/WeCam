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
    
    func createUser(user: UserModel,
                    completion: @escaping (SignUpResponse) -> Void) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { (response, error) in
            if let error = error {
                completion(.error(error))
                return
            } else {
                if let _ = response {
                    completion(.success)
                }
            }
        }
    }
    
    func registerUserData(user: UserModel,
                          completion: @escaping (SignUpResponse) -> Void) {
//        let ref = Database.database().reference()
//        let child = ref.child("users").child(authData.user.uid ?? .empty).observe(.childAdded) { response in
////            print("Snapshot",authData.va)
//        }
        let db = Firestore.firestore()
        db.collection(Constants.usersPath).addDocument(data: ["name": user.name, "email" : user.email, "password" : user.password, "phone_number": user.phoneNumber, "professional_area": user.professionalArea, "interest_cathegories": user.interestCathegories]) { error in
            if let error = error {
                completion(.error(error))
            } else {
                completion(.success)
            }
        }
        
    }
}
