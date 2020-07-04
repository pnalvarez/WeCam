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

class SignInViewController: UIViewController {
    
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
    
    private lazy var mainView: SignInView = {
        return SignInView(frame: .zero,
                          emailTextField: emailTextField,
                          passwordTextField: passwordTextField,
                          enterButton: enterButton,
                          forgetButton: forgetButton,
                          signUpButton: signUpButton)
    }()
    
    private var interactor: SignInBusinessRules?
    private var router: SignInRouterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
}

extension SignInViewController {
    
    @objc
    private func forgetButtonTapped() {
        
    }
    
    @objc
    private func signUpButtonTapped() {
        
    }
    
    @objc
    private func enterButtonTapped() {
        
    }
}

extension SignInViewController {
    
    private func setup() {
//        let viewController = self
//        interactor = SignInInteractor(viewController: viewController)
    
    }
}

extension SignInViewController: SignInDisplayLogic {
    
    func didFetchForgot() {
        
    }
    
    func didFetchSignUp() {
        
    }
    
    func didFetchLoginResponse() {
        
    }
}
