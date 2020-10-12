//
//  LaunchScreenPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 02/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol LaunchScreenPresentationLogic {
    func displayImage()
}

class LaunchScreenPresenter: LaunchScreenPresentationLogic {
    
    private unowned var viewController: LaunchScreenDisplayLogic
    
    init(viewController: LaunchScreenDisplayLogic) {
        self.viewController = viewController
    }
    
    func displayImage() {
        viewController.displayLaunchImage()
    }
}
