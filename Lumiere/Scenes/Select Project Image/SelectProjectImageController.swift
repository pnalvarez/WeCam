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
    func displayImages(_ viewModel: SelectProjectImage.Info.ViewModel.AlbumImages)
    func displaySelectedImage(_ viewModel: SelectProjectImage.Info.ViewModel.SelectedImage)
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
    
    private lazy var selectedImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = SelectProjectImage.Constants.Colors.selectedImageViewLayer
        view.layer.cornerRadius = 42
        return view
    }()

    private lazy var imagesCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.assignProtocols(to: self)
        view.bounces = false
        view.alwaysBounceVertical = false
        view.alwaysBounceHorizontal = false
        view.registerCell(cellType: SelectProjectImageCollectionViewCell.self)
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var mainView: SelectProjectImageView = {
        let view = SelectProjectImageView(frame: .zero,
                                          backButton: backButton,
                                          advanceButton: advanceButton,
                                          imagesCollectionView: imagesCollectionView,
                                          selectedImageView: selectedImageView)
        return view
    }()
    
    private var viewModel: SelectProjectImage.Info.ViewModel.AlbumImages? {
        didSet {
            imagesCollectionView.reloadData()
        }
    }
    
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
        interactor?.fetchDeviceImages(SelectProjectImage.Request.AlbumImages())
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

extension SelectProjectImageController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let image = viewModel?.images[indexPath.row] else { return }
        let request = SelectProjectImage.Request.SelectImage(image: image)
        interactor?.didSelectImage(request)
    }
    
}

extension SelectProjectImageController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imagesCollectionView.dequeueReusableCell(indexPath: indexPath,
                                                            type: SelectProjectImageCollectionViewCell.self)
        guard let viewModel = self.viewModel else { return UICollectionViewCell( )}
        cell.setup(viewModel: viewModel.images[indexPath.row])
        return cell
    }
}

extension SelectProjectImageController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 3, height: 144)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension SelectProjectImageController {
    
    @objc
    private func didTapBackButton() {
        
    }
    
    @objc
    private func didTapAdvance() {
        
    }
    
    private func clearSelectedImages() {
        //TO DO
    }
}

extension SelectProjectImageController: SelectProjectImageDisplayLogic {
    
    func displayImages(_ viewModel: SelectProjectImage.Info.ViewModel.AlbumImages) {
        self.viewModel = viewModel
    }
    
    func displaySelectedImage(_ viewModel: SelectProjectImage.Info.ViewModel.SelectedImage) {
        selectedImageView.image = viewModel.image
    }
}
