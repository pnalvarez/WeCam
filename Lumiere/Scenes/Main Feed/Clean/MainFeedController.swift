//
//  MainFeedController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol MainFeedDisplayLogic: class {
    
}

class MainFeedController: BaseViewController {
    
    private var interactor: MainFeedBusinessLogic?
    var router: MainFeedRouterProtocol?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        let viewController = self
        let presenter = MainFeedPresenter(viewController: viewController)
        let interactor = MainFeedInteractor(presenter: presenter)
        let router = MainFeedRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.dataStore = interactor
        router.viewController = viewController
    }
}

extension MainFeedController: MainFeedDisplayLogic {
    
}
