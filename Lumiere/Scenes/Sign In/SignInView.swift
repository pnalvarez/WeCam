//
//  SignInView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 02/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class SignInView: UIView {
    
    private unowned var loadingView: WCLoadingView
    private unowned var emailTextField: UITextField
    private unowned var passwordTextField: UITextField
    private unowned var enterButton: UIButton
    private unowned var forgetButton: UIButton
    private unowned var signUpButton: UIButton
    
    private lazy var topLogoImageView: UIImageView = {
        return UIImageView(frame: .zero)
    }()
    
    private lazy var bottomLogoImageView: UIImageView = {
        return UIImageView(frame: .zero)
    }()
    
    init(frame: CGRect,
         loadingView: WCLoadingView,
         emailTextField: UITextField,
         passwordTextField: UITextField,
         enterButton: UIButton,
         forgetButton: UIButton,
         signUpButton: UIButton) {
        self.loadingView = loadingView
        self.emailTextField = emailTextField
        self.passwordTextField = passwordTextField
        self.enterButton = enterButton
        self.forgetButton = forgetButton
        self.signUpButton = signUpButton
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
        addSubview(loadingView)
    }
    
    func setupConstraints() {
        topLogoImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(120)
            make.height.equalTo(124)
            make.centerX.equalToSuperview()
            make.width.equalTo(104)
        }
        bottomLogoImageView.snp.makeConstraints { make in
            make.top.equalTo(topLogoImageView.snp.bottom)
            make.height.equalTo(38)
            make.centerX.equalToSuperview()
            make.width.equalTo(104)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(bottomLogoImageView.snp.bottom).offset(2)
            make.height.equalTo(29)
            make.left.right.equalToSuperview().inset(40)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(5)
            make.height.equalTo(29)
            make.left.right.equalToSuperview().inset(40)
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
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureViews() {
        backgroundColor = SignIn.Constants.Colors.backgroundColor
        
        topLogoImageView.contentMode = .scaleAspectFit
        topLogoImageView.image = UIImage(named: SignIn.Constants.Images.topLogo)
        bottomLogoImageView.contentMode = .scaleAspectFit
        bottomLogoImageView.image = UIImage(named: SignIn.Constants.Images.bottomLogo)
        
        enterButton.titleLabel?.font = SignIn.Constants.Fonts.enterButton
        enterButton.backgroundColor = SignIn.Constants.Colors.enterButtonBackground
        enterButton.setTitle(SignIn.Constants.Texts.enterButton.uppercased(), for: .normal)
        enterButton.titleLabel?.textColor = SignIn.Constants.Colors.enterButtonTextColor
        enterButton.layer.cornerRadius = 4
        
        signUpButton.setAttributedTitle(NSAttributedString(string: SignIn.Constants.Texts.signUp, attributes: [NSAttributedString.Key.foregroundColor : UIColor(rgb: 0x707070), NSAttributedString.Key.font: SignIn.Constants.Fonts.forgetButton, NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue]), for: .normal)
    }
}
