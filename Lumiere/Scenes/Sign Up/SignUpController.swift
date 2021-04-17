//
//  SignUpController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 03/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit
import Photos

protocol SignUpDisplayLogic: class {
    func displayMovieStyles(_ viewModel: [MovieStyle])
    func displayInformationError(_ viewModel: SignUp.Info.ViewModel.Error)
    func displayConfirmationMatchError()
    func displayLoading(_ loading: Bool)
    func displayServerError(_ viewModel: SignUp.Info.ViewModel.Error)
    func displayDidSignUpUser()
}

class SignUpController: BaseViewController {
    
    private lazy var loadingView: WCLoadingView = {
        let view = WCLoadingView(frame: .zero)
        view.animateRotate()
        view.isHidden = true
        return view
    }()
    
    private lazy var imageButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapImageButton), for: .touchUpInside)
        view.setImage(SignUp.Constants.Images.camera, for: .normal)
        return view
    }()
    
    private lazy var nameTextField: WCInputTextField = {
        let view = WCInputTextField(frame: .zero)
        view.attributedPlaceholder = NSAttributedString(string: SignUp.Constants.Texts.namePlaceholder,
                                                        attributes: [NSAttributedString.Key.foregroundColor: SignUp.Constants.Colors.textFieldPlaceHolderColor, NSAttributedString.Key.font: SignUp.Constants.Fonts.placeholderFont])
        view.delegate = self
        view.addTarget(self, action: #selector(didEndTextField(_:)), for: .primaryActionTriggered)
        return view
    }()
    
    private lazy var cellphoneTextField: WCInputTextField = {
        let view = WCInputTextField(frame: .zero)
        view.attributedPlaceholder = NSAttributedString(string: SignUp.Constants.Texts.cellphonePlaceholder,
                                                        attributes: [NSAttributedString.Key.foregroundColor: SignUp.Constants.Colors.textFieldPlaceHolderColor, NSAttributedString.Key.font: SignUp.Constants.Fonts.placeholderFont])
        view.delegate = self
        view.keyboardType = .numberPad
        return view
    }()
    
    private lazy var emailTextField: WCInputTextField = {
        let view = WCInputTextField(frame: .zero)
        view.attributedPlaceholder = NSAttributedString(string: SignUp.Constants.Texts.emailPlaceholder,
                                                        attributes: [NSAttributedString.Key.foregroundColor: SignUp.Constants.Colors.textFieldPlaceHolderColor, NSAttributedString.Key.font: SignUp.Constants.Fonts.placeholderFont])
        view.delegate = self
        return view
    }()
    
    private lazy var passwordTextField: WCInputTextField = {
        let view = WCInputTextField(frame: .zero)
        view.attributedPlaceholder = NSAttributedString(string: SignUp.Constants.Texts.passwordPlaceholder,
                                                        attributes: [NSAttributedString.Key.foregroundColor: SignUp.Constants.Colors.textFieldPlaceHolderColor, NSAttributedString.Key.font: SignUp.Constants.Fonts.placeholderFont])
        view.isSecureTextEntry = true
        view.delegate = self
        return view
    }()
    
    private lazy var confirmTextField: WCInputTextField = {
        let view = WCInputTextField(frame: .zero)
        view.attributedPlaceholder = NSAttributedString(string: SignUp.Constants.Texts.confirmationPlaceholder,
                                                        attributes: [NSAttributedString.Key.foregroundColor: SignUp.Constants.Colors.textFieldPlaceHolderColor, NSAttributedString.Key.font: SignUp.Constants.Fonts.placeholderFont])
        view.isSecureTextEntry = true
        view.delegate = self
        return view
    }()
    
    private lazy var professionalTextField: WCInputTextField = {
       let view = WCInputTextField(frame: .zero)
        view.attributedPlaceholder = NSAttributedString(string: SignUp.Constants.Texts.professionalArea,
                                                        attributes: [NSAttributedString.Key.foregroundColor: SignUp.Constants.Colors.textFieldPlaceHolderColor, NSAttributedString.Key.font: SignUp.Constants.Fonts.placeholderFont])
        view.delegate = self
        return view
    }()
    
    private lazy var cathegoryListView: WCCathegoryListView = {
        let view = WCCathegoryListView(frame: .zero)
        view.delegate = self
        return view
    }()

    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero,
                                    collectionViewLayout: UICollectionViewFlowLayout.init())
        return view
    }()

    private lazy var signUpButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var mainView: SignUpView = {

        return SignUpView(frame: .zero,
                          loadingView: loadingView,
                          backButton: backButton,
                          imageButton: imageButton,
                          nameTextField: nameTextField,
                          cellphoneTextField: cellphoneTextField,
                          emailTextField: emailTextField,
                          passwordTextField: passwordTextField,
                          confirmTextField: confirmTextField,
                          professionalTextField: professionalTextField,
                          signUpButton: signUpButton,
                          cathegoryListView: cathegoryListView)
    }()
    
    private var movieStyles: [MovieStyle] = []
    
    private var interactor: SignUpBusinessLogic?
    private var router: SignUpRouterProtocol?
    
    private let imagePicker = UIImagePickerController()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        cellphoneTextField.delegate = self
        imagePicker.delegate = self
        interactor?.fetchMovieStyles()
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    private func setup() {
        let viewController = self
        let interactor = SignUpInteractor(viewController: viewController)
        let router = SignUpRouter()
        router.viewController = viewController
        viewController.router = router
        viewController.interactor = interactor
        router.dataStore = interactor
    }
}

