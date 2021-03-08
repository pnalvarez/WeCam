//
//  CreateNewPasswordView.swift
//  WeCam
//
//  Created by Pedro Alvarez on 07/03/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit

class CreateNewPasswordView: UIView {
    
    private lazy var textFieldStackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .center
        view.spacing = 17
        return view
    }()
    
    private lazy var messageLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .left
        view.text = CreateNewPassword.Constants.Texts.messageLbl
        view.textColor = CreateNewPassword.Constants.Colors.messageLbl
        view.font = CreateNewPassword.Constants.Fonts.messageLbl
        view.numberOfLines = 1
        return view
    }()
    
    private unowned var loadingView: LoadingView
    private unowned var closeButton: DefaultCloseButton
    private unowned var passwordTextField: DefaultInputTextField
    private unowned var confirmationTextField: DefaultInputTextField
    private unowned var changePasswordButton: DefaultActionButton
    
    init(frame: CGRect,
         loadingView: LoadingView,
         closeButton: DefaultCloseButton,
         passwordTextField: DefaultInputTextField,
         confirmationTextField: DefaultInputTextField,
         changePasswordButton: DefaultActionButton) {
        self.loadingView = loadingView
        self.closeButton = closeButton
        self.passwordTextField = passwordTextField
        self.confirmationTextField = confirmationTextField
        self.changePasswordButton = changePasswordButton
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func handleError(_ error: CreateNewPassword.Info.ViewModel.Error) {
        switch error.type {
        case .passwordFormat:
            passwordTextField.textFieldState = .error
        case .passwordMatch:
            passwordTextField.textFieldState = .error
            confirmationTextField.textFieldState = .error
        case .server:
            break
        }
    }
}

extension CreateNewPasswordView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(closeButton)
        addSubview(messageLbl)
        textFieldStackView.addArrangedSubview(passwordTextField)
        textFieldStackView.addArrangedSubview(confirmationTextField)
        addSubview(textFieldStackView)
        addSubview(changePasswordButton)
        addSubview(loadingView)
    }
    
    func setupConstraints() {
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(32)
            make.right.equalToSuperview().inset(56)
            make.height.width.equalTo(31)
        }
        messageLbl.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(11)
            make.left.right.equalToSuperview().inset(24)
        }
        textFieldStackView.snp.makeConstraints { make in
            make.top.equalTo(messageLbl.snp.bottom).offset(32)
            make.left.right.equalToSuperview().inset(24)
        }
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(29)
            make.right.left.equalToSuperview()
        }
        confirmationTextField.snp.makeConstraints { make in
            make.height.equalTo(29)
            make.right.left.equalToSuperview()
        }
        changePasswordButton.snp.makeConstraints { make in
            make.top.equalTo(textFieldStackView.snp.bottom).offset(64)
            make.left.right.equalToSuperview().inset(110)
            make.height.equalTo(30)
        }
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
