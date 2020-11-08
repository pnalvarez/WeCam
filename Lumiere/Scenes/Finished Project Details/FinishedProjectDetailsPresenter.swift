//
//  FinishedProjectDetailsPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 08/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol FinishedProjectDetailsPresentationLogic {
    
}

class FinishedProjectDetailsPresenter: FinishedProjectDetailsPresentationLogic {
    
    private unowned var viewController: FinishedProjectDetailsDisplayLogic
    
    init(viewController: FinishedProjectDetailsDisplayLogic) {
        self.viewController = viewController
    }
}
