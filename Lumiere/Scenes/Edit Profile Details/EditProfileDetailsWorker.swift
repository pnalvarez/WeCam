//
//  EditProfileDetailsWorker.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 23/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol EditProfileDetailsWorkerProtocol {
    
}

class EditProfileDetailsWorker: EditProfileDetailsWorkerProtocol {
    
    private let builder: FirebaseAuthHelperProtocol
    
    init(builder: FirebaseAuthHelperProtocol = FirebaseAuthHelper()) {
        self.builder = builder
    }
}
