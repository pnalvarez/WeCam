//
//  FinishedProjectDetailsController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 08/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol FinishedProjectDetailsDisplayLogic: class {
    func displayProjectData(_ viewModel: FinishedProjectDetails.Info.ViewModel.Project)
    func displayProfileDetails()
    func displayInviteUsers()
    func displayLoading(_ loading: Bool)
    func displayRelationUI(_ viewModel: FinishedProjectDetails.Info.ViewModel.Relation)
    func displayAllParticipants()
    func displayRoutingUI(_ viewModel: FinishedProjectDetails.Info.ViewModel.Routing)
    func displayError(_ viewModel: FinishedProjectDetails.Info.ViewModel.Error)
}

class FinishedProjectDetailsController: BaseViewController {
    
    private lazy var activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.color = ThemeColors.mainRedColor.rawValue
        view.backgroundColor = .white
        view.startAnimating()
        view.isHidden = true
        return view
    }()
    
    private lazy var closeButton: DefaultCloseButton = {
        let view = DefaultCloseButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        return view
    }()
    
    private lazy var backButton: DefaultBackButton = {
        let view = DefaultBackButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        return view
    }()
    
    private lazy var watchButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.layer.cornerRadius = 4
        view.addTarget(self, action: #selector(didTapWatch), for: .touchUpInside)
        view.backgroundColor = FinishedProjectDetails.Constants.Colors.watchButtonBackground
        view.setTitle(FinishedProjectDetails.Constants.Texts.watchButton, for: .normal)
        view.setTitleColor(FinishedProjectDetails.Constants.Colors.watchButtonText, for: .normal)
        view.titleLabel?.font = FinishedProjectDetails.Constants.Fonts.watchButton
        return view
    }()
    
    private lazy var interactionButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapInteraction), for: .touchUpInside)
        view.backgroundColor = FinishedProjectDetails.Constants.Colors.interactionButtonBackground
        view.setTitle(FinishedProjectDetails.Constants.Texts.interactionAcceptInvite, for: .normal)
        view.setTitleColor(FinishedProjectDetails.Constants.Colors.interactionButtonText, for: .normal)
        view.titleLabel?.font = FinishedProjectDetails.Constants.Fonts.interactionButton
        view.layer.borderWidth = 1
        view.layer.borderColor = FinishedProjectDetails.Constants.Colors.interactionButtonLayer
        view.layer.cornerRadius = 4
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
        view.backgroundColor = FinishedProjectDetails.Constants.Colors.moreInfoButtonBackground
        view.setAttributedTitle(NSAttributedString(string: FinishedProjectDetails.Constants.Texts.moreInfoButton, attributes: [NSAttributedString.Key.foregroundColor: FinishedProjectDetails.Constants.Colors.moreInfoButtonText, NSAttributedString.Key.font: FinishedProjectDetails.Constants.Fonts.moreInfoButton, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]), for: .normal)
        return view
    }()
    
    private lazy var mainView: FinishedProjectDetailsView = {
        let view = FinishedProjectDetailsView(frame: .zero,
                                              activityView: activityView,
                                              closeButton: closeButton,
                                              backButton: backButton,
                                              watchButton: watchButton,
                                              interactionButton: interactionButton,
                                              teamCollectionView: teamCollectionView,
                                              moreInfoButton: moreInfoButton)
        view.backgroundColor = .white
        return view
    }()
    
    private var viewModel: FinishedProjectDetails.Info.ViewModel.Project? {
        didSet {
            mainView.setup(viewModel: viewModel)
            teamCollectionView.reloadData()
        }
    }
    
    private var interactor: FinishedProjectDetailsBusinessLogic?
    var router: FinishedProjectDetailsRouterProtocol?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.tabBarController?.tabBar.isHidden = true
        navigationController?.isNavigationBarHidden = true
        interactor?.fetchRoutingModel(FinishedProjectDetails.Request.FetchRoutingModel())
        interactor?.fetchNotinvitedUsers(FinishedProjectDetails.Request.FetchNotInvitedUsers())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.fetchProjectData(FinishedProjectDetails.Request.FetchProjectData())
        interactor?.fetchProjectRelation(FinishedProjectDetails.Request.ProjectRelation())
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    private func setup() {
        let viewController = self
        let presenter = FinishedProjectDetailsPresenter(viewController: viewController)
        let interactor = FinishedProjectDetailsInteractor(presenter: presenter)
        let router = FinishedProjectDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension FinishedProjectDetailsController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.participants.count ?? 0 >= 4 ? 4 : viewModel?.participants.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = teamCollectionView.dequeueReusableCell(indexPath: indexPath, type: TeamMemberCollectionViewCell.self)
        guard let viewModel = viewModel?.participants else { return UICollectionViewCell() }
        cell.setup(viewModel: TeamMemberViewModel(name: viewModel[indexPath.row].name,
                                                  jobDescription: viewModel[indexPath.row].ocupation,
                                                  image: viewModel[indexPath.row].image))
        return cell
    }
}

extension FinishedProjectDetailsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: UIScreen.main.bounds.width / 2.8, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 30, bottom: 0, right: 30)
    }
}

extension FinishedProjectDetailsController {
    
    @objc
    private func didTapClose() {
        router?.dismiss()
    }
    
    @objc
    private func didTapWatch() {
        router?.routeToWatchVideo()
    }
    
    @objc
    private func didTapInteraction() {
        router?.routeToProjectInvites()
    }
    
    @objc
    private func didTapMoreInfo() {
        
    }
    
    @objc
    private func didTapBack() {
        router?.dismiss()
    }
}

extension FinishedProjectDetailsController: FinishedProjectDetailsDisplayLogic {
    
    func displayProjectData(_ viewModel: FinishedProjectDetails.Info.ViewModel.Project) {
        self.viewModel = viewModel
    }
    
    func displayProfileDetails() {
        
    }
    
    func displayInviteUsers() {
        
    }
    
    func displayLoading(_ loading: Bool) {
        activityView.isHidden = !loading
    }
    
    func displayRelationUI(_ viewModel: FinishedProjectDetails.Info.ViewModel.Relation) {
        switch viewModel.relation {
        case .author:
            interactionButton.setTitle(FinishedProjectDetails.Constants.Texts.interactionInviteFriends, for: .normal)
        case .simpleParticipant:
            interactionButton.setTitle(FinishedProjectDetails.Constants.Texts.interactionExit, for: .normal)
        case .receivedInvite:
            interactionButton.setTitle(FinishedProjectDetails.Constants.Texts.interactionAcceptInvite, for: .normal)
        case .nothing:
            interactionButton.isHidden = true
        }
    }
    
    func displayAllParticipants() {
        
    }
    
    func displayRoutingUI(_ viewModel: FinishedProjectDetails.Info.ViewModel.Routing) {
        backButton.isHidden = viewModel.method == .modal
        closeButton.isHidden = viewModel.method == .push
    }
    
    func displayError(_ viewModel: FinishedProjectDetails.Info.ViewModel.Error) {
        UIAlertController.displayAlert(in: self, title: viewModel.title, message: viewModel.description)
    }
}
