//
//  ProjectProgressRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 20/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

typealias ProjectProgressRouterProtocol = NSObject & ProjectProgressRoutingLogic & ProjectProgressDataTransfer

protocol ProjectProgressRoutingLogic {
    func routeBack()
    func routeToEditProjectDetails()
}

protocol ProjectProgressDataTransfer {
    var dataStore: ProjectProgressDataStore? { get set }
}

class ProjectProgressRouter: NSObject, ProjectProgressDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: ProjectProgressDataStore?
}

extension ProjectProgressRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        viewController?.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension ProjectProgressRouter: ProjectProgressRoutingLogic {
    
    func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func routeToEditProjectDetails() {
        
    }
}


