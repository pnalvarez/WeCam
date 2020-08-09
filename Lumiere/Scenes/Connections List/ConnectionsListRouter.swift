//
//  ConnectionsListRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 09/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

typealias ConnectionsListRouterProtocol = NSObject & ConnectionsListRoutingLogic & ConnectionsListDataTransfer

protocol ConnectionsListRoutingLogic {
    
}

protocol ConnectionsListDataTransfer {
    var dataStore: ConnectionsListDataStore? { get set }
}

class ConnectionsListRouter: NSObject, ConnectionsListDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: ConnectionsListDataStore?
}

extension ConnectionsListRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        
    }
}

extension ConnectionsListRouter: ConnectionsListRoutingLogic {
    
}

