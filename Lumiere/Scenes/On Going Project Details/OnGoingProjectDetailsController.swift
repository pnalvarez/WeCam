//
//  OnGoingProjectDetailsController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 22/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol OnGoingProjectDetailsDisplayLogic: class {
    
}

class OnGoingProjectDetailsController: BaseViewController {
    
    private lazy var closeButton: DefaultCloseButton = {
        let view = DefaultCloseButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        return view
    }()
    
    private lazy var teamCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.assignProtocols(to: self)
        view.backgroundColor = .white
        view.bounces = false
        view.alwaysBounceVertical = false
        view.alwaysBounceHorizontal = false
        return view
    }()
    
    private lazy var moreInfoButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapMoreInfo), for: .touchUpInside)
        view.setAttributedTitle(NSAttributedString(string: OnGoingProjectDetails.Constants.Texts.moreInfoButton,
                                                   attributes: [NSAttributedString.Key.foregroundColor: OnGoingProjectDetails.Constants.Colors.moreInfoButtonText, NSAttributedString.Key.font: OnGoingProjectDetails.Constants.Fonts.moreInfoButton, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]), for: .normal)
        return view
    }()
    
    private lazy var imageButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapImageButton), for: .touchUpInside)
        view.layer.cornerRadius = 41
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    private lazy var mainView: OnGoingProjectDetailsView = {
        let view = OnGoingProjectDetailsView(frame: .zero,
                                             closeButton: closeButton,
                                             teamCollectionView: teamCollectionView,
                                             moreInfoButton: moreInfoButton,
                                             imageButton: imageButton)
        return view
    }()
    
    private let imagePicker = UIImagePickerController()
    
    private var viewModel: OnGoingProjectDetails.Info.ViewModel.Project?
    
    private var interactor: OnGoingProjectDetailsBusinessLogic?
    var router: OnGoingProjectDetailsRouterProtocol?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    private func setup() {
        let viewController = self
        let interactor = OnGoingProjectDetailsInteractor(viewController: viewController)
        let router = OnGoingProjectDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.dataStore = interactor
        router.viewController = viewController
    }
}

extension OnGoingProjectDetailsController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.teamMembers.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

extension OnGoingProjectDetailsController: UICollectionViewDelegate {
    
}

extension OnGoingProjectDetailsController: UICollectionViewDelegateFlowLayout {
    
}

extension OnGoingProjectDetailsController: UIImagePickerControllerDelegate {
    
}

extension OnGoingProjectDetailsController {
    
    @objc
    private func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func didTapMoreInfo() {
        
    }
    
    @objc
    private func didTapImageButton() {
        
    }
}

extension OnGoingProjectDetailsController: OnGoingProjectDetailsDisplayLogic {
    
}
