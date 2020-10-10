//
//  ProfileSuggestionsController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 10/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol ProfileSuggestionsDisplayLogic: class {
    
}

class ProfileSuggestionsController: BaseViewController {
    
    private var interactor: ProfileSuggestionsInteractor?
    var router: ProfileSuggestionsRouter?
    
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    private func setup() {
        let viewController = self
        let presenter = ProfileSuggestionsPresenter(viewController: viewController)
        let interactor = ProfileSuggestionsInteractor(presenter: presenter)
        let router = ProfileSuggestionsRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.dataStore = interactor
        router.viewController = viewController
    }
}

extension ProfileSuggestionsController: ProfileSuggestionsDisplayLogic {
    
}
