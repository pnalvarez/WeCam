//
//  InviteProfileToProjectsPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 13/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol InviteProfileToProjectsPresentationLogic {
    
}

class InviteProfileToProjectsPresenter: InviteProfileToProjectsPresentationLogic {
    
    private unowned var viewController: InviteProfileToProjectsDisplayLogic
    
    init(viewController: InviteProfileToProjectsDisplayLogic) {
        self.viewController = viewController
    }
}
