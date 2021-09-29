//
//  SignInView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 02/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

class SignInView: BaseView {
    
    private unowned var emailTextField: WCInputTextField
    private unowned var passwordTextField: WCInputTextField
    private unowned var enterButton: WCPrimaryActionButton
    private unowned var forgetButton: WCTertiaryButton
    private unowned var signUpButton: WCTertiaryButton
    
    private lazy var textFieldStackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.spacing = WCDimens.Margins.smallest
        view.axis = .vertical
        return view
    }()
    
    private let topLogoImageView: UIImageView = UIImageView(frame: .zero)
    private let bottomLogoImageView: UIImageView = UIImageView(frame: .zero)
    
    init(frame: CGRect,
         emailTextField: WCInputTextField,
         passwordTextField: WCInputTextField,
         enterButton: WCPrimaryActionButton,
         forgetButton: WCTertiaryButton,
         signUpButton: WCTertiaryButton) {
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
        textFieldStackView.addArrangedSubviews(emailTextField, passwordTextField)
        addSubview(textFieldStackView)
        addSubview(enterButton)
        addSubview(forgetButton)
        addSubview(signUpButton)
        addSubview(topLogoImageView)
        addSubview(bottomLogoImageView)
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
        textFieldStackView.snp.makeConstraints { make in
            make.top.equalTo(bottomLogoImageView.snp.bottom).offset(WCDimens.Margins.small)
            make.left.right.equalToSuperview().inset(WCDimens.Margins.larger)
        }
        forgetButton.snp.makeConstraints { make in
            make.top.equalTo(textFieldStackView.snp.bottom).offset(WCDimens.Margins.small)
            make.left.right.equalToSuperview().inset(WCDimens.Margins.larger)
        }
        enterButton.snp.makeConstraints { make in
            make.top.equalTo(forgetButton.snp.bottom).offset(WCDimens.Margins.default)
            make.left.right.equalToSuperview().inset(WCDimens.Margins.larger)
        }
        signUpButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.left.right.equalToSuperview().inset(WCDimens.Margins.larger)
        }
    }
    
    func configureViews() {
        backgroundColor = SignIn.Constants.Colors.backgroundColor
        topLogoImageView.contentMode = .scaleAspectFit
        topLogoImageView.image = UIImage(named: SignIn.Constants.Images.topLogo)
        bottomLogoImageView.contentMode = .scaleAspectFit
        bottomLogoImageView.image = UIImage(named: SignIn.Constants.Images.bottomLogo)
    }
}
