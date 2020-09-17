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
    var currentUserId: ConnectionsList.Info.Model.User? { get }
    var connections: ConnectionsList.Info.Model.UserConnections? { get set }
    var selectedUser: ConnectionsList.Info.Model.SelectedUser? { get set }
}

class ConnectionsListInteractor: ConnectionsListDataStore {
    
    var presenter: ConnectionsListPresentationLogic
    private var worker: ConnectionsListWorkerProtocol
    
    var currentUserId: ConnectionsList.Info.Model.User?
    var userData: ConnectionsList.Info.Received.User?
    var connections: ConnectionsList.Info.Model.UserConnections?
    var selectedUser: ConnectionsList.Info.Model.SelectedUser?
    
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
        fetchCurrentUser(connections: connections)
    }
    
    private func fetchCurrentUser(connections: [ConnectionsList.Info.Model.Connection]) {
        worker.fetchCurrentUser(ConnectionsList.Request.FetchCurrentUser()) { response in
            switch response {
            case .success(let data):
                self.currentUserId = ConnectionsList
                    .Info
                    .Model
                    .User(id: data.id ?? .empty)
                self.connections = ConnectionsList.Info.Model.UserConnections(userType: self.currentUserId?.id == self.userData?.id ? .logged : .other,
                connections: connections)
                guard let connections = self.connections else { return }
                self.presenter.presentConnectionList(connections)
            case .error(let error):
                self.presenter.presentLoading(false)
                self.presenter.presentError(ConnectionsList.Errors.Model(error: error))
            }
        }
    }
}

extension ConnectionsListInteractor: ConnectionsListBusinessLogic {
    
    func fetchConnectionList(_ request: ConnectionsList.Request.FetchConnections) {
        presenter.presentLoading(true)
        guard let userId = userData?.id else { return }
        worker.fetchConnections(ConnectionsList.Request.FetchConnectionsWithId(userId: userId)) { response in
            switch response {
            case .success(let data):
                self.presenter.presentLoading(false)
                self.buildConnectionsModel(data)
            case .error(let error):
                self.presenter.presentLoading(false)
                self.presenter.presentError(ConnectionsList.Errors.Model(error: error))
            }
        }
    }
    
    func fetchUserDetails(_ request: ConnectionsList.Request.FetchUserDetails) {
        let userModel = ConnectionsList.Info.Model.CurrentUser(id: userData?.id ?? .empty, name: userData?.name ?? .empty)
        presenter.presentUserDetails(userModel)
    }
    
    func fetchProfileDetails(_ request: ConnectionsList.Request.FetchProfileDetails) {
        presenter.presentLoading(true)
        guard let userId = connections?.connections[request.index].userId else { return }
        self.selectedUser = ConnectionsList.Info.Model.SelectedUser(id: userId)
        self.presenter.presentProfileDetails()
    }
    
    func fetchRemoveConnection(_ request: ConnectionsList.Request.FetchRemoveConnection) {
        guard let userId = connections?.connections[request.index].userId else { return }
        presenter.presentLoading(true)
        worker.fetchRemoveConnection(ConnectionsList
            .Request
            .FetchRemoveConnectionWithId(userId: userId)) { response in
                switch response {
                case .success:
                    self.presenter.presentLoading(false)
                    self.connections?.connections.removeAll(where: { $0.userId == userId })
                    guard let connections = self.connections else { return }
                    self.presenter.presentConnectionList(connections)
                    break
                case .error(let error):
                    self.presenter.presentLoading(false) 
                    self.presenter.presentError(ConnectionsList.Errors.Model(error: error))
                    break
                }
        }
    }
}
