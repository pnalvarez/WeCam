//
//  File.swift
//  WeCam
//
//  Created by Pedro Alvarez on 25/02/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol AccountRecoveryDisplayLogic: class {
    
}

class AccountRecoveryController: BaseViewController {
    
    private lazy var messageLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = AccountRecovery.Constants.Texts.messageLbl
        view.font = AccountRecovery.Constants.Fonts.messageLbl
        view.textColor = AccountRecovery.Constants.Colors.messageLbl
        view.textAlignment = .center
        return view
    }()
    
    private lazy var inputTextField: DefaultInputTextField = {
        let view = DefaultInputTextField(frame: .zero)
        return view
    }()
    
    private lazy var closeButton: DefaultCloseButton = {
        let view = DefaultCloseButton(frame: .zero)
        view.associatedViewController = self
        return view
    }()
    
    private lazy var accountUserDisplayView: UserDisplayView = {
        let view = UserDisplayView(frame: .zero)
        return view
    }()
    
    private lazy var actionButton: DefaultActionButton = {
        let view = DefaultActionButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
        return view
    }()
    
    private var interactor: AccountRecoveryBusinessLogic?
    var router: AccountRecoveryRouterProtocol?
    
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
    
    private func setup() {
        let viewController = self
        let presenter = AccountRecoveryPresenter(viewController: viewController)
        let interactor = AccountRecoveryInteractor(presenter: presenter)
        let router = AccountRecoveryRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    @objc
    private func didTapActionButton() {
        
    }
}

extension AccountRecoveryController: AccountRecoveryDisplayLogic {
    
}
