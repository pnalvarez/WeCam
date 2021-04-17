//
//  EditProfileDetailsController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 23/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit
import Photos

protocol EditProfileDetailsDisplayLogic: class {
    func displayUserData(_ viewModel: EditProfileDetails.Info.ViewModel.User,
                         cathegories: EditProfileDetails.Info.ViewModel.Cathegories)
    func displayProfileDetails()
    func displayLoading(_ loading: Bool)
    func displayError(_ viewModel: String)
    func displayInterestCathegories(_ viewModel: EditProfileDetails.Info.ViewModel.Cathegories)
}

class EditProfileDetailsController: BaseViewController {
    
    private lazy var activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.startAnimating()
        view.color = .black
        view.backgroundColor = .white
        view.isHidden = true
        return view
    }()
    
    private lazy var loadingView: WCLoadingView = {
        let view = WCLoadingView(frame: .zero)
        view.animateRotate()
        view.isHidden = true
        return view
    }()
    
    private lazy var cancelButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        view.setTitle(EditProfileDetails.Constants.Texts.cancelButton, for: .normal)
        view.setTitleColor(EditProfileDetails.Constants.Colors.cancelButton, for: .normal)
        view.titleLabel?.font = EditProfileDetails.Constants.Fonts.cancelButton
        return view
    }()
    
    private lazy var finishButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapFinish), for: .touchUpInside)
        view.setTitle(EditProfileDetails.Constants.Texts.finishButton, for: .normal)
        view.setTitleColor(EditProfileDetails.Constants.Colors.finishButton, for: .normal)
        view.titleLabel?.font = EditProfileDetails.Constants.Fonts.finishButton
        return view
    }()
    
    private lazy var imageButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapImageButton), for: .touchUpInside)
        view.layer.borderWidth = 1
        view.layer.borderColor = EditProfileDetails.Constants.Colors.imageButtonLayer
        view.layer.cornerRadius = 41
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var nameTextField: WCInputTextField = {
        let view = WCInputTextField(frame: .zero)
        view.delegate = self
        view.attributedPlaceholder = NSAttributedString(string: EditProfileDetails.Constants.Texts.nameTextFieldPlaceHolder,
                                                        attributes: [NSAttributedString.Key.foregroundColor: EditProfileDetails.Constants.Colors.textFieldPlaceholder,
                                                                     NSAttributedString.Key.font: EditProfileDetails.Constants.Fonts.placeHolderFont])
        return view
    }()
    
    private lazy var cellphoneTextField: WCInputTextField = {
        let view = WCInputTextField(frame: .zero)
        view.delegate = self
        view.attributedPlaceholder = NSAttributedString(string: EditProfileDetails.Constants.Texts.cellPhoneTextFieldPlaceHolder,
                                                        attributes: [NSAttributedString.Key.foregroundColor: EditProfileDetails.Constants.Colors.textFieldPlaceholder,
                                                                     NSAttributedString.Key.font: EditProfileDetails.Constants.Fonts.placeHolderFont])
        return view
    }()
    
    private lazy var ocupationTextField: WCInputTextField = {
        let view = WCInputTextField(frame: .zero)
        view.delegate = self
        view.attributedPlaceholder = NSAttributedString(string: EditProfileDetails.Constants.Texts.ocupationTextFieldPlaceHolder,
                                                        attributes: [NSAttributedString.Key.foregroundColor: EditProfileDetails.Constants.Colors.textFieldPlaceholder,
                                                                     NSAttributedString.Key.font: EditProfileDetails.Constants.Fonts.placeHolderFont])
        return view
    }()
    
    private lazy var cathegoryListView: WCCathegoryListView = {
        let view = WCCathegoryListView(frame: .zero)
        view.delegate = self
        return view
    }()
    
    private lazy var mainView: EditProfileDetailsView = {
        let view = EditProfileDetailsView(frame: .zero,
                                          activityView: activityView,
                                          loadingView: loadingView,
                                          cancelButton: cancelButton,
                                          finishButton: finishButton,
                                          imageButton: imageButton,
                                          nameTextField: nameTextField,
                                          cellphoneTextField: cellphoneTextField,
                                          ocupationTextField: ocupationTextField,
                                          cathegoryListView: cathegoryListView)
        return view
    }()
    
    private lazy var imagePicker: UIImagePickerController = {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        return controller
    }()
    
    private var indicatedActivityView: UIView?
    
    private var cathegories: EditProfileDetails.Info.ViewModel.Cathegories? {
        didSet {
            cathegoryListView.setup(cathegories: cathegories?.cathegories.cathegories.map({ $0.style.rawValue }) ?? .empty)
        }
    }
    
    private var interactor: EditProfileDetailsBusinessLogic?
    var router: EditProfileDetailsRouterProtocol?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicatedActivityView = activityView
        interactor?.fetchUserData(EditProfileDetails.Request.UserData())
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    private func setup() {
        let viewController = self
        let presenter = EditProfileDetailsPresenter(viewController: viewController)
        let interactor = EditProfileDetailsInteractor(presenter: presenter)
        let router = EditProfileDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.dataStore = interactor
        router.viewController = viewController
    }
}

extension EditProfileDetailsController {
    
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

extension EditProfileDetailsController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            imageButton.setImage(image, for: .normal)
        }
        self.dismiss(animated: true, completion: nil)
    }
}

extension EditProfileDetailsController {
    
    @objc
    private func didTapCancel() {
        router?.routeBack()
    }
    
    @objc
    private func didTapFinish() {
        let request = EditProfileDetails.Request.Finish(image: imageButton.imageView?.image?.jpegData(compressionQuality: 0.5),
                                                        name: nameTextField.text ?? .empty,
                                                        cellphone: cellphoneTextField.text ?? .empty,
                                                        ocupation: ocupationTextField.text ?? .empty)
        interactor?.fetchFinish(request)
    }
    
    @objc
    private func didTapImageButton() {
        imagePicker.allowsEditing = true
        PHPhotoLibrary.requestAuthorization { newStatus in
            if newStatus == .authorized {
                DispatchQueue.main.async {
                    self.present(self.imagePicker, animated: true, completion: nil)
                }
            }
        }
    }
}

extension EditProfileDetailsController: WCCathegoryListViewDelegate {
    
    func didSelectCathegory(atIndex index: Int) {
        let request = EditProfileDetails.Request.SelectCathegory(index: index)
        interactor?.didSelectCathegory(request)
    }
}

extension EditProfileDetailsController: EditProfileDetailsDisplayLogic {
    
    func displayUserData(_ viewModel: EditProfileDetails.Info.ViewModel.User,
                         cathegories: EditProfileDetails.Info.ViewModel.Cathegories) {
        self.cathegories = cathegories
        indicatedActivityView = loadingView
        mainView.setup(viewModel: viewModel)
    }
    
    func displayProfileDetails() {
        router?.routeBackSuccess()
    }
    
    func displayLoading(_ loading: Bool) {
        indicatedActivityView?.isHidden = !loading
    }
    
    func displayError(_ viewModel: String) {
        UIAlertController.displayAlert(in: self, title: "Erro", message: viewModel)
        mainView.updateAllTextFields()
    }
    
    func displayInterestCathegories(_ viewModel: EditProfileDetails.Info.ViewModel.Cathegories) {
        self.cathegories = viewModel
    }
}
