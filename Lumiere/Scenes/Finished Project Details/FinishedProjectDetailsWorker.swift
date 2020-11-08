//
//  FinishedProjectDetailsWorker.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 08/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol FinishedProjectDetailsWorkerProtocol {
    
}

class FinishedProjectDetailsWorker: FinishedProjectDetailsWorkerProtocol {
    
    private let builder: FirebaseManagerProtocol
    
    init(builder: FirebaseManagerProtocol = FirebaseManager()) {
        self.builder = builder
    }
}
