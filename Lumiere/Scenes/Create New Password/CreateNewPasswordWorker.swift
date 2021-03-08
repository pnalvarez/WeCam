//
//  CreateNewPasswordWorker.swift
//  WeCam
//
//  Created by Pedro Alvarez on 07/03/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

protocol CreateNewPasswordWorkerProtocol {
    func fetchChangePassword(_ request: CreateNewPassword.Request.ChangePassword,
                             completion: @escaping (EmptyResponse) -> Void)
}

class CreateNewPasswordWorker: CreateNewPasswordWorkerProtocol {
    
    private let builder: FirebaseManagerProtocol
    
    init(builder: FirebaseManager = FirebaseManager()) {
        self.builder = builder
    }
    
    func fetchChangePassword(_ request: CreateNewPassword.Request.ChangePassword,
                             completion: @escaping (EmptyResponse) -> Void) {
        //TO DO
    }
}
