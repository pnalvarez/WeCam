//
//  InviteListRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 24/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

typealias InviteListRouterProtocol = NSObject & InviteListRoutingLogic & InviteListDataTransfer

protocol InviteListRoutingLogic {
    func routeBack()
}

protocol InviteListDataTransfer {
    var dataStore: InviteListDataStore? { get set }
}

class InviteListRouter: NSObject, InviteListDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: InviteListDataStore?
}

extension InviteListRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        
    }
}

extension InviteListRouter: InviteListRoutingLogic {
    
    func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
