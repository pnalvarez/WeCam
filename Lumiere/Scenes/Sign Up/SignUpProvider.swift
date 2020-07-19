//
//  SignUpProvider.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 03/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import FirebaseDatabase

protocol SignUpProviderProtocol {
    
}

class SignUpProvider: SignUpProviderProtocol {
    
    private let reference: DatabaseReference
    
    init() {
        reference = Database.database().reference()
    }
}
