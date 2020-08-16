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
    
    private lazy var activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        view.color = ThemeColors.mainRedColor.rawValue
        view.startAnimating()
        view.isHidden = true
        return view
    }()

    private lazy var mainView: SignInView = {
        return SignInView(frame: .zero,
                          emailTextField: emailTextField,
                          passwordTextField: passwordTextField,
                          enterButton: enterButton,
                          forgetButton: forgetButton,
                          signUpButton: signUpButton,
                          activityView: activityView)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

extension SignInController {
    
    @objc
    private func forgetButtonTapped() {
        
    }
    
    @objc
    private func signUpButtonTapped() {
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
}

extension SignInController: SignInDisplayLogic {
    
    func displaySuccessfulLogin() {
        emailTextField.layer.borderWidth = 0
        emailTextField.layer.borderColor = UIColor.clear.cgColor
        passwordTextField.layer.borderWidth = 0
        passwordTextField.layer.borderColor = UIColor.clear.cgColor
        router?.routeToHome()
    }
    
    func displayLoading(_ loading: Bool) {
        activityView.isHidden = !loading
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
