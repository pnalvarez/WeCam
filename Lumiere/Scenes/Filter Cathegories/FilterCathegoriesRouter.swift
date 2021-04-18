//
//  FilterCathegoriesRouter.swift
//  WeCam
//
//  Created by Pedro Alvarez on 18/04/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit

typealias FilterCathegoriesRouterProtocol = NSObject & FilterCathegoriesRoutingLogic & FilterCathegoriesDataTransfer

protocol FilterCathegoriesRoutingLogic {
    func routeToMainFeed()
}

protocol FilterCathegoriesDataTransfer {
    var dataStore: FilterCathegoriesDataStore? { get set }
}

class FilterCathegoriesRouter: NSObject, FilterCathegoriesDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: FilterCathegoriesDataStore?
}

extension FilterCathegoriesRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        
    }
}

extension FilterCathegoriesRouter: FilterCathegoriesRoutingLogic {
    
    func routeToMainFeed() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
