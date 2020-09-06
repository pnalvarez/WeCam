//
//  ProjectParticipantsListWorker.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 05/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol ProjectParticipantsListWorkerProtocol {
    
}

class ProjectParticipantsListWorker: ProjectParticipantsListWorkerProtocol {
    
    private let builder: FirebaseAuthHelperProtocol
    
    init(builder: FirebaseAuthHelperProtocol = FirebaseAuthHelper()) {
        self.builder = builder
    }
}
