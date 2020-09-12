//
//  OnGoingProjectInvitesPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 12/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol OnGoingProjectInvitesPresentationLogic {
    
}

class OnGoingProjectInvitesPresenter: OnGoingProjectInvitesPresentationLogic {
    
    private unowned var viewController: OnGoingProjectInvitesDisplayLogic
    
    init(viewController: OnGoingProjectInvitesDisplayLogic) {
        self.viewController = viewController
    }
}

