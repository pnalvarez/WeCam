//
//  FinishedProjectDetailsInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 08/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol FinishedProjectDetailsBusinessLogic {
    func fetchProjectData(_ request: FinishedProjectDetails.Request.FetchProjectData)
}

protocol FinishedProjectDetailsDataStore {
    
}

class FinishedProjectDetailsInteractor: FinishedProjectDetailsDataStore {
    
    private let worker: FinishedProjectDetailsWorkerProtocol
    private let presenter: FinishedProjectDetailsPresentationLogic
    
    init(worker: FinishedProjectDetailsWorkerProtocol = FinishedProjectDetailsWorker(),
         presenter: FinishedProjectDetailsPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
}

extension FinishedProjectDetailsInteractor: FinishedProjectDetailsBusinessLogic {
    
    func fetchProjectData(_ request: FinishedProjectDetails.Request.FetchProjectData) {
        
    }
}
