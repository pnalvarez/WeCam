//
//  InviteListInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 24/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol InviteListBusinessLogic {
    func fetchConnections(_ request: InviteList.Request.FetchConnections)
    func fetchSelectUser(_ request: InviteList.Request.SelectUser)
    func fetchSearch(_ request: InviteList.Request.Search)
}

protocol InviteListDelegate: class {
    func didSelectUser(_ userId: String)
    func didUnselectUser(_ userId: String)
}

protocol InviteListDataStore {
    var receivedInvites: InviteList.Info.Received.InvitedUsers? { get set }
    var connections: InviteList.Info.Model.Connections? { get set }
    var delegate: InviteListDelegate? { get set }
}

class InviteListInteractor: InviteListDataStore {
    
    private let worker: InviteListWorkerProtocol
    private let presenter: InviteListPresentationLogic
    
    var receivedInvites: InviteList.Info.Received.InvitedUsers?
    var connections: InviteList.Info.Model.Connections?
    weak var delegate: InviteListDelegate?
    
    init(worker: InviteListWorkerProtocol = InviteListWorker(),
         presenter: InviteListPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
}

extension InviteListInteractor {
    
    private func buildUsers(data: [InviteList.Info.Response.User]) -> InviteList.Info.Model.Connections {
        var connections: [InviteList.Info.Model.User] = []
        for user in data {
            connections.append(InviteList.Info.Model.User(id: user.id ?? .empty,
                                                          image: user.image ?? .empty,
                                                          name: user.name ?? .empty,
                                                          email: user.email ?? .empty,
                                                          ocupation: user.ocupation ?? .empty,
                                                          inviting: false))
        }
        return InviteList.Info.Model.Connections(users: connections)
    }
}

extension InviteListInteractor: InviteListBusinessLogic {
    
    func fetchConnections(_ request: InviteList.Request.FetchConnections) {
        presenter.presentLoading(true)
        worker.fetchConnections(request) { response in
            switch response {
            case .success(let data):
                self.presenter.presentLoading(false)
                self.connections = self.buildUsers(data: data)
                guard let connections = self.connections else { return }
                self.presenter.presentConnections(connections)
                break
            case .error(let error):
                break
            }
        }
    }
    
    func fetchSelectUser(_ request: InviteList.Request.SelectUser) {
        guard let connectionUsers = connections,
            let userId = connections?.users[request.index].id else { return }
        let inviting = connectionUsers.users[request.index].inviting
        connections?.users[request.index].inviting = !inviting
        if inviting {
            delegate?.didUnselectUser(userId)
        } else {
            delegate?.didSelectUser(userId)
        }
        guard let connections = connections else { return }
        presenter.presentConnections(connections)
    }
    
    func fetchSearch(_ request: InviteList.Request.Search) {
        guard let resultUsers = connections?.users.filter({$0.name.hasPrefix(request.preffix)}) else { return }
        let filteredConnections = InviteList.Info.Model.Connections(users: resultUsers)
        presenter.presentConnections(filteredConnections)
    }
}
