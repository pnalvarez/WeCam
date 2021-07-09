//
//  ProfileDetailsController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit
import WCUIKit

protocol ProfileDetailsDisplayLogic: ViewInterface {
    func displayUserInfo(_ viewModel: ProfileDetails.Info.ViewModel.User)
    func displayError(_ viewModel: String)
    func displayNewConnectionType(_ viewModel: ProfileDetails.Info.ViewModel.NewConnectionType)
    func displayEndRequest()
    func displaySignOut()
    func displayConfirmation(_ viewModel: ProfileDetails.Info.ViewModel.InteractionConfirmation)
    func displayProjectDetails()
    func displayFinishedProjectDetails()
}

class ProfileDetailsController: BaseViewController {
    
    private lazy var profileHeaderView: WCProfileHeaderView = {
        let view = WCProfileHeaderView(frame: .zero)
        view.delegate = self
        return view
    }()
    
    private lazy var ongoingProjectsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.assignProtocols(to: self)
        view.alwaysBounceHorizontal = true
        view.bounces = false
        view.backgroundColor = .clear
        view.registerCell(cellType: ProfileDetailsOnGoingProjectCollectionViewCell.self)
        return view
    }()
    
    private lazy var finishedProjectsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.assignProtocols(to: self)
        view.alwaysBounceHorizontal = true
        view.bounces = false
        view.backgroundColor = .clear
        view.registerCell(cellType: ProfileDetailsFinishedProjectCollectionViewCell.self)
        return view
    }()
    
    private lazy var mainView: ProfileDetailsView = {
        let view = ProfileDetailsView(frame: .zero,
                                      ongoingProjectsCollectionView: ongoingProjectsCollectionView,
                                      finishedProjectsCollectionView: finishedProjectsCollectionView,
                                      profileHeaderView: profileHeaderView)
        return view
    }()
    
    private var ongoingProjects: [ProfileDetails.Info.ViewModel.Project]? {
        didSet {
            DispatchQueue.main.async {
                self.ongoingProjectsCollectionView.reloadData()
            }
        }
    }
    
    private var finishedProjects: [ProfileDetails.Info.ViewModel.Project]? {
        didSet {
            DispatchQueue.main.async {
                self.finishedProjectsCollectionView.reloadData()
            }
        }
    }
    
    private var interactor: ProfileDetailsBusinessLogic?
    var router: ProfileDetailsRouterProtocol?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.tabBarController?.tabBar.isHidden = false
        interactor?.fetchUserInfo(ProfileDetails.Request.UserData())
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    private func setup() {
        let viewController = self
        let presenter = ProfileDetailsPresenter(viewController: viewController)
        let interactor = ProfileDetailsInteractor(presenter: presenter)
        let router = ProfileDetailsRouter()
        viewController.router = router
        router.dataStore = interactor
        router.viewController = viewController
        viewController.interactor = interactor
    }
}

extension ProfileDetailsController: WCProfileHeaderViewDelegate {
    
    func didTapRelationInteractionButton(relationState: WCProfileHeaderView.RelationState,
                                         profileHeaderView: WCProfileHeaderView) {
        interactor?.fetchInteract(ProfileDetails.Request.AddConnection())
    }
    
    func didTapInviteToProjects(profileHeaderView: WCProfileHeaderView) {
        router?.routeToInviteToProjects()
    }
    
    func didTapConnections(profileHeaderView: WCProfileHeaderView) {
        router?.routeToAllConnections()
    }
    
    func didTapEditProfile(profileHeaderView: WCProfileHeaderView) {
        router?.routeToEditProfileDetails()
    }
}

