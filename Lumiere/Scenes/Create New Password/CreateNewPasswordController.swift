//
//  CreateNewPasswordController.swift
//  WeCam
//
//  Created by Pedro Alvarez on 07/03/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol CreateNewPasswordDisplayLogic: class {
    func displayError(_ viewModel: CreateNewPassword.Info.ViewModel.Error)
    func displayLoading(_ loading: Bool)
    func displaySuccessAlert()
}


class CreateNewPasswordController: BaseViewController {
    
    private lazy var loadingView: LoadingView = {
        let view = LoadingView(frame: .zero)
        view.animateRotate()
        view.isHidden = true
        return view
    }()
    
    private lazy var closeButton: DefaultCloseButton = {
        let view = DefaultCloseButton(frame: .zero)
        view.associatedViewController = self
        return view
    }()
    
    private lazy var passwordTextField: DefaultInputTextField = {
        let view = DefaultInputTextField(frame: .zero)
        view.placeholder = CreateNewPassword.Constants.Texts.passwordPlaceholder
        view.delegate = self
        return view
    }()
    
    private lazy var confirmationTextField: DefaultInputTextField = {
        let view = DefaultInputTextField(frame: .zero)
        view.placeholder = CreateNewPassword.Constants.Texts.confirmationPlaceholder
        view.delegate = self
        return view
    }()
    
    private lazy var changePasswordButton: DefaultActionButton = {
        let view = DefaultActionButton(frame: .zero)
        view.setTitle(CreateNewPassword.Constants.Texts.changePasswordButton, for: .normal)
        view.addTarget(self, action: #selector(didTapChangePassword), for: .touchUpInside)
        return view
    }()
    
    private lazy var mainView: CreateNewPasswordView = {
        let view = CreateNewPasswordView(frame: .zero,
                                         loadingView: loadingView,
                                         closeButton: closeButton,
                                         passwordTextField: passwordTextField,
                                         confirmationTextField: confirmationTextField,
                                         changePasswordButton: changePasswordButton)
        return view
    }()
    
    private var interactor: CreateNewPasswordBusinessLogic?
    var router: CreateNewPasswordRouterProtocol?
    
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
        let presenter = CreateNewPasswordPresenter(viewController: viewController)
        let interactor = CreateNewPasswordInteractor(presenter: presenter)
        let router = CreateNewPasswordRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    @objc
    private func didTapChangePassword() {
        interactor?.submitNewPassword(CreateNewPassword.Request.Submit(password: passwordTextField.text ?? .empty, confirmation: confirmationTextField.text ?? .empty))
    }
}

extension CreateNewPasswordController {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let inputTextField = textField as? DefaultInputTextField {
            inputTextField.textFieldState = .normal
        }
        return true
    }
}

extension CreateNewPasswordController: CreateNewPasswordDisplayLogic {
    
    func displayError(_ viewModel: CreateNewPassword.Info.ViewModel.Error) {
        UIAlertController.displayAlert(in: self,
                                       title: viewModel.title,
                                       message: viewModel.message)
        mainView.handleError(viewModel)
    }
    
    func displayLoading(_ loading: Bool) {
        loadingView.isHidden = !loading
    }
    
    func displaySuccessAlert() {
        UIAlertController.displayAlert(in: self,
                                       title: CreateNewPassword.Constants.Texts.passwordSuccessfullyChangedTitle,
                                       message: CreateNewPassword.Constants.Texts.passwordSuccessfullyChangedMessage) { _ in
            self.router?.routeToSignIn()
        }
    }
}
