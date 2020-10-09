//
//  ProjectProgressPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 20/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol ProjectProgressPresentationLogic {
    func presentEditProjectDetails()
}

class ProjectProgressPresenter: ProjectProgressPresentationLogic {
    
    private unowned var viewController: ProjectProgressDisplayLogic
    
    init(viewController: ProjectProgressDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentEditProjectDetails() {
        viewController.displayEditProjectDetails()
    }
}
