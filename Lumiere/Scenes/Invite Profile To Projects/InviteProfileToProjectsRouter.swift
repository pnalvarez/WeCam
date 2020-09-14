//
//  InviteProfileToProjectsRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 13/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

typealias InviteProfileToProjectsRouterProtocol = NSObject & InviteProfileToProjectsRoutingLogic & InviteProfileToProjectsDataTransfer

protocol InviteProfileToProjectsRoutingLogic {
    
}

protocol InviteProfileToProjectsDataTransfer {
    var dataStore: InviteProfileToProjectsDataStore? { get set }
}

class InviteProfileToProjectsRouter: NSObject, InviteProfileToProjectsDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: InviteProfileToProjectsDataStore?
}

extension InviteProfileToProjectsRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        
    }
}

extension InviteProfileToProjectsRouter: InviteProfileToProjectsRoutingLogic {
    
}