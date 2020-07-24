//
//  SignUpPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 03/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol SignUpPresentationLogic {
    func didFetchMovieStyles(_ styles: [MovieStyle])
    
}

class SignUpPresenter: SignUpPresentationLogic {
    
    private unowned var viewController: SignUpDisplayLogic
    
    init(viewController: SignUpDisplayLogic) {
        self.viewController = viewController
    }
    
    func didFetchMovieStyles(_ styles: [MovieStyle]) {
        viewController.displayMovieStyles(styles)
    }
}
