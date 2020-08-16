//
//  SignUpController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 03/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol SignUpDisplayLogic: class {
    func displayMovieStyles(_ viewModel: [MovieStyle])
    func displayInformationError(_ viewModel: SignUp.Info.ViewModel.Error)
    func displayConfirmationMatchError()
    func displayLoading(_ loading: Bool)
    func displayServerError(_ viewModel: SignUp.Info.ViewModel.Error)
    func displayDidSignUpUser()
}

class SignUpController: BaseViewController {
    
    private lazy var backButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        return view
    }()
    
    private lazy var imageButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapImageButton), for: .touchUpInside)
        return view
    }()
    
    private lazy var nameTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.delegate = self
        view.addTarget(self, action: #selector(didEndTextField(_:)), for: .primaryActionTriggered)
        return view
    }()
    
    private lazy var cellphoneTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.delegate = self
        return view
    }()
    
    private lazy var emailTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.delegate = self
        return view
    }()
    
    private lazy var passwordTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.delegate = self
        return view
    }()
    
    private lazy var confirmTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.delegate = self
        return view
    }()
    
    private lazy var professionalTextField: UITextField = {
       let view = UITextField(frame: .zero)
        view.delegate = self
        return view
    }()

    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        return view
    }()

    private lazy var signUpButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.color = ThemeColors.mainRedColor.rawValue
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        view.startAnimating()
        view.isHidden = true
        return view
    }()
    
    private lazy var mainView: SignUpView = {

        return SignUpView(frame: .zero,
                          backButton: backButton,
                          imageButton: imageButton,
                          nameTextField: nameTextField,
                          cellphoneTextField: cellphoneTextField,
                          emailTextField: emailTextField,
                          passwordTextField: passwordTextField,
                          confirmTextField: confirmTextField,
                          professionalTextField: professionalTextField,
                          signUpButton: signUpButton,
                          collectionView: collectionView,
                          activityView: activityView)
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
        setupCollectionView()
        interactor?.fetchMovieStyles()
        cellphoneTextField.delegate = self
        imagePicker.delegate = self
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
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        view.endEditing(true)
//    }
}

extension SignUpController {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")

        if (isBackSpace == -92) && (textField.text?.count)! > 0 {
            print("Backspace was pressed")
            textField.text!.removeLast()
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

extension SignUpController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieStyles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(indexPath: indexPath, type: SignUpCollectionViewCell.self)
        cell.setup(movieStyle: movieStyles[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SignUpCollectionViewCell
        let state = cell.state
        switch state {
        case .enable:
            cell.state = .disable
            break
        case .disable:
            cell.state = .enable
        }
        interactor?.didSelectCathegory(SignUp.Request.SelectedCathegory(cathegory: movieStyles[indexPath.row]))
    }
}

extension SignUpController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
                    imageButton.setImage(image, for: .normal)
                }
        self.dismiss(animated: true, completion: nil)
    }
}

extension SignUpController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.width / 4, height: 87)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 26, bottom: 0, right: 26)
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
        present(imagePicker, animated: true, completion: { })
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
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.registerCell(cellType: SignUpCollectionViewCell.self)
    }
}

extension SignUpController: SignUpDisplayLogic {
    
    func displayMovieStyles(_ viewModel: [MovieStyle]) {
        movieStyles = viewModel
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
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
        activityView.isHidden = !loading
    }
    
    func displayServerError(_ viewModel: SignUp.Info.ViewModel.Error) {
        router?.routeBack(withError: viewModel)
    }
    
    func displayDidSignUpUser() {
        router?.routeBackSuccess()
    }
}
