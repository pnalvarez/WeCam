//
//  InsertMediaPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 04/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol InsertMediaPresentationLogic {
    
}

class InsertMediaPresenter: InsertMediaPresentationLogic {
    
    private unowned var viewController: InsertMediaDisplayLogic
    
    init(viewController: InsertMediaDisplayLogic) {
        self.viewController = viewController
    }
}
