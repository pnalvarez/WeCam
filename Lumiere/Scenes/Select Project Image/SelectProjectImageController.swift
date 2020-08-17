//
//  SelectProjectImageController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 16/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol SelectProjectImageDisplayLogic: class {
    
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

    private lazy var imagesCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero)
        view.assignProtocols(to: self)
        view.bounces = false
        view.alwaysBounceVertical = false
        view.alwaysBounceHorizontal = false
        view.registerCell(cellType: SelectProjectImageCollectionViewCell.self)
        return view
    }()
    
    private lazy var mainView: SelectProjectImageView = {
        let view = SelectProjectImageView(frame: .zero,
                                          backButton: backButton,
                                          advanceButton: advanceButton,
                                          imagesCollectionView: imagesCollectionView,
                                          imagePickerView: imagePicker.view)
        return view
    }()
    
    private lazy var imagePicker: UIImagePickerController = {
        let controller = UIImagePickerController()
        controller.delegate = self
        return controller
    }()
    
    private var viewModel: SelectProjectImage.Info.ViewModel.AlbumImages?
    
    private var interactor: SelectProjectImageBusinessLogic?
    private var router: SelectProjectImageRouterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
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
    
}

extension SelectProjectImageController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension SelectProjectImageController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

extension SelectProjectImageController: UICollectionViewDelegateFlowLayout {
    
}

extension SelectProjectImageController {
    
    @objc
    private func didTapBackButton() {
        
    }
    
    @objc
    private func didTapAdvance() {
        
    }
}

extension SelectProjectImageController: SelectProjectImageDisplayLogic {
    
}
