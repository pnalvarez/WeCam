//
//  ConnectionsListInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 09/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol ConnectionsListBusinessLogic {
    
}

protocol ConnectionsListDataStore {
    
}

class ConnectionsListInteractor: ConnectionsListDataStore {
    
    var presenter: ConnectionsListPresentationLogic
    private var worker: ConnectionsListWorkerProtocol
    
    init(viewController: ConnectionsListDisplayLogic,
         worker: ConnectionsListWorkerProtocol = ConnectionsListWorker()) {
        self.presenter = ConnectionsListPresenter(viewController: viewController)
        self.worker = worker
    }
}

extension ConnectionsListInteractor: ConnectionsListBusinessLogic {
    
}
