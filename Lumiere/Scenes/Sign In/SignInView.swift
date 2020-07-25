//
//  SignInView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 02/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class SignInView: UIView {
    
    private unowned var emailTextField: UITextField
    private unowned var passwordTextField: UITextField
    private unowned var enterButton: UIButton
    private unowned var forgetButton: UIButton
    private unowned var signUpButton: UIButton
    private unowned var activityView: UIActivityIndicatorView
    
    private lazy var topLogoImageView: UIImageView = {
        return UIImageView(frame: .zero)
    }()
    
    private lazy var bottomLogoImageView: UIImageView = {
        return UIImageView(frame: .zero)
    }()
    
    init(frame: CGRect,
         emailTextField: UITextField,
         passwordTextField: UITextField,
         enterButton: UIButton,
         forgetButton: UIButton,
         signUpButton: UIButton,
         activityView: UIActivityIndicatorView) {
        self.emailTextField = emailTextField
        self.passwordTextField = passwordTextField
        self.enterButton = enterButton
        self.forgetButton = forgetButton
        self.signUpButton = signUpButton
        self.activityView = activityView
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SignInView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(enterButton)
        addSubview(forgetButton)
        addSubview(signUpButton)
        addSubview(topLogoImageView)
        addSubview(bottomLogoImageView)
        addSubview(activityView)
    }
    
    func setupConstraints() {
        topLogoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(77)
            make.height.equalTo(124)
            make.left.right.equalToSuperview().inset(136)
        }
        bottomLogoImageView.snp.makeConstraints { make in
            make.top.equalTo(topLogoImageView.snp.bottom)
            make.height.equalTo(38)
            make.left.right.equalToSuperview().inset(136)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(bottomLogoImageView.snp.bottom).offset(2)
            make.height.equalTo(29)
            make.left.right.equalToSuperview().inset(71)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(5)
            make.height.equalTo(29)
            make.left.right.equalToSuperview().inset(71)
        }
        forgetButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(11)
            make.height.equalTo(14)
            make.width.equalTo(114)
            make.centerX.equalToSuperview()
        }
        enterButton.snp.makeConstraints { make in
            make.top.equalTo(forgetButton.snp.bottom).offset(45)
            make.height.equalTo(40)
            make.width.equalTo(99)
            make.centerX.equalToSuperview()
        }
        signUpButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.height.equalTo(14)
            make.width.equalTo(64)
            make.centerX.equalToSuperview()
        }
        activityView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureViews() {
        backgroundColor = SignIn.Constants.Colors.backgroundColor
        
        topLogoImageView.contentMode = .scaleAspectFit
        topLogoImageView.image = UIImage(named: SignIn.Constants.Images.topLogo)
        bottomLogoImageView.contentMode = .scaleAspectFit
        bottomLogoImageView.image = UIImage(named: SignIn.Constants.Images.bottomLogo)
        
        emailTextField.placeholder = SignIn.Constants.Texts.emailTextField
        emailTextField.attributedPlaceholder = NSAttributedString(string: SignIn.Constants.Texts.emailTextField, attributes: [NSAttributedString.Key.foregroundColor: UIColor(rgb: 0x707070), NSAttributedString.Key.font: SignIn.Constants.Fonts.textFieldPlaceholder])
        emailTextField.font = SignIn.Constants.Fonts.textFieldText
        emailTextField.autocapitalizationType = .none
        emailTextField.textColor = SignIn.Constants.Colors.textFieldColor
        emailTextField.backgroundColor = SignIn.Constants.Colors.textFieldBackground
        emailTextField.autocorrectionType = .no
        
        passwordTextField.placeholder = SignIn.Constants.Texts.passwordTextField
        passwordTextField.attributedPlaceholder = NSAttributedString(string: SignIn.Constants.Texts.passwordTextField, attributes: [NSAttributedString.Key.foregroundColor: UIColor(rgb: 0x707070), NSAttributedString.Key.font: SignIn.Constants.Fonts.textFieldPlaceholder])
        passwordTextField.font = SignIn.Constants.Fonts.textFieldText
        passwordTextField.autocapitalizationType = .none
        passwordTextField.textColor = SignIn.Constants.Colors.textFieldColor
        passwordTextField.backgroundColor = SignIn.Constants.Colors.textFieldBackground
        passwordTextField.autocorrectionType = .no
        passwordTextField.isSecureTextEntry = true
        
        forgetButton.setAttributedTitle(NSAttributedString(string: SignIn.Constants.Texts.forgetButton, attributes: [NSAttributedString.Key.foregroundColor : UIColor(rgb: 0x707070), NSAttributedString.Key.font: SignIn.Constants.Fonts.forgetButton, NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue]), for: .normal)
        
        enterButton.titleLabel?.font = SignIn.Constants.Fonts.enterButton
        enterButton.backgroundColor = SignIn.Constants.Colors.enterButtonBackground
        enterButton.setTitle(SignIn.Constants.Texts.enterButton.uppercased(), for: .normal)
        enterButton.titleLabel?.textColor = SignIn.Constants.Colors.enterButtonTextColor
        enterButton.layer.cornerRadius = 4
        
        signUpButton.setAttributedTitle(NSAttributedString(string: SignIn.Constants.Texts.signUp, attributes: [NSAttributedString.Key.foregroundColor : UIColor(rgb: 0x707070), NSAttributedString.Key.font: SignIn.Constants.Fonts.forgetButton, NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue]), for: .normal)
    }
}
