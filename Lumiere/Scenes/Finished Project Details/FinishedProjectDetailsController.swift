//
//  FinishedProjectDetailsController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 08/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol FinishedProjectDetailsDisplayLogic: class {
    
}

class FinishedProjectDetailsController: BaseViewController {
    
    private var interactor: FinishedProjectDetailsBusinessLogic?
    var router: FinishedProjectDetailsRouterProtocol?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
    }
    
    private func setup() {
        let viewController = self
        let presenter = FinishedProjectDetailsPresenter(viewController: viewController)
        let interactor = FinishedProjectDetailsInteractor(presenter: presenter)
        let router = FinishedProjectDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension FinishedProjectDetailsController: FinishedProjectDetailsDisplayLogic {
    
}
