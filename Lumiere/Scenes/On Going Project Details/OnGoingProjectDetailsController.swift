//
//  OnGoingProjectDetailsController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 22/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol OnGoingProjectDetailsDisplayLogic: class {
    func displayProjectDetails(_ viewModel: OnGoingProjectDetails.Info.ViewModel.Project)
    func displayLoading(_ loading: Bool)
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
        view.registerCell(cellType: TeamMemberCollectionViewCell.self)
        view.backgroundColor = .white
        view.bounces = false
        view.alwaysBounceVertical = false
        view.alwaysBounceHorizontal = false
        view.isScrollEnabled = false
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
        view.imageView?.contentMode = .scaleToFill
        view.clipsToBounds = true
        view.addTarget(self, action: #selector(didTapImageButton), for: .touchUpInside)
        view.layer.cornerRadius = 41
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    private lazy var activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.color = .black
        view.backgroundColor = .white
        view.startAnimating()
        view.isHidden = true
        return view
    }()
    
    private lazy var mainView: OnGoingProjectDetailsView = {
        let view = OnGoingProjectDetailsView(frame: .zero,
                                             closeButton: closeButton,
                                             teamCollectionView: teamCollectionView,
                                             moreInfoButton: moreInfoButton,
                                             imageButton: imageButton,
                                             activityView: activityView)
        return view
    }()
    
    private let imagePicker = UIImagePickerController()
    
    private var viewModel: OnGoingProjectDetails.Info.ViewModel.Project? {
        didSet {
            DispatchQueue.main.async {
                self.teamCollectionView.reloadData()
            }
        }
    }
    
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
        navigationController?.isNavigationBarHidden = true
        interactor?.fetchProjectDetails(OnGoingProjectDetails.Request.FetchProject())
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.teamMembers.count ?? 0 >= 4 ? 4 : viewModel?.teamMembers.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = teamCollectionView.dequeueReusableCell(indexPath: indexPath, type: TeamMemberCollectionViewCell.self)
        guard let viewModel = viewModel?.teamMembers else { return UICollectionViewCell() }
        cell.setup(viewModel: TeamMemberViewModel(name: viewModel[indexPath.row].name,
                                                  jobDescription: viewModel[indexPath.row].ocupation,
                                                  image: viewModel[indexPath.row].image))
        return cell
    }
}

extension OnGoingProjectDetailsController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension OnGoingProjectDetailsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 125, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension OnGoingProjectDetailsController: UIImagePickerControllerDelegate {
    
}

extension OnGoingProjectDetailsController {
    
    @objc
    private func didTapClose() {
        router?.routeToEndOfFlow()
    }
    
    @objc
    private func didTapMoreInfo() {
        
    }
    
    @objc
    private func didTapImageButton() {
        
    }
}

extension OnGoingProjectDetailsController: OnGoingProjectDetailsDisplayLogic {
    
    func displayProjectDetails(_ viewModel: OnGoingProjectDetails.Info.ViewModel.Project) {
        self.viewModel = viewModel
        mainView.setup(viewModel: viewModel)
    }
    
    func displayLoading(_ loading: Bool) {
        activityView.isHidden = !loading
    }
}
