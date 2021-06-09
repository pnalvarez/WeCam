//
//  SignInViewController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 02/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

protocol SignInDisplayLogic: ViewInterface {
    func displaySuccessfulLogin()
    func displayServerError(_ viewModel: SignIn.ViewModel.SignInError)
    func displayEmailError(_ viewModel: SignIn.ViewModel.SignInError)
    func displaypasswordError(_ viewModel: SignIn.ViewModel.SignInError)
}

class SignInController: BaseViewController {

    private lazy var emailTextField: WCInputTextField = {
        let view = WCInputTextField(frame: .zero)
        view.delegate = self
        view.attributedPlaceholder = NSAttributedString(string: SignIn.Constants.Texts.emailTextField, attributes: [NSAttributedString.Key.foregroundColor: UIColor(rgb: 0x707070), NSAttributedString.Key.font: SignIn.Constants.Fonts.textFieldPlaceholder])
        return view
    }()
    
    private lazy var passwordTextField: WCInputTextField = {
        let view = WCInputTextField(frame: .zero)
        view.delegate = self
        view.attributedPlaceholder = NSAttributedString(string: SignIn.Constants.Texts.passwordTextField, attributes: [NSAttributedString.Key.foregroundColor: UIColor(rgb: 0x707070), NSAttributedString.Key.font: SignIn.Constants.Fonts.textFieldPlaceholder])
        view.isSecureTextEntry = true
        return view
    }()
    
    private lazy var enterButton: WCPrimaryActionButton = {
        let view = WCPrimaryActionButton(frame: .zero)
        view.text = SignIn.Constants.Texts.enterButton
        view.addTarget(self, action: #selector(enterButtonTapped), for: .touchUpInside)
        return view
    }()
    
    private lazy var forgetButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(forgetButtonTapped), for: .touchUpInside)
        view.setAttributedTitle(NSAttributedString(string: SignIn.Constants.Texts.forgetButton, attributes: [NSAttributedString.Key.foregroundColor : UIColor(rgb: 0x707070), NSAttributedString.Key.font: SignIn.Constants.Fonts.forgetButton, NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue]), for: .normal)
        return view
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
        setup()
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let textfield = textField as? WCInputTextField {
            textfield.textFieldState = .normal
            guard range.location == 0 else {
                return true
            }
            
            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string) as NSString
            return newString.rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines).location != 0
        }
        return false
    }
}

extension SignInController {
    
    @objc
    private func forgetButtonTapped() {
        router?.routeToAccountRecovery()
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
        emailTextField.textFieldState = .normal
        passwordTextField.textFieldState = .normal
    }
}

extension SignInController: SignInDisplayLogic {
    
    func displaySuccessfulLogin() {
        clearErrors()
        router?.routeToHome()
    }
    
    func displayServerError(_ viewModel: SignIn.ViewModel.SignInError) {
        UIAlertController.displayAlert(in: self, title: "Erro de Login", message: viewModel.description)
    }
    
    func displayEmailError(_ viewModel: SignIn.ViewModel.SignInError) {
        UIAlertController.displayAlert(in: self, title: "Erro ao inserir dados",
                                       message: viewModel.description)
        emailTextField.textFieldState = .error
        guard let text = passwordTextField.text, !text.isEmpty else {
            passwordTextField.textFieldState = .error
            return
        }
        passwordTextField.textFieldState = .normal
    }
    
    func displaypasswordError(_ viewModel: SignIn.ViewModel.SignInError) {
        UIAlertController.displayAlert(in: self, title: "Erro ao inserir dados", message: viewModel.description)
        passwordTextField.textFieldState = .error
        emailTextField.textFieldState = .normal
    }
}
