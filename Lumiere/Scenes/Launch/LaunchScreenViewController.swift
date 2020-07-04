//
//  LaunchScreenVC.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol LaunchScreenDisplayLogic: class {
    func displayLaunchImage()
}

class LaunchScreenViewController: BaseViewController {
    
    private lazy var iconView: UIImageView = {
        let iconView = UIImageView(frame: .zero)
        iconView.contentMode = .scaleAspectFit
        iconView.image = UIImage(named: "logo-apenas")
        return iconView
    }()
    
    private lazy var mainView: LaunchScreenView = {
        return LaunchScreenView(frame: .zero,
                                iconView: iconView)
    }()
    
    private var window: UIWindow
    
    private var interactor: LaunchScreenBusinessRules?
    private var router: LaunchScreenRouterProtocol?
    
    init(window: UIWindow) {
        self.window = window
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        interactor?.fetchLaunchImage()
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
}

extension LaunchScreenViewController {
    
    private func setup() {
        let viewController = self
        interactor = LaunchScreenInteractor(viewController: viewController)
        let router = LaunchScreenRouter()
        self.router = router
        self.router?.window = window
    }
}

extension LaunchScreenViewController: LaunchScreenDisplayLogic {
    
    func displayLaunchImage() {
        iconView.image = UIImage(named: LaunchScreen.Constants.displayLaunchImage)
        router?.routeToLoginScreen()
    }
}
