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
        return UIButton(frame: .zero)
    }()
    
    private lazy var scrollView: UIScrollView = {
        return UIScrollView(frame: .zero)
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
        setup()
    }
    
    override func loadView() {
        super.loadView()
        view = scrollView
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
        interactor = SignInInteractor(viewController: viewController)
    
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
