//
//  InviteListPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 24/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol InviteListPresentationLogic {
    func presentConnections(_ response: InviteList.Info.Model.Connections)
    func presentLoading(_ loading: Bool)
}

class InviteListPresenter: InviteListPresentationLogic {
    
    private unowned var viewController: InviteListDisplayLogic
    
    init(viewController: InviteListDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentLoading(_ loading: Bool) {
        viewController.defaultScreenLoading(!loading)
    }
    
    func presentConnections(_ response: InviteList.Info.Model.Connections) {
        let viewModel = InviteList
            .Info
            .ViewModel
            .Connections(users: response.users.map({ InviteList.Info.ViewModel.User(name: $0.name,
                                                                                    image: $0.image,
                                                                                    email: $0.email,
                                                                                    ocupation: $0.ocupation,
                                                                                    inviting: $0.inviting) }))
        viewController.displayConnections(viewModel)
    }
}
