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
    
    func createUser(user: UserModel, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { (response, error) in
            if error != nil {
                print("Error description ", error?.localizedDescription)
                print("There was an error")
            } else {
                let ref = Database.database().reference()
                let child = ref.child("users").child(response?.user.uid ?? .empty).observe(.childAdded) { response in
                    print("Snapshot",response.value!)
                }
                let db = Firestore.firestore()
                db.collection(Constants.usersPath).addDocument(data: ["name": user.name, "email" : user.email, "password" : user.password, "phone_number": user.phoneNumber, "professional_area": user.professionalArea])
            }
        }
    }
}
