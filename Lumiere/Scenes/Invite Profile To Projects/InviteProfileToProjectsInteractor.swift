//
//  InviteProfileToProjectsInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 13/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol InviteProfileToProjectsBusinessLogic {
    
}

protocol InviteProfileToProjectsDataStore {
    
}

class InviteProfileToProjectsInteractor: InviteProfileToProjectsDataStore {
    
    private let worker: InviteProfileToProjectsWorkerProtocol
    private let presenter: InviteProfileToProjectsPresentationLogic
    
    init(worker: InviteProfileToProjectsWorkerProtocol = InviteProfileToProjectsWorker(),
         presenter: InviteProfileToProjectsPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
}

extension InviteProfileToProjectsInteractor: InviteProfileToProjectsBusinessLogic {
    
}
