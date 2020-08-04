//
//  NotificationsRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

typealias NotificationsRouterProtocol = NSObject & NotificationsRoutingLogic & NotificationsDataTransfer

protocol NotificationsRoutingLogic {
    
}

protocol NotificationsDataTransfer {
    var dataStore: NotificationsDataStore? { get set }
}

class NotificationsRouter: NSObject, NotificationsDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: NotificationsDataStore?
}

extension NotificationsRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        
    }
}

extension NotificationsRouter: NotificationsRoutingLogic {
    
}