extension SignUpController {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if let inputTextField = textField as? WCInputTextField {
            inputTextField.textFieldState = .normal
        }

        if (isBackSpace == -92) && (textField.text?.count)! > 0 {
            if textField == cellphoneTextField {
                textField.text!.removeAll()
            } else {
                textField.text?.removeLast()
            }
            return false
        }

        if textField == cellphoneTextField
        {
            if (textField.text?.count)! == 2
            {
                textField.text = "(\(textField.text!)) "  //There we are ading () and space two things
            }
            else if (textField.text?.count)! == 10
            {
                textField.text = "\(textField.text!)-" //there we are ading - in textfield
            }
            else if (textField.text?.count)! > 14
            {
                return false
            }
        }
        return true
    }
}


extension SignUpController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            imageButton.setImage(image, for: .normal)
        }
        self.dismiss(animated: true, completion: nil)
    }
}

extension SignUpController {
    
    @objc
    private func didEndTextField(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @objc
    func didTapImageButton() {
        imagePicker.allowsEditing = true
        PHPhotoLibrary.requestAuthorization { newStatus in
            if newStatus == .authorized {
                DispatchQueue.main.async {
                    self.present(self.imagePicker, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc
    private func didTapBackButton() {
        router?.routeBack()
    }
    
    @objc
    private func didTapSignUpButton() {
        let request = SignUp.Request.UserData(image: imageButton.currentImage,
                                            name: nameTextField.text ?? .empty,
                                            email: emailTextField.text ?? .empty,
                                            password: passwordTextField.text ?? .empty,
                                            confirmation: confirmTextField.text ?? .empty,
                                            phoneNumber: cellphoneTextField.text ?? .empty,
                                            professionalArea: professionalTextField.text ?? .empty)
        interactor?.fetchSignUp(request)
    }
}

extension SignUpController: WCCathegoryListViewDelegate {
    
    func didSelectCathegory(atIndex index: Int) {
        interactor?.didSelectCathegory(SignUp.Request.SelectedCathegory(index: index))
    }
}

extension SignUpController: SignUpDisplayLogic {
    
    func displayMovieStyles(_ viewModel: [MovieStyle]) {
        cathegoryListView.setup(cathegories: viewModel.map({ $0.rawValue }))
    }
    
    func displayInformationError(_ viewModel: SignUp.Info.ViewModel.Error) {
        UIAlertController.displayAlert(in: self, title: SignUp.Constants.Texts.signUpError,
                                       message: viewModel.description)
        mainView.updateAllTextFields()
    }
    
    func displayConfirmationMatchError() {
        UIAlertController.displayAlert(in: self, title: SignUp.Constants.Texts.signUpError,
                                       message: SignUp.Constants.Texts.unmatchError)
        mainView.displayUnmatchedFields()
    }
    
    func displayLoading(_ loading: Bool) {
        loadingView.isHidden = !loading
    }
    
    func displayServerError(_ viewModel: SignUp.Info.ViewModel.Error) {
        router?.routeBack(withError: viewModel)
    }
    
    func displayDidSignUpUser() {
        router?.routeBackSuccess()
    }
}
