//
//  SignUpPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 03/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol SignUpPresentationLogic {
    
}

class SignUpPresenter: SignUpPresentationLogic {
    
    private unowned var viewController: SignUpDisplayLogic
    
    init(viewController: SignUpDisplayLogic) {
        self.viewController = viewController
    }
}
