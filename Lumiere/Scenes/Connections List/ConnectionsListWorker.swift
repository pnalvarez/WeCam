//
//  ConnectionsListWorker.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 09/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol ConnectionsListWorkerProtocol {
    func fetchConnections(_ request: ConnectionsList.Request.FetchConnectionsWithId,
                          completion: @escaping (BaseResponse<[ConnectionsList.Info.Response.Connection]>) -> Void)
    func fetchCurrentUser(_ request: ConnectionsList.Request.FetchCurrentUser,
                          completion: @escaping (BaseResponse<ConnectionsList.Info.Response.CurrentUser>) -> Void)
    func fetchRemoveConnection(_ request: ConnectionsList.Request.FetchRemoveConnectionWithId,
                               completion: @escaping (EmptyResponse) -> Void)
    func fetchProfileDetails(_ request: ConnectionsList.Request.FetchProfileDetailsWithId,
                             completion: @escaping (BaseResponse<ConnectionsList.Info.Response.ProfileDetails>) -> Void)
}

class ConnectionsListWorker: ConnectionsListWorkerProtocol {
    
    private let builder: FirebaseAuthHelperProtocol
    
    init() {
        self.builder = FirebaseAuthHelper()
    }
    
    func fetchConnections(_ request: ConnectionsList.Request.FetchConnectionsWithId,
                          completion: @escaping (BaseResponse<[ConnectionsList.Info.Response.Connection]>) -> Void) {
        let headers: [String : Any] = ["userId": request.userId]
        builder.fetchUserConnections(request: headers, completion: completion)
    }
    
    func fetchCurrentUser(_ request: ConnectionsList.Request.FetchCurrentUser,
                          completion: @escaping (BaseResponse<ConnectionsList.Info.Response.CurrentUser>) -> Void) {
        let headers: [String : Any] = .empty
        builder.fetchCurrentUser(request: headers, completion: completion)
    }
    
    func fetchRemoveConnection(_ request: ConnectionsList.Request.FetchRemoveConnectionWithId,
                               completion: @escaping (EmptyResponse) -> Void) {
        builder.fetchRemoveConnection(request: ["userId" : request.userId],
                                      completion: completion)
    }
    
    func fetchProfileDetails(_ request: ConnectionsList.Request.FetchProfileDetailsWithId,
                             completion: @escaping (BaseResponse<ConnectionsList.Info.Response.ProfileDetails>) -> Void) {
        builder.fetchUserData(request: ["userId": request.userId], completion: completion)
    }
}
