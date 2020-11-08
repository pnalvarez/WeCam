//
//  FinishedProjectDetailsRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 08/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

typealias FinishedProjectDetailsRouterProtocol = NSObject & FinishedProjectDetailsRoutingLogic & FinishedProjectDetailsDataTransfer

protocol FinishedProjectDetailsRoutingLogic {
    
}

protocol FinishedProjectDetailsDataTransfer {
    var dataStore: FinishedProjectDetailsDataStore? { get set }
}

class FinishedProjectDetailsRouter: NSObject, FinishedProjectDetailsDataTransfer {
    
    var dataStore: FinishedProjectDetailsDataStore?
    weak var viewController: UIViewController?
}

extension FinishedProjectDetailsRouter: BaseRouterProtocol {

    func routeTo(nextVC: UIViewController) {
        
    }
}

extension FinishedProjectDetailsRouter: FinishedProjectDetailsRoutingLogic {
    
}
