//
//  OnGoingProjectInvitesRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 12/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

typealias OnGoingProjectInvitesRouterProtocol = NSObject & OnGoingProjectInvitesRoutingLogic & OnGoingProjectInvitesDataTransfer

protocol OnGoingProjectInvitesRoutingLogic {
    func routeBack()
    func routeToProfileDetails()
}

protocol OnGoingProjectInvitesDataTransfer {
    var dataStore: OnGoingProjectInvitesDataStore? { get set }
}

class OnGoingProjectInvitesRouter: NSObject, OnGoingProjectInvitesDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: OnGoingProjectInvitesDataStore?
}

extension OnGoingProjectInvitesRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        
    }
}

extension OnGoingProjectInvitesRouter: OnGoingProjectInvitesRoutingLogic {
    
    func routeBack() {
        
    }
    
    func routeToProfileDetails() {
        
    }
}
