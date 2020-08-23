//
//  EditProfileDetailsPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 23/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol EditProfileDetailsPresentationLogic {
    
}

class EditProfileDetailsPresenter: EditProfileDetailsPresentationLogic {
    
    private unowned var viewController: EditProfileDetailsDisplayLogic
    
    init(viewController: EditProfileDetailsDisplayLogic) {
        self.viewController = viewController
    }
}
