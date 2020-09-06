//
//  ProjectParticipantsInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 05/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol ProjectParticipantsListBusinessLogic {
    
}

protocol ProjectParticipantsListDataStore {
    
}

class ProjectParticipantsListInteractor: ProjectParticipantsListDataStore {
    
    private let worker: ProjectParticipantsListWorkerProtocol
    private let presenter: ProjectParticipantsListPresentationLogic
    
    init(worker: ProjectParticipantsListWorkerProtocol = ProjectParticipantsListWorker(),
         presenter: ProjectParticipantsListPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
}

extension ProjectParticipantsListInteractor: ProjectParticipantsListBusinessLogic {
    
}
