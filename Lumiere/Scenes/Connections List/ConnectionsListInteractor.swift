//
//  ConnectionsListInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 09/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol ConnectionsListBusinessLogic {
    func fetchConnectionList(_ request: ConnectionsList.Request.FetchConnections)
    func fetchUserDetails(_ request: ConnectionsList.Request.FetchUserDetails)
    func fetchProfileDetails(_ request: ConnectionsList.Request.FetchProfileDetails)
    func fetchRemoveConnection(_ request: ConnectionsList.Request.FetchRemoveConnection)
}

protocol ConnectionsListDataStore {
    var userData: ConnectionsList.Info.Received.User? { get set }
    var connections: ConnectionsList.Info.Model.UserConnections? { get set }
}

class ConnectionsListInteractor: ConnectionsListDataStore {
    
    var presenter: ConnectionsListPresentationLogic
    private var worker: ConnectionsListWorkerProtocol
    
    var userData: ConnectionsList.Info.Received.User?
    var connections: ConnectionsList.Info.Model.UserConnections?
    
    init(viewController: ConnectionsListDisplayLogic,
         worker: ConnectionsListWorkerProtocol = ConnectionsListWorker()) {
        self.presenter = ConnectionsListPresenter(viewController: viewController)
        self.worker = worker
    }
}

extension ConnectionsListInteractor {
    
    private func buildConnectionsModel(_ data: [ConnectionsList.Info.Response.Connection]) {
        var connections: [ConnectionsList.Info.Model.Connection] = []
        for connection in data {
            connections.append(ConnectionsList.Info.Model.Connection(userId: connection.userId ?? .empty,
                                                                     image: connection.image ?? .empty,
                                                                     name: connection.name ?? .empty,
                                                                     ocupation: connection.ocupation ?? .empty))
        }
        self.connections = ConnectionsList.Info.Model.UserConnections(connections: connections)
    }
}

extension ConnectionsListInteractor: ConnectionsListBusinessLogic {
    
    func fetchConnectionList(_ request: ConnectionsList.Request.FetchConnections) {
        presenter.presentLoading(true)
        worker.fetchConnections(request) { response in
            switch response {
            case .success(let data):
                self.presenter.presentLoading(false)
                self.buildConnectionsModel(data)
                guard let connections = self.connections else { return }
                self.presenter.presentConnectionList(connections)
                break
            case .error(let error):
                self.presenter.presentLoading(false)
                break
            }
        }
    }
    
    func fetchUserDetails(_ request: ConnectionsList.Request.FetchUserDetails) {
        let userModel = ConnectionsList.Info.Model.CurrentUser(name: userData?.name ?? .empty)
        presenter.presentUserDetails(userModel)
    }
    
    func fetchProfileDetails(_ request: ConnectionsList.Request.FetchProfileDetails) {
        
    }
    
    func fetchRemoveConnection(_ request: ConnectionsList.Request.FetchRemoveConnection) {
        guard let userId = connections?.connections[request.index].userId else { return }
        worker.fetchRemoveConnection(ConnectionsList
            .Request
            .FetchRemoveConnectionWithId(userId: userId)) { response in
                switch response {
                case .success:
                    self.connections?.connections.removeAll(where: { $0.userId == userId })
                    guard let connections = self.connections else { return }
                    self.presenter.presentConnectionList(connections)
                    break
                case .error(let error):
                    break
                }
        }
    }
}
