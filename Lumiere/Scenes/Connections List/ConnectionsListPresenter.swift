//
//  ConnectionsListPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 09/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol ConnectionsListPresentationLogic {
    func presentUserDetails(_ response: ConnectionsList.Info.Model.CurrentUser)
    func presentConnectionList(_ response: ConnectionsList.Info.Model.UserConnections)
    func presentLoading(_ loading: Bool)
    func presentProfileDetails()
}

class ConnectionsListPresenter: ConnectionsListPresentationLogic {
    
    private unowned var viewController: ConnectionsListDisplayLogic
    
    init(viewController: ConnectionsListDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentUserDetails(_ response: ConnectionsList.Info.Model.CurrentUser) {
        let viewModel = ConnectionsList.Info.ViewModel.CurrentUser(name: response.name)
        viewController.displayCurrentUser(viewModel)
    }
    
    func presentConnectionList(_ response: ConnectionsList.Info.Model.UserConnections) {
        let viewModel = buildUpcomingConnections(response)
        viewController.displayConnections(viewModel)
    }
    
    func presentLoading(_ loading: Bool) {
        viewController.displayLoading(loading)
    }
    
    func presentProfileDetails() {
        viewController.displayProfileDetails()
    }
}

extension ConnectionsListPresenter {
    
    private func buildUpcomingConnections(_ model: ConnectionsList.Info.Model.UserConnections) -> ConnectionsList.Info.ViewModel.UpcomingConnections {
        var connections = [ConnectionsList.Info.ViewModel.Connection]()
        for connection in model.connections {
            let viewModel = ConnectionsList.Info.ViewModel.Connection(image: connection.image,
                                                                      name: connection.name,
                                                                      ocupation: connection.ocupation)
            connections.append(viewModel)
        }
        return ConnectionsList.Info.ViewModel.UpcomingConnections(connections: connections)
    }
}
