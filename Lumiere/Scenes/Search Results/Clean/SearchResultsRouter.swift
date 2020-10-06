//
//  SearchResultsRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 29/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

typealias SearchResultsRouterProtocol = NSObject & SearchResultsRoutingLogic & SearchResultsDataTransfer

protocol SearchResultsRoutingLogic {
    func routeBack()
    func routeToProjectDetails()
    func routeToProfileDetails()
}

protocol SearchResultsDataTransfer {
    var dataStore: SearchResultsDataStore? { get }
}

class SearchResultsRouter: NSObject, SearchResultsDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: SearchResultsDataStore?
}

extension SearchResultsRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        
    }
}

extension SearchResultsRouter: SearchResultsRoutingLogic {
    
    func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func routeToProjectDetails() {
        
    }
    
    func routeToProfileDetails() {
        
    }
}
