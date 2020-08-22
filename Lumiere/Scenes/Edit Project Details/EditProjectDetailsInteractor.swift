//
//  EditProjectDetailsInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 21/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol EditProjectDetailsBusinessLogic {
    
}

protocol EditProjectDetailsDataStore {
    var receivedData: EditProjectDetails.Info.Received.Project? { get set }
}

class EditProjectDetailsInteractor: EditProjectDetailsDataStore {
    
    private var worker: EditProjectDetailsWorkerProtocol
    var presenter: EditProjectDetailsPresentationLogic
    
    var receivedData: EditProjectDetails.Info.Received.Project?
    
    init(worker: EditProjectDetailsWorkerProtocol = EditProjectDetailsWorker(),
         viewController: EditProjectDetailsDisplayLogic) {
        self.worker = worker
        self.presenter = EditProjectDetailsPresenter(viewController: viewController)
    }
}

extension EditProjectDetailsInteractor: EditProjectDetailsBusinessLogic {
    
}
