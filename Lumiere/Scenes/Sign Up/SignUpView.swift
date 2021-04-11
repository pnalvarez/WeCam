//
//  SignUpView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 03/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

class SignUpView: UIView {
    
    private unowned var loadingView: WCLoadingView
    private unowned var backButton: UIButton
    private unowned var imageButton: UIButton
    private unowned var nameTextField: WCInputTextField
    private unowned var cellphoneTextField: WCInputTextField
    private unowned var emailTextField: WCInputTextField
    private unowned var passwordTextField: WCInputTextField
    private unowned var confirmTextField: WCInputTextField
    private unowned var professionalTextField: WCInputTextField
    private unowned var signUpButton: UIButton
    private unowned var collectionView: UICollectionView
    
    private lazy var cathegoriesLbl: UILabel = { return UILabel(frame: .zero) }()
    
    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = SignUp.Constants.Colors.backgroundColor
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.showsVerticalScrollIndicator = true
        view.bounces = false
        view.alwaysBounceVertical = false
        view.backgroundColor = .white
        view.contentSize = CGSize(width: frame.width, height: 1200)
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
    
    private lazy var titleHeaderIcon: UIImageView = { return UIImageView(frame: .zero) }()
    
    init(frame: CGRect,
         loadingView: WCLoadingView,
         backButton: UIButton,
         imageButton: UIButton,
         nameTextField: WCInputTextField,
         cellphoneTextField: WCInputTextField,
         emailTextField: WCInputTextField,
         passwordTextField: WCInputTextField,
         confirmTextField: WCInputTextField,
         professionalTextField: WCInputTextField,
         signUpButton: UIButton,
         collectionView: UICollectionView) {
        self.loadingView = loadingView
        self.backButton = backButton
        self.imageButton = imageButton
        self.nameTextField = nameTextField
        self.cellphoneTextField = cellphoneTextField
        self.emailTextField = emailTextField
        self.passwordTextField = passwordTextField
        self.confirmTextField = confirmTextField
        self.professionalTextField = professionalTextField
        self.signUpButton = signUpButton
        self.collectionView = collectionView
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SignUpView {
    
    func updateAllTextFields() {
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
    }
    
    func displayUnmatchedFields() {
        for view in allSubviews {
            if let textField = view as? WCInputTextField {
                textField.textFieldState = .normal
            }
        }
        passwordTextField.textFieldState = .error
        confirmTextField.textFieldState = .error
    }
}

extension SignUpView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        containerView.addSubview(backButton)
        containerView.addSubview(titleHeaderIcon)
        containerView.addSubview(imageButton)
        containerView.addSubview(chooseImageLbl)
        containerView.addSubview(nameTextField)
        containerView.addSubview(cellphoneTextField)
        containerView.addSubview(emailTextField)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(confirmTextField)
        containerView.addSubview(professionalTextField)
        containerView.addSubview(cathegoriesLbl)
        containerView.addSubview(collectionView)
        containerView.addSubview(signUpButton)
        scrollView.addSubview(containerView)
        addSubview(scrollView)
        addSubview(loadingView)
    }
    
    func setupConstraints() {
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().priority(250)
        }
        titleHeaderIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.centerX.equalToSuperview()
            make.height.equalTo(52)
            make.width.equalTo(144)
        }
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.left.equalToSuperview().inset(28)
            make.height.equalTo(28)
            make.width.equalTo(32)
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
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(imageButton.snp.bottom).offset(62)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(29)
        }
        cellphoneTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(17)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(29)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(cellphoneTextField.snp.bottom).offset(17)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(29)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(17)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(29)
        }
        confirmTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(17)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(29)
        }
        professionalTextField.snp.makeConstraints { make in
            make.top.equalTo(confirmTextField.snp.bottom).offset(17)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(29)
        }
        signUpButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.top.equalTo(titleHeaderIcon.snp.bottom).offset(1020)
            make.height.equalTo(30)
            make.width.equalTo(99)
            make.centerX.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(cathegoriesLbl.snp.bottom).offset(36)
            make.height.equalTo(501)
            make.left.right.equalToSuperview()
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
        
        backButton.setImage(SignUp.Constants.Images.backButton, for: .normal)
        
        imageButton.layoutIfNeeded()
        imageButton.layer.cornerRadius = imageButton.frame.size.height / 2
        imageButton.clipsToBounds = true
        imageButton.layer.borderWidth = 1
        imageButton.layer.borderColor = SignUp.Constants.Colors.imageButtonLayerColor.cgColor
        imageButton.backgroundColor = .white
        imageButton.imageView?.contentMode = .scaleAspectFill
        
        
        cathegoriesLbl.attributedText = NSAttributedString(string: SignUp.Constants.Texts.cathegories,
                                                           attributes: [NSAttributedString.Key.font: SignUp.Constants.Fonts.cathegoriesLblFont, NSAttributedString.Key.foregroundColor: SignUp.Constants.Colors.cathegoriesLblColor, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        signUpButton.layer.cornerRadius = 4
        signUpButton.backgroundColor = SignUp.Constants.Colors.signUpButtonBackgroundColor
        signUpButton.setAttributedTitle(NSAttributedString(string: SignUp.Constants.Texts.signUpButton,
                                                           attributes: [NSAttributedString.Key.font: SignUp.Constants.Fonts.signUpButtonFont, NSAttributedString.Key.foregroundColor: SignUp.Constants.Colors.signUpButtonTextColor]),
                                                            for: .normal)
        
        collectionView.bounces = false
        collectionView.alwaysBounceVertical = false
        collectionView.alwaysBounceHorizontal = false
    }
}
