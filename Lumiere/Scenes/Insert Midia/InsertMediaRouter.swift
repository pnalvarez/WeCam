//
//  InsertMediaRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 04/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

typealias InsertMediaRouterProtocol = NSObject & InsertMediaRoutingLogic & InsertMediaDataTransfer

protocol InsertMediaRoutingLogic {
    func routeToFinishedProjectDetails()
    func routeBack()
}

protocol InsertMediaDataTransfer {
    
}

class InsertMediaRouter: NSObject, InsertMediaDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: InsertMediaDataStore?
}

extension InsertMediaRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        
    }
}

extension InsertMediaRouter: InsertMediaRoutingLogic {
    
    func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func routeToFinishedProjectDetails() {
        
    }
}
