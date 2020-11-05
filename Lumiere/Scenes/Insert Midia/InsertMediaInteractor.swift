//
//  InsertMediaInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 04/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol InsertMediaBusinessLogic {
    
}

protocol InsertMediaDataStore {
    
}

class InsertMediaInteractor: InsertMediaDataStore {
    
    private let worker: InsertMediaWorkerProtocol
    private let presenter: InsertMediaPresentationLogic
    
    init(worker: InsertMediaWorkerProtocol = InsertMediaWorker(),
         presenter: InsertMediaPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
}

extension InsertMediaInteractor: InsertMediaBusinessLogic {
    
}
