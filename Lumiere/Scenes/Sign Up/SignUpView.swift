//
//  SignUpView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 03/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class SignUpView: UIView {
    
    private unowned var backButton: UIButton
    private unowned var imageButton: UIButton
    private unowned var nameTextField: UITextField
    private unowned var cellphoneTextField: UITextField
    private unowned var emailTextField: UITextField
    private unowned var passwordTextField: UITextField
    private unowned var confirmTextField: UITextField
    private unowned var professionalTextField: UITextField
    private unowned var signUpButton: UIButton
    private unowned var collectionView: UICollectionView
    
    private lazy var cathegoriesLbl: UILabel = { return UILabel(frame: .zero) }()
    private lazy var containerView: UIView = { return UIView(frame: .zero) }()
    private lazy var scrollView: UIScrollView = { return UIScrollView(frame: .zero) }()
    private lazy var titleHeaderIcon: UIImageView = { return UIImageView(frame: .zero) }()
    
    init(frame: CGRect,
         backButton: UIButton,
         imageButton: UIButton,
         nameTextField: UITextField,
         cellphoneTextField: UITextField,
         emailTextField: UITextField,
         passwordTextField: UITextField,
         confirmTextField: UITextField,
         professionalTextField: UITextField,
         signUpButton: UIButton,
         collectionView: UICollectionView) {
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
}

extension SignUpView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        containerView.addSubview(backButton)
        containerView.addSubview(titleHeaderIcon)
        containerView.addSubview(imageButton)
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
    }
    
    func setupConstraints() {
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
            make.bottom.equalTo(signUpButton.snp.top).offset(-891)
        }
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(imageButton.snp.bottom).offset(62)
            make.left.right.equalToSuperview().inset(71)
            make.height.equalTo(29)
        }
        cellphoneTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(17)
            make.left.right.equalToSuperview().inset(71)
            make.height.equalTo(29)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(17)
            make.left.right.equalToSuperview().inset(71)
            make.height.equalTo(29)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(17)
            make.left.right.equalToSuperview().inset(71)
            make.height.equalTo(29)
        }
        confirmTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(17)
            make.left.right.equalToSuperview().inset(71)
            make.height.equalTo(29)
        }
        professionalTextField.snp.makeConstraints { make in
            make.top.equalTo(confirmTextField.snp.bottom).offset(17)
            make.left.right.equalToSuperview().inset(71)
        }
        signUpButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.top.equalTo(collectionView.snp.bottom).offset(54)
            make.height.equalTo(30)
            make.width.equalTo(99)
            make.centerX.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(cathegoriesLbl.snp.bottom).offset(25)
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
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        scrollView.alwaysBounceVertical = false
        scrollView.backgroundColor = .white
        
        containerView.backgroundColor = SignUp.Constants.Colors.backgroundColor
        
        titleHeaderIcon.image = SignUp.Constants.Images.titleHeaderIcon
        
        backButton.setImage(SignUp.Constants.Images.backButton, for: .normal)
        
        imageButton.layoutIfNeeded()
        imageButton.layer.cornerRadius = imageButton.frame.size.height / 2
        imageButton.clipsToBounds = true
        imageButton.layer.borderWidth = 1
        imageButton.layer.borderColor = SignUp.Constants.Colors.imageButtonLayerColor.cgColor
        imageButton.backgroundColor = .white
        imageButton.imageView?.contentMode = .scaleAspectFit
        
        nameTextField.backgroundColor = SignUp.Constants.Colors.textFieldBackgroundColor
        nameTextField.attributedPlaceholder = NSAttributedString(string: SignUp.Constants.Texts.namePlaceholder,
                                                                 attributes: [NSAttributedString.Key.foregroundColor: SignUp.Constants.Colors.textFieldPlaceHolderColor, NSAttributedString.Key.font: SignUp.Constants.Fonts.placeholderFont])
        
        cellphoneTextField.backgroundColor = SignUp.Constants.Colors.textFieldBackgroundColor
        cellphoneTextField.attributedPlaceholder = NSAttributedString(string: SignUp.Constants.Texts.cellphonePlaceholder,
                                                                 attributes: [NSAttributedString.Key.foregroundColor: SignUp.Constants.Colors.textFieldPlaceHolderColor, NSAttributedString.Key.font: SignUp.Constants.Fonts.placeholderFont])
        
        emailTextField.backgroundColor = SignUp.Constants.Colors.textFieldBackgroundColor
        emailTextField.attributedPlaceholder = NSAttributedString(string: SignUp.Constants.Texts.emailPlaceholder,
                                                                  attributes: [NSAttributedString.Key.foregroundColor: SignUp.Constants.Colors.textFieldPlaceHolderColor, NSAttributedString.Key.font: SignUp.Constants.Fonts.placeholderFont])
        
        passwordTextField.backgroundColor = SignUp.Constants.Colors.textFieldBackgroundColor
        passwordTextField.attributedPlaceholder = NSAttributedString(string: SignUp.Constants.Texts.passwordPlaceholder,
                                                                     attributes: [NSAttributedString.Key.foregroundColor: SignUp.Constants.Colors.textFieldPlaceHolderColor, NSAttributedString.Key.font: SignUp.Constants.Fonts.placeholderFont])
        
        confirmTextField.backgroundColor = SignUp.Constants.Colors.textFieldBackgroundColor
        confirmTextField.attributedPlaceholder = NSAttributedString(string: SignUp.Constants.Texts.confirmationPlaceholder,
                                                                    attributes: [NSAttributedString.Key.foregroundColor: SignUp.Constants.Colors.textFieldPlaceHolderColor, NSAttributedString.Key.font: SignUp.Constants.Fonts.placeholderFont])
        
        professionalTextField.backgroundColor = SignUp.Constants.Colors.textFieldBackgroundColor
        professionalTextField.attributedPlaceholder = NSAttributedString(string: SignUp.Constants.Texts.professionalArea,
                                                                         attributes: [NSAttributedString.Key.foregroundColor: SignUp.Constants.Colors.textFieldPlaceHolderColor, NSAttributedString.Key.font: SignUp.Constants.Fonts.placeholderFont])
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
