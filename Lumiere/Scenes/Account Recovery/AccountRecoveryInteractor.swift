//
//  AccountRecoveryInteractor.swift
//  WeCam
//
//  Created by Pedro Alvarez on 25/02/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

protocol AccountRecoveryBusinessLogic {
    func searchUser(_ request: AccountRecovery.Request.SearchAccount)
    func sendRecoveryEmail(_ request: AccountRecovery.Request.SendRecoveryEmail)
}

protocol AccountRecoveryDataStore: class {
    var userData: AccountRecovery.Info.Model.Account? { get }
}

class AccountRecoveryInteractor: AccountRecoveryDataStore {
    
    private let worker: AccountRecoveryWorkerProtocol
    private let presenter: AccountRecoveryPresentationLogic
    
    var userData: AccountRecovery.Info.Model.Account?
    
    init(worker: AccountRecoveryWorkerProtocol = AccountRecoveryWorker(),
         presenter: AccountRecoveryPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
}

extension AccountRecoveryInteractor: AccountRecoveryBusinessLogic {

    func searchUser(_ request: AccountRecovery.Request.SearchAccount) {
        
    }
    
    func sendRecoveryEmail(_ request: AccountRecovery.Request.SendRecoveryEmail) {
        
    }
}
