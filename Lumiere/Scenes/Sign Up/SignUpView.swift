//
//  SignUpView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 03/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

class SignUpView: BaseView {

    private unowned var imageButton: UIButton
    private unowned var nameTextField: WCInputTextField
    private unowned var cellphoneTextField: WCInputTextField
    private unowned var emailTextField: WCInputTextField
    private unowned var passwordTextField: WCInputTextField
    private unowned var confirmTextField: WCInputTextField
    private unowned var professionalTextField: WCInputTextField
    private unowned var signUpButton: WCPrimaryActionButton
    private unowned var cathegoryListView: WCCathegoryListView
    
    private lazy var cathegoriesLbl: WCUILabelRobotoBold16GrayUnderlinded = {
        let view = WCUILabelRobotoBold16GrayUnderlinded(frame: .zero)
        view.textAlignment = .center
        return view
    }()
    
    private lazy var scrollView: WCUIScrollView = {
        let view = WCUIScrollView(frame: .zero)
        view.colorStyle = .white
        return view
    }()
    
    private lazy var chooseImageLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textColor = SignUp.Constants.Colors.chooseImageLbl
        view.text = SignUp.Constants.Texts.chooseImageLbl
        view.font = SignUp.Constants.Fonts.chooseImageLbl
        view.textAlignment = .center
        return view
    }()
    
    private lazy var inputStackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .vertical
        view.spacing = WCDimens.Margins.medium
        return view
    }()
    
    private lazy var titleHeaderIcon: UIImageView = { return UIImageView(frame: .zero) }()
    
    init(frame: CGRect,
         imageButton: UIButton,
         nameTextField: WCInputTextField,
         cellphoneTextField: WCInputTextField,
         emailTextField: WCInputTextField,
         passwordTextField: WCInputTextField,
         confirmTextField: WCInputTextField,
         professionalTextField: WCInputTextField,
         signUpButton: WCPrimaryActionButton,
         cathegoryListView: WCCathegoryListView) {
        self.imageButton = imageButton
        self.nameTextField = nameTextField
        self.cellphoneTextField = cellphoneTextField
        self.emailTextField = emailTextField
        self.passwordTextField = passwordTextField
        self.confirmTextField = confirmTextField
        self.professionalTextField = professionalTextField
        self.signUpButton = signUpButton
        self.cathegoryListView = cathegoryListView
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateInputComponents() {
        for view in allSubviews {
            if let textField = view as? WCInputTextField {
                if let isEmpty = textField.text?.isEmpty {
                    if isEmpty {
                        textField.textFieldState = .error
                    } else {
                        textField.textFieldState = .normal
                    }
                }
            }
        }
        checkUnmatchedPasswordFields()
    }
    
    private func checkUnmatchedPasswordFields() {
        if passwordTextField.text != confirmTextField.text {
            passwordTextField.textFieldState = .error
            confirmTextField.textFieldState = .error
        }
    }
}

extension SignUpView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        scrollView.addSubview(titleHeaderIcon)
        scrollView.addSubview(imageButton)
        scrollView.addSubview(chooseImageLbl)
        inputStackView.addArrangedSubview(nameTextField)
        inputStackView.addArrangedSubview(cellphoneTextField)
        inputStackView.addArrangedSubview(emailTextField)
        inputStackView.addArrangedSubview(passwordTextField)
        inputStackView.addArrangedSubview(confirmTextField)
        inputStackView.addArrangedSubview(professionalTextField)
        inputStackView.addArrangedSubview(cathegoriesLbl)
        inputStackView.addArrangedSubview(cathegoryListView)
        scrollView.addSubview(signUpButton)
        scrollView.addSubview(inputStackView)
        addSubview(scrollView)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        titleHeaderIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.centerX.equalToSuperview()
            make.height.equalTo(52)
            make.width.equalTo(144)
        }
        imageButton.snp.makeConstraints { make in
            make.top.equalTo(titleHeaderIcon.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(84)
        }
        chooseImageLbl.snp.makeConstraints { make in
            make.top.equalTo(imageButton.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
        }
        inputStackView.snp.makeConstraints { make in
            make.top.equalTo(chooseImageLbl.snp.bottom).offset(62)
            make.left.right.equalToSuperview().inset(36)
        }
//        nameTextField.snp.makeConstraints { make in
//            make.top.equalTo(imageButton.snp.bottom).offset(62)
//            make.left.right.equalToSuperview().inset(40)
//            make.height.equalTo(29)
//        }
//        cellphoneTextField.snp.makeConstraints { make in
//            make.top.equalTo(nameTextField.snp.bottom).offset(17)
//            make.left.right.equalToSuperview().inset(40)
//            make.height.equalTo(29)
//        }
//        emailTextField.snp.makeConstraints { make in
//            make.top.equalTo(cellphoneTextField.snp.bottom).offset(17)
//            make.left.right.equalToSuperview().inset(40)
//            make.height.equalTo(29)
//        }
//        passwordTextField.snp.makeConstraints { make in
//            make.top.equalTo(emailTextField.snp.bottom).offset(17)
//            make.left.right.equalToSuperview().inset(40)
//            make.height.equalTo(29)
//        }
//        confirmTextField.snp.makeConstraints { make in
//            make.top.equalTo(passwordTextField.snp.bottom).offset(17)
//            make.left.right.equalToSuperview().inset(40)
//            make.height.equalTo(29)
//        }
//        professionalTextField.snp.makeConstraints { make in
//            make.top.equalTo(confirmTextField.snp.bottom).offset(17)
//            make.left.right.equalToSuperview().inset(40)
//            make.height.equalTo(29)
//        }
        signUpButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.top.equalTo(cathegoryListView.snp.bottom).offset(48)
            make.width.equalTo(99)
            make.centerX.equalToSuperview()
        }
        cathegoryListView.snp.makeConstraints { make in
//            make.top.equalTo(cathegoriesLbl.snp.bottom).offset(36)
            make.height.equalTo(501)
//            make.left.right.equalToSuperview()
        }
        cathegoriesLbl.snp.makeConstraints { make in
            make.top.equalTo(professionalTextField.snp.bottom).offset(22)
            make.centerX.equalToSuperview()
            make.height.equalTo(19)
            make.width.equalTo(176)
        }
    }
    
    func configureViews() {
        
        titleHeaderIcon.image = SignUp.Constants.Images.titleHeaderIcon
    }
}
