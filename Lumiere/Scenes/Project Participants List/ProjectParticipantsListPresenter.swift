//
//  ProjectParticipantsListPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 05/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol ProjectParticipantsListPresentationLogic {
    
}

class ProjectParticipantsListPresenter: ProjectParticipantsListPresentationLogic {
    
    private unowned var viewController: ProjectParticipantsListDisplayLogic
    
    init(viewController: ProjectParticipantsListDisplayLogic) {
        self.viewController = viewController
    }
}
