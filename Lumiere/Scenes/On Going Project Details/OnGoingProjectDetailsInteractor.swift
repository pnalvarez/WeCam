//
//  OnGoingProjectDetailsInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 22/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol OnGoingProjectDetailsBusinessLogic {
    
}

protocol OnGoingProjectDetailsDataStore {
    
}

class OnGoingProjectDetailsInteractor: OnGoingProjectDetailsDataStore {
    
    private let worker: OnGoingProjectDetailsWorkerProtocol
    var presenter: OnGoingProjectDetailsPresentationLogic
    
    init(worker: OnGoingProjectDetailsWorkerProtocol = OnGoingProjectDetailsWorker(),
         viewController: OnGoingProjectDetailsDisplayLogic) {
        self.worker = worker
        self.presenter = OnGoingProjectDetailsPresenter(viewController: viewController)
    }
}

extension OnGoingProjectDetailsInteractor: OnGoingProjectDetailsBusinessLogic {
    
}
