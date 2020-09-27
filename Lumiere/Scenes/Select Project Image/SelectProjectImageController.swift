//
//  SelectProjectImageController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 16/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import Photos

protocol SelectProjectImageDisplayLogic: class {
    func displaySelectCathegory()
    func displayError(_ viewModel: String)
}

class SelectProjectImageController: BaseViewController, UINavigationControllerDelegate {
    
    private lazy var backButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setImage(SelectProjectImage.Constants.Images.backButton, for: .normal)
        view.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        return view
    }()
    
    private lazy var advanceButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapAdvance), for: .touchUpInside)
        view.setTitle(SelectProjectImage.Constants.Texts.advanceButton, for: .normal)
        view.setTitleColor(SelectProjectImage.Constants.Colors.advanceButton, for: .normal)
        view.titleLabel?.font = SelectProjectImage.Constants.Fonts.advanceButton
        return view
    }()
    
    private lazy var selectedImageButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.addTarget(self, action: #selector(didTapSelectImageButton), for: .touchUpInside)
        view.imageView?.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = SelectProjectImage.Constants.Colors.selectedImageViewLayer
        view.setImage(SelectProjectImage.Constants.Images.camera, for: .normal)
        view.layer.cornerRadius = 92
        return view
    }()
    
    private lazy var mainView: SelectProjectImageView = {
        let view = SelectProjectImageView(frame: .zero,
                                          backButton: backButton,
                                          advanceButton: advanceButton,
                                          selectedImageView: selectedImageButton)
        return view
    }()
    
    private lazy var imagePicker:UIImagePickerController = {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.tabBarController?.tabBar.isHidden = false
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
}

extension SelectProjectImageController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            interactor?.didSelectImage(SelectProjectImage.Request.SelectImage(image: image))
            selectedImageButton.layer.borderColor = SelectProjectImage.Constants.Colors.selectedImageViewLayer
            selectedImageButton.setImage(image, for: .normal)
        }
        self.dismiss(animated: true, completion: nil)
    }
}

extension SelectProjectImageController {
    
    @objc
    private func didTapBackButton() {
        //TO DO
    }
    
    @objc
    private func didTapAdvance() {
        interactor?.fetchAdvance(SelectProjectImage.Request.Advance())
    }
    
    @objc
    private func didTapSelectImageButton() {
        present(imagePicker, animated: true, completion: { })
    }
}

extension SelectProjectImageController: SelectProjectImageDisplayLogic {
    
    func displaySelectCathegory() {
        router?.routeToCategories()
        navigationController?.tabBarController?.tabBar.isHidden = true
    }
    
    func displayError(_ viewModel: String) {
        selectedImageButton.layer.borderColor = UIColor.red.cgColor
        UIAlertController.displayAlert(in: self, title: "Erro", message: viewModel)
    }
}
