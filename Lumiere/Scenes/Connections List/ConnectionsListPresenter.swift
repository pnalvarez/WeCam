//
//  ConnectionsListPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 09/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol ConnectionsListPresentationLogic {
    
}

class ConnectionsListPresenter: ConnectionsListPresentationLogic {
    
    private unowned var viewController: ConnectionsListDisplayLogic
    
    init(viewController: ConnectionsListDisplayLogic) {
        self.viewController = viewController
    }
}
