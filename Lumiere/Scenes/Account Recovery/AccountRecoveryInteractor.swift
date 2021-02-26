//
//  AccountRecoveryInteractor.swift
//  WeCam
//
//  Created by Pedro Alvarez on 25/02/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

protocol AccountRecoveryBusinessLogic {
    
}

protocol AccountRecoveryDataStore: class {
    
}

class AccountRecoveryInteractor: AccountRecoveryDataStore {
    
    private let worker: AccountRecoveryWorkerProtocol
    private let presenter: AccountRecoveryPresentationLogic
    
    init(worker: AccountRecoveryWorkerProtocol = AccountRecoveryWorker(),
         presenter: AccountRecoveryPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
}

extension AccountRecoveryInteractor: AccountRecoveryBusinessLogic {
    
}
