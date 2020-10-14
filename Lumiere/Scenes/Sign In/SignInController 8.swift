//
//  SignInViewController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 02/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol SignInDisplayLogic: class {
    func displaySuccessfulLogin()
    func displayServerError(_ viewModel: SignIn.ViewModel.SignInError)
    func displayLoading(_ loading: Bool)
    func displayEmailError(_ viewModel: SignIn.ViewModel.SignInError)
    func displaypasswordError(_ viewModel: SignIn.ViewModel.SignInError)
}

class SignInController: BaseViewController {
    
    private lazy var loadingView: LoadingView = {
        let view = LoadingView(frame: .zero)
        view.isHidden = true
        return view
    }()
    
    private lazy var emailTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.delegate = self
        return view
    }()
    
    private lazy var passwordTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.delegate = self
        return view
    }()
    
    private lazy var enterButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(enterButtonTapped), for: .touchUpInside)
        return view
    }()
    
    private lazy var forgetButton: UIButton = {
        return UIButton(frame: .zero)
    }()
    
    private lazy var signUpButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return view
    }()

    private lazy var mainView: SignInView = {
        return SignInView(frame: .zero,
                          loadingView: loadingView,
                          emailTextField: emailTextField,
                          passwordTextField: passwordTextField,
                          enterButton: enterButton,
                          forgetButton: forgetButton,
                          signUpButton: signUpButton)
    }()
    
    private var interactor: SignInBusinessRules?
    var router: SignInRouterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        setup()
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
}

extension SignInController {
    
    @objc
    private func forgetButtonTapped() {
        
    }
    
    @objc
    private func signUpButtonTapped() {
        clearErrors()
        router?.routeToSignUp()
    }
    
    @objc
    private func enterButtonTapped() {
        let request = SignIn.Models.Request(email: emailTextField.text ?? .empty,
                                            password: passwordTextField.text ?? .empty)
        interactor?.fetchSignIn(request: request)
    }
}

extension SignInController {
    
    private func setup() {
        let viewController = self
        let interactor = SignInInteractor(viewController: viewController)
        let router = SignInRouter()
        router.dataStore = interactor
        router.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
    }
    
    private func clearErrors() {
        emailTextField.layer.borderWidth = 0
        emailTextField.layer.borderColor = UIColor.clear.cgColor
        passwordTextField.layer.borderWidth = 0
        passwordTextField.layer.borderColor = UIColor.clear.cgColor
    }
}

extension SignInController: SignInDisplayLogic {
    
    func displaySuccessfulLogin() {
        clearErrors()
        router?.routeToHome()
    }
    
    func displayLoading(_ loading: Bool) {
        loadingView.isHidden = !loading
        loadingView.animateRotate()
    }
    
    func displayServerError(_ viewModel: SignIn.ViewModel.SignInError) {
        UIAlertController.displayAlert(in: self, title: "Erro de Login", message: viewModel.description)
    }
    
    func displayEmailError(_ viewModel: SignIn.ViewModel.SignInError) {
        UIAlertController.displayAlert(in: self, title: "Erro ao inserir dados",
                                       message: viewModel.description)
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor.red.cgColor
        guard let text = passwordTextField.text, !text.isEmpty else {
            passwordTextField.layer.borderWidth = 1
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            return
        }
        passwordTextField.layer.borderWidth = 0
        passwordTextField.layer.borderColor = UIColor.clear.cgColor
    }
    
    func displaypasswordError(_ viewModel: SignIn.ViewModel.SignInError) {
        UIAlertController.displayAlert(in: self, title: "Erro ao inserir dados", message: viewModel.description)
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.red.cgColor
        emailTextField.layer.borderWidth = 0
        emailTextField.layer.borderColor = UIColor.clear.cgColor
    }
}
