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
        view.imageView?.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = SelectProjectImage.Constants.Colors.selectedImageViewLayer
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
    
    private func setup() {
        let viewController = self
        let interactor = SelectProjectImageInteractor(viewController: viewController)
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
                    selectedImageButton.setImage(image, for: .normal)
                }
        self.dismiss(animated: true, completion: nil)
    }
}

extension SelectProjectImageController {
    
    @objc
    private func didTapBackButton() {
        
    }
    
    @objc
    private func didTapAdvance() {
        
    }

    @objc
    private func didTapSelectImageButton() {
        present(imagePicker, animated: true, completion: { })
    }
}

extension SelectProjectImageController: SelectProjectImageDisplayLogic {
    func displaySelectCathegory() {
        
    }
}
