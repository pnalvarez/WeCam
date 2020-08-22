//
//  OnGoingProjectDetailsPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 22/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol OnGoingProjectDetailsPresentationLogic {
    
}

class OnGoingProjectDetailsPresenter: OnGoingProjectDetailsPresentationLogic {
    
    private unowned var viewController: OnGoingProjectDetailsDisplayLogic
    
    init(viewController: OnGoingProjectDetailsDisplayLogic) {
        self.viewController = viewController
    }
}
