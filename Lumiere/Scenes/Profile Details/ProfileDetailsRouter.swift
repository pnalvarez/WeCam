//
//  ProfileDetailsRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

typealias ProfileDetailsRouterProtocol = NSObject & ProfileDetailsRoutingLogic & ProfileDetailsDataTransfer

protocol ProfileDetailsRoutingLogic {
    func routeBack()
}

protocol ProfileDetailsDataTransfer {
    var dataStore: ProfileDetailsDataStore? { get set }
}

class ProfileDetailsRouter: NSObject, ProfileDetailsDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: ProfileDetailsDataStore?
}

extension ProfileDetailsRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        
    }
}

extension ProfileDetailsRouter: ProfileDetailsRoutingLogic {
    
    func routeBack() {
        
    }
}
