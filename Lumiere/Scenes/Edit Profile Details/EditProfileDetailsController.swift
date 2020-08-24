//
//  EditProfileDetailsController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 23/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol EditProfileDetailsDisplayLogic: class {
    func displayUserData(_ viewModel: EditProfileDetails.Info.ViewModel.User,
                         cathegories: EditProfileDetails.Info.ViewModel.Cathegories)
    func displayProfileDetails()
    func displayLoading(_ loading: Bool)
    func displayError(_ viewModel: String)
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
    
    private lazy var loadingView: LoadingView = {
        let view = LoadingView(frame: .zero)
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
    
    private lazy var nameTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.delegate = self
        view.backgroundColor = EditProfileDetails.Constants.Colors.textFieldBackground
        view.textColor = EditProfileDetails.Constants.Colors.textFieldText
        view.attributedPlaceholder = NSAttributedString(string: EditProfileDetails.Constants.Texts.nameTextFieldPlaceHolder,
                                                        attributes: [NSAttributedString.Key.foregroundColor: EditProfileDetails.Constants.Colors.textFieldPlaceholder,
                                                                     NSAttributedString.Key.font: EditProfileDetails.Constants.Fonts.placeHolderFont])
        view.font = EditProfileDetails.Constants.Fonts.textFieldFont
        return view
    }()
    
    private lazy var cellphoneTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.delegate = self
        view.backgroundColor = EditProfileDetails.Constants.Colors.textFieldBackground
        view.textColor = EditProfileDetails.Constants.Colors.textFieldText
        view.attributedPlaceholder = NSAttributedString(string: EditProfileDetails.Constants.Texts.cellPhoneTextFieldPlaceHolder,
                                                        attributes: [NSAttributedString.Key.foregroundColor: EditProfileDetails.Constants.Colors.textFieldPlaceholder,
                                                                     NSAttributedString.Key.font: EditProfileDetails.Constants.Fonts.placeHolderFont])
        view.font = EditProfileDetails.Constants.Fonts.textFieldFont
        return view
    }()
    
    private lazy var ocupationTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.delegate = self
        view.backgroundColor = EditProfileDetails.Constants.Colors.textFieldBackground
        view.textColor = EditProfileDetails.Constants.Colors.textFieldText
        view.attributedPlaceholder = NSAttributedString(string: EditProfileDetails.Constants.Texts.ocupationTextFieldPlaceHolder,
                                                        attributes: [NSAttributedString.Key.foregroundColor: EditProfileDetails.Constants.Colors.textFieldPlaceholder,
                                                                     NSAttributedString.Key.font: EditProfileDetails.Constants.Fonts.placeHolderFont])
        view.font = EditProfileDetails.Constants.Fonts.textFieldFont
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.registerCell(cellType: CathegoryCollectionViewCell.self)
        view.assignProtocols(to: self)
        view.bounces = false
        view.alwaysBounceVertical = false
        view.alwaysBounceHorizontal = false
        view.backgroundColor = .white
        view.isScrollEnabled = false
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
                                          collectionView: collectionView)
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
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
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
        let interactor = EditProfileDetailsInteractor(viewController: viewController)
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

        if (isBackSpace == -92) && (textField.text?.count)! > 0 {
            print("Backspace was pressed")
            textField.text!.removeAll()
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

extension EditProfileDetailsController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let request = EditProfileDetails.Request.SelectCathegory(index: indexPath.row)
        interactor?.didSelectCathegory(request)
    }
}

extension EditProfileDetailsController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cathegories?.cathegories.cathegories.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(indexPath: indexPath, type: CathegoryCollectionViewCell.self)
        guard let movieStyle = cathegories?.cathegories.cathegories[indexPath.row].style,
            let selected = cathegories?.cathegories.cathegories[indexPath.row].selected else { return UICollectionViewCell() }
        cell.setup(movieStyle: movieStyle)
        cell.state = selected ? .enable : .disable
        return cell
    }
}

extension EditProfileDetailsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.width / 4, height: view.frame.height * 0.13)
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
        present(imagePicker, animated: true, completion: nil)
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
}
