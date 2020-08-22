//
//  EditProjectDetailsRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 21/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

typealias EditProjectDetailsRouterProtocol = NSObject & EditProjectDetailsRoutingLogic & EditProjectDetailsDataTransfer

protocol EditProjectDetailsRoutingLogic {
    func routeBack()
    func routeToInviteList()
    func routeToPublishedProjectDetails()
}

protocol EditProjectDetailsDataTransfer {
    var dataStore: EditProjectDetailsDataStore? { get set }
}

class EditProjectDetailsRouter: NSObject, EditProjectDetailsDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: EditProjectDetailsDataStore?
}

extension EditProjectDetailsRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        
    }
}

extension EditProjectDetailsRouter: EditProjectDetailsRoutingLogic {
    
    func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func routeToInviteList() {
        
    }
    
    func routeToPublishedProjectDetails() {
        
    }
}
