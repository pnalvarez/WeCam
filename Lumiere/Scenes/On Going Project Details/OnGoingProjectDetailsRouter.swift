//
//  OnGoingProjectDetailsRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 22/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

typealias OnGoingProjectDetailsRouterProtocol = NSObject & OnGoingProjectDetailsRoutingLogic & OnGoingProjectDetailsDataTransfer

protocol OnGoingProjectDetailsRoutingLogic {
    
}

protocol OnGoingProjectDetailsDataTransfer {
    var dataStore: OnGoingProjectDetailsDataStore? { get set }
}

class OnGoingProjectDetailsRouter: NSObject, OnGoingProjectDetailsDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: OnGoingProjectDetailsDataStore?
}

extension OnGoingProjectDetailsRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        
    }
}

extension OnGoingProjectDetailsRouter: OnGoingProjectDetailsRoutingLogic {
    
}
