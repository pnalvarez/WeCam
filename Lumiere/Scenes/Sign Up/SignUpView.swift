//
//  SignUpView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 03/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class SignUpView: UIView {
    
    private unowned var imageButton: UIButton
    private unowned var nameTextField: UITextField
    private unowned var cellphoneTextField: UITextField
    private unowned var emailTextField: UITextField
    private unowned var passwordTextField: UITextField
    private unowned var confirmTextField: UITextField
    private unowned var professionalTextField: UITextField
    private unowned var collectionView: UICollectionView
    private unowned var signUpButton: UIButton
    
    private lazy var cathegoriesLbl: UILabel = { return UILabel(frame: .zero) }()
    private lazy var containerView: UIView = { return UIView(frame: .zero) }()
    private lazy var scrollView: UIScrollView = { return UIScrollView(frame: .zero) }()
    
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        return UICollectionViewFlowLayout()
    }()
    
    init(frame: CGRect,
         imageButton: UIButton,
         nameTextField: UITextField,
         cellphoneTextField: UITextField,
         emailTextField: UITextField,
         passwordTextField: UITextField,
         confirmTextField: UITextField,
         professionalTextField: UITextField,
         collectionView: UICollectionView,
         signUpButton: UIButton) {
        self.imageButton = imageButton
        self.nameTextField = nameTextField
        self.cellphoneTextField = cellphoneTextField
        self.emailTextField = emailTextField
        self.passwordTextField = passwordTextField
        self.confirmTextField = confirmTextField
        self.professionalTextField = professionalTextField
        self.collectionView = collectionView
        self.signUpButton = signUpButton
        super.init(frame: frame)
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
        scrollView.addSubview(containerView)
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
        addSubview(scrollView)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().priority(250)
        }
        imageButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(84)
        }
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(imageButton.snp.bottom).offset(62)
            make.left.right.equalToSuperview().inset(71)
            make.height.equalTo(29)
        }
        cellphoneTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(62)
            make.left.right.equalToSuperview().inset(71)
            make.height.equalTo(29)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(62)
            make.left.right.equalToSuperview().inset(71)
            make.height.equalTo(29)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(62)
            make.left.right.equalToSuperview().inset(71)
            make.height.equalTo(29)
        }
        confirmTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(62)
            make.left.right.equalToSuperview().inset(71)
            make.height.equalTo(29)
        }
        professionalTextField.snp.makeConstraints { make in
            make.top.equalTo(confirmTextField.snp.bottom).offset(62)
            make.left.right.equalToSuperview().inset(71)
            make.height.equalTo(29)
        }
        signUpButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(45)
            make.height.equalTo(30)
            make.width.equalTo(99)
            make.centerX.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make in
            make.bottom.equalTo(signUpButton.snp.top).offset(-38)
            make.height.equalTo(501)
            make.left.right.equalToSuperview()
        }
        cathegoriesLbl.snp.makeConstraints { make in
            make.bottom.equalTo(collectionView.snp.top).offset(-25)
            make.centerX.equalToSuperview()
            make.height.equalTo(19)
            make.width.equalTo(176)
        }
    }
    
    func configureViews() {
        containerView.backgroundColor = SignUp.Constants.backgroundColor
        imageButton.layer.cornerRadius = imageButton.frame.size.height / 2
        imageButton.layer.borderWidth = 1
        imageButton.layer.borderColor = SignUp.Constants.imageButtonLayerColor.cgColor
        imageButton.backgroundColor = .white
        imageButton.imageView?.contentMode = .scaleAspectFit
        
        
    }
}
