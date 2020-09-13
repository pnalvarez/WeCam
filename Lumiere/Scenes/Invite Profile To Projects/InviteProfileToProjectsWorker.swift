//
//  InviteProfileToProjectsWorker.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 13/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol InviteProfileToProjectsWorkerProtocol {
    
}

class InviteProfileToProjectsWorker: InviteProfileToProjectsWorkerProtocol {
    
    private let builder: FirebaseAuthHelperProtocol
    
    init(builder: FirebaseAuthHelperProtocol = FirebaseAuthHelper()) {
        self.builder = builder
    }
}
