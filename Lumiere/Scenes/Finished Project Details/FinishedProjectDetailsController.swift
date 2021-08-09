//
//  FinishedProjectDetailsController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 08/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

protocol FinishedProjectDetailsDisplayLogic: ViewInterface {
    func displayProjectData(_ viewModel: FinishedProjectDetails.Info.ViewModel.Project)
    func displayProfileDetails()
    func displayInviteUsers()
    func displayRelationUI(_ viewModel: FinishedProjectDetails.Info.ViewModel.Relation)
    func displayAllParticipants()
    func displayProjectInvites()
    func displayInteractionConfirmationModal(forRelation viewModel: FinishedProjectDetails.Info.ViewModel.Relation)
    func displayRoutingUI(_ viewModel: FinishedProjectDetails.Info.ViewModel.Routing)
}

class FinishedProjectDetailsController: BaseViewController {
    
    private lazy var watchButton: WCPrimaryActionButton = {
        let view = WCPrimaryActionButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapWatch), for: .touchUpInside)
        view.backgroundColor = FinishedProjectDetails.Constants.Colors.watchButtonBackground
        view.setTitle(FinishedProjectDetails.Constants.Texts.watchButton, for: .normal)
        return view
    }()
    
    private lazy var interactionButton: WCSecondaryButton = {
        let view = WCSecondaryButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapInteraction), for: .touchUpInside)
        view.text = FinishedProjectDetails.Constants.Texts.interactionAcceptInvite
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
                                              watchButton: watchButton,
                                              interactionButton: interactionButton,
                                              teamCollectionView: teamCollectionView,
                                              moreInfoButton: moreInfoButton)
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
    
    @objc
    private func didTapWatch() {
        router?.routeToWatchVideo()
    }
    
    @objc
    private func didTapInteraction() {
        interactor?.didTapInteractionButton(FinishedProjectDetails.Request.Interaction())
    }
    
    @objc
    private func didTapMoreInfo() {
        
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
        cell.setup(name: viewModel[indexPath.row].name,
                   jobDescription: viewModel[indexPath.row].ocupation,
                   image: viewModel[indexPath.row].image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor?.didSelectTeamMember(FinishedProjectDetails.Request.SelectTeamMember(index: indexPath.row))
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

extension FinishedProjectDetailsController: FinishedProjectDetailsDisplayLogic {
    
    func displayProjectData(_ viewModel: FinishedProjectDetails.Info.ViewModel.Project) {
        self.viewModel = viewModel
    }
    
    func displayProfileDetails() {
        router?.routeToProfileDetails()
    }
    
    func displayInviteUsers() {
        router?.routeToProjectInvites()
    }
    
    func displayRelationUI(_ viewModel: FinishedProjectDetails.Info.ViewModel.Relation) {
        switch viewModel.relation {
        case .author:
            interactionButton.text = FinishedProjectDetails.Constants.Texts.interactionInviteFriends
        case .simpleParticipant:
            interactionButton.text = FinishedProjectDetails.Constants.Texts.interactionExit
        case .receivedInvite:
            interactionButton.text = FinishedProjectDetails.Constants.Texts.interactionAcceptInvite
        case .nothing:
            interactionButton.isHidden = true
        }
    }
    
    func displayAllParticipants() {
        #warning("TO DO")
    }
    
    func displayProjectInvites() {
        router?.routeToProjectInvites()
    }
    
    func displayInteractionConfirmationModal(forRelation viewModel: FinishedProjectDetails.Info.ViewModel.Relation) {
        WCDialogView().show(dialogType: .interaction(confirmText: WCConstants.Strings.yesAnswer, cancelText: WCConstants.Strings.noAnswer), in: self, title: viewModel.relation.confirmationAlertTitle, description: viewModel.relation.confirmationAlertDescription, doneAction: {
            self.interactor?.didAcceptInteraction(FinishedProjectDetails.Request.AcceptInteraction())
        }, cancelAction: {
            self.interactor?.didRefuseInteraction(FinishedProjectDetails.Request.RefuseInteraction())
        })
    }
    
    func displayRoutingUI(_ viewModel: FinishedProjectDetails.Info.ViewModel.Routing) {
        mainView.setupAuxiliarComponentsVisibility(backButtonVisible: viewModel.backButtonVisible,
                                                   closeButtonVisible: viewModel.closeButtonVisible)
    }
}
