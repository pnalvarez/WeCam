//
//  SignInViewController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 02/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol SignInDisplayLogic: class {
    func didFetchLoginResponse()
    func didFetchForgot()
    func didFetchSignUp()
}

class SignInController: BaseViewController {
    
    private lazy var emailTextField: UITextField = {
        return UITextField(frame: .zero)
    }()
    
    private lazy var passwordTextField: UITextField = {
        return UITextField(frame: .zero)
    }()
    
    private lazy var enterButton: UIButton = {
        return UIButton(frame: .zero)
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
    
    func didFetchForgot() {
        
    }
    
    func didFetchSignUp() {
        
    }
    
    func didFetchLoginResponse() {
        
    }
}
