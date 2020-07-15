//
//  ProjectStepsRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 14/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

typealias ProjectStepRouterProtocol = NSObject & ProjectStepRoutingLogic & ProjectStepDataTransfer

protocol ProjectStepRoutingLogic {
    
}

protocol ProjectStepDataTransfer {
    var dataStore: ProjectStepDataStore? { get set }
}

class ProjectStepRouter: NSObject, ProjectStepDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: ProjectStepDataStore?
}

extension ProjectStepRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        
    }
}

extension ProjectStepRouter: ProjectStepRoutingLogic {
    
}
