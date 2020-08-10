//
//  ConnectionsListWorker.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 09/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol ConnectionsListWorkerProtocol {
    func fetchConnections(_ request: ConnectionsList.Request.FetchConnections,
                          completion: @escaping (BaseResponse<[ConnectionsList.Info.Response.Connection]>) -> Void)
    func fetchRemoveConnection(_ request: ConnectionsList.Request.FetchRemoveConnectionWithId,
                               completion: @escaping (EmptyResponse) -> Void)
}

class ConnectionsListWorker: ConnectionsListWorkerProtocol {
    
    private let builder: FirebaseAuthHelperProtocol
    
    init() {
        self.builder = FirebaseAuthHelper()
    }
    
    func fetchConnections(_ request: ConnectionsList.Request.FetchConnections,
                          completion: @escaping (BaseResponse<[ConnectionsList.Info.Response.Connection]>) -> Void) {
        builder.fetchCurrentUserConnections(completion: completion)
    }
    
    func fetchRemoveConnection(_ request: ConnectionsList.Request.FetchRemoveConnectionWithId,
                               completion: @escaping (EmptyResponse) -> Void) {
        builder.fetchRemoveConnection(request: ["userId" : request.userId], completion: completion)
    }
}
