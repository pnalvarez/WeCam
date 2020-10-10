//
//  ProfileSuggestionsPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 10/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol ProfileSuggestionsPresentationLogic {
    
}

class ProfileSuggestionsPresenter: ProfileSuggestionsPresentationLogic {
    
    private unowned var viewController: ProfileSuggestionsDisplayLogic
    
    init(viewController: ProfileSuggestionsDisplayLogic) {
        self.viewController = viewController
    }
}
