//
//  ProfileDetailsController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol ProfileDetailsDisplayLogic: class {
    
}

class ProfileDetailsController: BaseViewController {
    
    private lazy var mainView: ProfileDetailsView = {
        return ProfileDetailsView(frame: .zero)
    }()
    
    private var interactor: ProfileDetailsBusinessLogic?
    private var router: ProfileDetailsRouterProtocol?
    
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
        self.view = mainView
    }
    
    private func setup() {
        let viewController = self
        let interactor = ProfileDetailsInteractor(viewController: viewController)
        let router = ProfileDetailsRouter()
        viewController.router = router
        router.dataStore = interactor
        router.viewController = viewController
        viewController.interactor = interactor
    }
}

extension ProfileDetailsController: ProfileDetailsDisplayLogic {
    
}
