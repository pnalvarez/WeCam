//
//  ProjectParticipantsListRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 05/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

typealias ProjectParticipantsListRouterProtocol = NSObject & ProjectParticipantsListRoutingLogic & ProjectParticipantsListDataTransfer

protocol ProjectParticipantsListRoutingLogic {
    
}

protocol ProjectParticipantsListDataTransfer {
    var dataStore: ProjectParticipantsListDataStore? { get set }
}

class ProjectParticipantsListRouter: NSObject, ProjectParticipantsListDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: ProjectParticipantsListDataStore?
}

extension ProjectParticipantsListRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        
    }
}

extension ProjectParticipantsListRouter: ProjectParticipantsListRoutingLogic {
    
}
