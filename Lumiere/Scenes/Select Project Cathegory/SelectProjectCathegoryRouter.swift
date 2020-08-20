//
//  SelectProjectCathegoryRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

typealias SelectProjectCathegoryRouterProtocol = NSObject & SelectProjectCathegoryRoutingLogic & SelectProjectCathegoryDataTransfer

protocol SelectProjectCathegoryRoutingLogic {
    func routeToProjectProgress()
    func routeBack()
}

protocol SelectProjectCathegoryDataTransfer {
    var dataStore: SelectProjectCathegoryDataStore? { get set }
}

class SelectProjectCathegoryRouter: NSObject, SelectProjectCathegoryDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: SelectProjectCathegoryDataStore?

}

extension SelectProjectCathegoryRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        viewController?.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension SelectProjectCathegoryRouter: SelectProjectCathegoryRoutingLogic {
    
    func routeToProjectProgress() {
    
    }
    
    func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
