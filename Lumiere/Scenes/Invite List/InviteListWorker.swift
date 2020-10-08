//
//  InviteListWorker.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 24/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol InviteListWorkerProtocol {
    func fetchConnections(_ request: InviteList.Request.FetchConnections,
                          completion: @escaping (BaseResponse<[InviteList.Info.Response.User]>) -> Void)
}

class InviteListWorker: InviteListWorkerProtocol {
    
    private let builder: FirebaseManagerProtocol
    
    init(builder: FirebaseManagerProtocol = FirebaseManager()) {
        self.builder = builder
    }
    
    func fetchConnections(_ request: InviteList.Request.FetchConnections,
                          completion: @escaping (BaseResponse<[InviteList.Info.Response.User]>) -> Void) {
        builder.fetchCurrentUserConnections(completion: completion)
    }
}
