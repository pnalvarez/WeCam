//
//  AccountRecoveryWorker.swift
//  WeCam
//
//  Created by Pedro Alvarez on 25/02/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

protocol AccountRecoveryWorkerProtocol {
    func fetchUserData(_ request: AccountRecovery.Request.SearchAccount,
                       completion: @escaping (BaseResponse<AccountRecovery.Info.Response.User>) -> Void)
    func fetchSendRecoveryEmail(_ request: AccountRecovery.Request.SendRecoveryEmail,
                                completion: @escaping (EmptyResponse) -> Void)
}

class AccountRecoveryWorker: AccountRecoveryWorkerProtocol {
    
    private let builder: FirebaseManagerProtocol
    
    init(builder: FirebaseManagerProtocol = FirebaseManager()) {
        self.builder = builder
    }
    
    func fetchUserData(_ request: AccountRecovery.Request.SearchAccount,
                       completion: @escaping (BaseResponse<AccountRecovery.Info.Response.User>) -> Void) {
        let headers: [String : Any] = ["email": request.email]
        builder.fetchUserDataByEmail(request: headers, completion: completion)
    }
    
    func fetchSendRecoveryEmail(_ request: AccountRecovery.Request.SendRecoveryEmail,
                                completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["email": request.email]
        builder.sendPasswordRecoveryEmail(request: headers, completion: completion)
    }
}
