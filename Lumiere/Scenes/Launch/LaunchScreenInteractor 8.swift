//
//  LaunchScreenInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 02/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol LaunchScreenBusinessRules {
    var presenter: LaunchScreenPresentationLogic { get set}
    func fetchLaunchImage()
}

class LaunchScreenInteractor: LaunchScreenBusinessRules {
    
    var presenter: LaunchScreenPresentationLogic
    
    init(viewController: LaunchScreenDisplayLogic) {
        self.presenter = LaunchScreenPresenter(viewController: viewController)
    }
    
    func fetchLaunchImage() {
        presenter.displayImage()
    }
}
