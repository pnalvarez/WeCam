//
//  SelectProjectImageController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 16/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit
import Photos

protocol SelectProjectImageDisplayLogic: ViewInterface {
    func displaySelectCathegory()
    func displayErrorState()
}

class SelectProjectImageController: BaseViewController, HasTabBar, UINavigationControllerDelegate {
    
    private lazy var advanceButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapAdvance), for: .touchUpInside)
        view.setTitle(SelectProjectImage.Constants.Texts.advanceButton, for: .normal)
        view.setTitleColor(SelectProjectImage.Constants.Colors.advanceButton, for: .normal)
        view.titleLabel?.font = SelectProjectImage.Constants.Fonts.advanceButton
        return view
    }()
    
    private lazy var selectedImageButton: WCImageButton = {
        let view = WCImageButton(frame: .zero)
        view.delegate = self
        return view
    }()
    
    private lazy var mainView: SelectProjectImageView = {
        let view = SelectProjectImageView(frame: .zero,
                                          advanceButton: advanceButton,
                                          selectedImageView: selectedImageButton)
        return view
    }()
    
    private lazy var imagePicker: UIImagePickerController = {
        let view = UIImagePickerController()
        view.sourceType = .photoLibrary
        view.delegate = self
        view.allowsEditing = true
        return view
    }()
    
    private var interactor: SelectProjectImageBusinessLogic?
    private var router: SelectProjectImageRouterProtocol?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    private func setup() {
        let viewController = self
        let presenter = SelectProjectImagePresenter(viewController: viewController)
        let interactor = SelectProjectImageInteractor(presenter: presenter)
        let router = SelectProjectImageRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.dataStore = interactor
        router.viewController = viewController
    }
    
    func clearImage() {
        selectedImageButton.setupDefaultImage()
    }
    
    @objc
    private func didTapAdvance() {
        interactor?.fetchAdvance(SelectProjectImage.Request.Advance())
    }
    
    @objc private func didTapSelectImageButton() {
        PHPhotoLibrary.requestAuthorization { newStatus in
            if newStatus == .authorized {
                DispatchQueue.main.async {
                    self.present(self.imagePicker, animated: true, completion: nil)
                }
            }
        }
    }
}

extension SelectProjectImageController: WCImageButtonDelegate {
    
    func didChangeButtonImage(_ view: WCImageButton) {
        didTapSelectImageButton()
    }
}

extension SelectProjectImageController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            interactor?.didSelectImage(SelectProjectImage.Request.SelectImage(image: image))
            selectedImageButton.setImage(image, for: .normal)
            selectedImageButton.setState(.default)
        }
        self.dismiss(animated: true, completion: nil)
    }
}

extension SelectProjectImageController: SelectProjectImageDisplayLogic {
    
    func displaySelectCathegory() {
        router?.routeToCategories()
    }
    
    func displayErrorState() {
        selectedImageButton.setState(.error)
    }
}
