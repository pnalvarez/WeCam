//
//  ProfileDetailsPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol ProfileDetailsPresentationLogic {
    
}

class ProfileDetailsPresenter: ProfileDetailsPresentationLogic {
    
    private unowned var viewController: ProfileDetailsDisplayLogic
    
    init(viewController: ProfileDetailsDisplayLogic) {
        self.viewController = viewController
    }
}
