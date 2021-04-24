//
//  File.swift
//  WeCam
//
//  Created by Pedro Alvarez on 25/02/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

protocol AccountRecoveryDisplayLogic: class {
    func displayUserData(_ viewModel: AccountRecovery.Info.ViewModel.Account)
    func displayError(_ viewModel: AccountRecovery.Info.ViewModel.Error)
    func displayLoading(_ loading: Bool)
    func displaySuccessfullySentEmailAlert()
}

class AccountRecoveryController: BaseViewController {
    
    private lazy var messageLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = AccountRecovery.Constants.Texts.messageLblAccountSearch
        view.font = AccountRecovery.Constants.Fonts.messageLbl
        view.textColor = AccountRecovery.Constants.Colors.messageLbl
        view.textAlignment = .center
        return view
    }()
    
    private lazy var searchTextField: WCSearchTextField = {
        let view = WCSearchTextField(frame: .zero)
        view.searchDelegate = self
        return view
    }()
    
    private lazy var accountUserDisplayView: WCUserDisplayView = {
        let view = WCUserDisplayView(frame: .zero, layout: .large)
        view.isHidden = true
        return view
    }()
    
    private lazy var sendEmailButton: WCActionButton = {
        let view = WCActionButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapSendEmailButton), for: .touchUpInside)
        view.setTitle(AccountRecovery.Constants.Texts.sendEmailText, for: .normal)
        view.isHidden = true
        return view
    }()
    
    private lazy var activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.backgroundColor = .white
        view.color = ThemeColors.mainRedColor.rawValue
        view.startAnimating()
        view.isHidden = true
        return view
    }()
    
    private lazy var mainView: AccountRecoveryView = {
        let view = AccountRecoveryView(frame: .zero,
                                       closeButton: closeButton,
                                       messageLbl: messageLbl,
                                       searchTextField: searchTextField,
                                       userDisplayView: accountUserDisplayView,
                                       sendEmailButton: sendEmailButton,
                                       activityView: activityView)
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
    
    override func loadView() {
        super.loadView()
        self.view = mainView
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
    private func didTapSendEmailButton() {
        interactor?.sendRecoveryEmail(AccountRecovery.Request.SendEmail())
    }
}

extension AccountRecoveryController: WCSearchTextFieldDelegate {
    
    func didTapSearch(searchTextField: WCSearchTextField) {
        interactor?.searchUser(AccountRecovery.Request.SearchAccount(email: searchTextField.text ?? .empty))
    }
}

extension AccountRecoveryController: AccountRecoveryDisplayLogic {
    
    func displayUserData(_ viewModel: AccountRecovery.Info.ViewModel.Account) {
        accountUserDisplayView.setup(name: viewModel.name,
                                     ocupation: viewModel.ocupation,
                                     photo: viewModel.image)
        accountUserDisplayView.isHidden =  false
        sendEmailButton.isHidden = false
    }
    
    func displayError(_ viewModel: AccountRecovery.Info.ViewModel.Error) {
        UIAlertController.displayAlert(in: self,
                                       title: viewModel.title,
                                       message: viewModel.message)
    }
    
    func displayLoading(_ loading: Bool) {
        activityView.isHidden = !loading
    }
    
    func displaySuccessfullySentEmailAlert() {
        UIAlertController.displayAlert(in: self,
                                       title: AccountRecovery.Constants.Texts.succefullySentEmailTitle,
                                       message: AccountRecovery.Constants.Texts.succeffullySentEmailMessage) {_ in 
            self.router?.routeToSignIn()
        }
    }
}
