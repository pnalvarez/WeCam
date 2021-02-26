//
//  AccountRecoveryWorker.swift
//  WeCam
//
//  Created by Pedro Alvarez on 25/02/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

protocol AccountRecoveryWorkerProtocol {
    
}

class AccountRecoveryWorker: AccountRecoveryWorkerProtocol {
    
    private let builder: FirebaseManagerProtocol
    
    init(builder: FirebaseManagerProtocol = FirebaseManager()) {
        self.builder = builder
    }
}