extension ProfileDetailsController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == ongoingProjectsCollectionView {
            return ongoingProjects?.count ?? 0
        } else if collectionView == finishedProjectsCollectionView {
            return finishedProjects?.count ?? 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == ongoingProjectsCollectionView {
            guard let viewModel = ongoingProjects?[indexPath.row] else {
                return UICollectionViewCell()
            }
            let cell = collectionView.dequeueReusableCell(indexPath: indexPath, type: ProfileDetailsOnGoingProjectCollectionViewCell.self)
            cell.setup(viewModel: viewModel)
            return cell
        } else if collectionView == finishedProjectsCollectionView {
            guard let viewModel = finishedProjects?[indexPath.row] else {
                return UICollectionViewCell()
            }
            let cell = collectionView.dequeueReusableCell(indexPath: indexPath, type: ProfileDetailsFinishedProjectCollectionViewCell.self)
            cell.setup(viewModel: viewModel)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension ProfileDetailsController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == ongoingProjectsCollectionView {
            interactor?.didSelectOnGoingProject(ProfileDetails.Request.SelectProjectWithIndex(index: indexPath.row))
        } else if collectionView == finishedProjectsCollectionView {
            interactor?.didSelectFinishedProject(ProfileDetails.Request.SelectProjectWithIndex(index: indexPath.row))
        }
    }
}

extension ProfileDetailsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == ongoingProjectsCollectionView {
            return CGSize(width: ProfileDetails.Constants.Dimensions.Widths.ongoingProjects,
                          height: ProfileDetails.Constants.Dimensions.Heights.ongoingProjects)
        } else if collectionView == finishedProjectsCollectionView {
            return CGSize(width: ProfileDetails.Constants.Dimensions.Widths.finishedProjects,
                          height: ProfileDetails.Constants.Dimensions.Heights.finishedProjects)
        }
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return ProfileDetails.Constants.Dimensions.lineSpacingSection
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return ProfileDetails.Constants.Dimensions.interItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: ProfileDetails.Constants.Dimensions.verticalMargin,
                                 left: ProfileDetails.Constants.Dimensions.horizontalMargin,
                                 bottom: ProfileDetails.Constants.Dimensions.verticalMargin,
                                 right: ProfileDetails.Constants.Dimensions.horizontalMargin)
    }
}


extension ProfileDetailsController: ProfileDetailsDisplayLogic {
    
    func displayUserInfo(_ viewModel: ProfileDetails.Info.ViewModel.User) {
        if viewModel.progressingProjects.isEmpty {
            ongoingProjectsCollectionView.backgroundView = WCEmptyListView(frame: .zero, layout: .small, text: ProfileDetails.Constants.Texts.emptyOngoingProjectsList)
        } else {
            ongoingProjectsCollectionView.backgroundView = nil
        }
        if viewModel.finishedProjects.isEmpty {
            finishedProjectsCollectionView.backgroundView = WCEmptyListView(frame: .zero, text: ProfileDetails.Constants.Texts.emptyFinishedProjectsList)
        } else {
            finishedProjectsCollectionView.backgroundView = nil
        }
        ongoingProjects = viewModel.progressingProjects
        finishedProjects = viewModel.finishedProjects
        profileHeaderView.setup(profileImage: viewModel.image,
                                name: viewModel.name,
                                email: viewModel.email,
                                phoneNumber: viewModel.phoneNumber,
                                ocupation: viewModel.occupation,
                                connectionsNumber: viewModel.connectionsCount,
                                relation: viewModel.connectionType)
    }
    
    func displayError(_ viewModel: String) {
        UIAlertController.displayAlert(in: self, title: ProfileDetails
                                        .Constants
                                        .Texts
                                        .addConnectionError, message: viewModel)
    }
    
    func displayNewConnectionType(_ viewModel: ProfileDetails.Info.ViewModel.NewConnectionType) {
        profileHeaderView.setup(relation: viewModel.type)
    }
    
    func displayEndRequest() {
        
    }
    
    func displaySignOut() {
        DispatchQueue.main.async {
            self.router?.routeToSignIn()
        }
    }
    
    func displayConfirmation(_ viewModel: ProfileDetails.Info.ViewModel.InteractionConfirmation) {
        tabBarController?.tabBar.isHidden = true
        WCDialogView().show(dialogType: .interaction(confirmText: WCConstants.Strings.yesAnswer, cancelText: WCConstants.Strings.noAnswer), in: self, description: viewModel.text, doneAction: {
            self.interactor?.fetchConfirmInteraction(ProfileDetails.Request.ConfirmInteraction())
        })
    }
    
    func displayProjectDetails() {
        router?.routeToOnGoingProjectDetails()
    }
    
    func displayFinishedProjectDetails() {
        router?.routeToFinishedProjectsDetails()
    }
}
