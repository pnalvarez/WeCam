//
//  SignUpViewController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 03/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol SignUpDisplayLogic: class {
    
}

class SignUpViewController: BaseViewController {
    
    private lazy var imageButton: UIButton = {
        return UIButton(frame: .zero)
    }()
    
    private lazy var nameTextField: UITextField = {
        return UITextField(frame: .zero)
    }()
    
    private lazy var cellphoneTextField: UITextField = {
        return UITextField(frame: .zero)
    }()
    
    private lazy var emailTextField: UITextField = {
        return UITextField(frame: .zero)
    }()
    
    private lazy var passwordTextField: UITextField = {
        return UITextField(frame: .zero)
    }()
    
    private lazy var confirmTextField: UITextField = {
        return UITextField(frame: .zero)
    }()
    
    private lazy var professionalTextField: UITextField = {
        return UITextField(frame: .zero)
    }()
//
//    private lazy var collectionView: UICollectionView = {
//        return UICollectionView(
//    }()
//
    private lazy var signUpButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var mainView: SignUpView = {
        let frame = CGRect(x: 0,
                           y: 0,
                           width: view.frame.width,
                           height: SignUp.Constants.Dimensions.mainViewHeight)
        return SignUpView(frame: frame,
                          imageButton: imageButton,
                          nameTextField: nameTextField,
                          cellphoneTextField: cellphoneTextField,
                          emailTextField: emailTextField,
                          passwordTextField: passwordTextField,
                          confirmTextField: confirmTextField,
                          professionalTextField: professionalTextField,
                          signUpButton: signUpButton)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = UIImageView(image: UIImage(named: "tipografia-projeto 2"))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "voltar 1"), style: .done, target: nil, action: nil)
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
}

extension SignUpViewController {
    
    @objc
    private func didTapSignUpButton() {
        
    }
}

extension SignUpViewController: SignUpDisplayLogic {
    
}
