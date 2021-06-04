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
    func displayAllConnections()
    func displayEndRequest()
    func displayInterfaceForLogged()
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
    
    private lazy var confirmationAlertView: ConfirmationAlertView = {
        let view = ConfirmationAlertView(frame: .zero,
                                         delegate: self)
        return view
    }()
    
    private lazy var translucentView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = ProfileDetails.Constants.Colors.translucentView
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeModal)))
        view.isHidden = true
        return view
    }()
    
    private lazy var addConnectionButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapAddInteractButton), for: .touchUpInside)
        return view
    }()
    
    private lazy var allConnectionsButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapAllConnectionsButton), for: .touchUpInside)
        view.layer.cornerRadius = 4
        view.backgroundColor = ProfileDetails.Constants.Colors.allConnectionsButton
        return view
    }()
    
    private lazy var inviteToProjectButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        view.addTarget(self, action: #selector(didTapInviteToProject), for: .touchUpInside)
        view.setTitle(ProfileDetails.Constants.Texts.inviteToProjectButton, for: .normal)
        view.setTitleColor(ProfileDetails.Constants.Colors.inviteToProjectButtonText, for: .normal)
        view.backgroundColor = ProfileDetails.Constants.Colors.inviteToProjectButtonBackground
        view.titleLabel?.font = ProfileDetails.Constants.Fonts.inviteToProjectButton
        return view
    }()
    
    private lazy var editProfileButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapEditProfile), for: .touchUpInside)
        view.setTitle(ProfileDetails.Constants.Texts.editProfileButton, for: .normal)
        view.setTitleColor(ProfileDetails.Constants.Colors.editProfileButtonText, for: .normal)
        view.titleLabel?.font = ProfileDetails.Constants.Fonts.editProfileButton
        view.layer.borderWidth = 1
        view.layer.borderColor = ProfileDetails.Constants.Colors.editProfileButtonLayer
        view.isHidden = true
        return view
    }()
    
    private lazy var mainView: ProfileDetailsView = {
        let view = ProfileDetailsView(frame: .zero,
                                      ongoingProjectsCollectionView: ongoingProjectsCollectionView,
                                      finishedProjectsCollectionView: finishedProjectsCollectionView,
                                      confirmationAlertView: confirmationAlertView,
                                      translucentView: translucentView,
                                      inviteToProjectButton: inviteToProjectButton,
                                      addConnectionButton: addConnectionButton,
                                      allConnectionsButton: allConnectionsButton,
                                      editProfileButton: editProfileButton)
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
    
    @objc
    private func closeModal() {
        mainView.hideConfirmationView()
        tabBarController?.tabBar.isHidden = false
    }
    
    @objc
    private func didTapAddInteractButton() {
        interactor?.fetchInteract(ProfileDetails.Request.AddConnection())
    }
    
    @objc
    private func didTapAllConnectionsButton() {
        interactor?.fetchAllConnections(ProfileDetails.Request.AllConnections())
    }
    
    @objc
    private func didSwipeConfirmationAlertView() {
        mainView.hideConfirmationView()
    }
    
    @objc
    private func didTapEditProfile() {
        router?.routeToEditProfileDetails()
    }
    
    @objc
    private func didTapInviteToProject() {
        router?.routeToInviteToProjects()
    }
}

extension ProfileDetailsController: WCProfileHeaderViewDelegate {
    
    func didTapRelationInteractionButton(relationState: WCProfileHeaderView.RelationState,
                                         profileHeaderView: WCProfileHeaderView) {
        interactor?.fetchInteract(ProfileDetails.Request.AddConnection())
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
            return CGSize(width: 84, height: 84)
        } else if collectionView == finishedProjectsCollectionView {
            return CGSize(width: 128, height: 182)
        }
        return CGSize(width: 0, height: 0)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 26, bottom: 0, right: 26)
    }
}

extension ProfileDetailsController: ConfirmationAlertViewDelegate {
    
    func didTapAccept() {
        interactor?.fetchConfirmInteraction(ProfileDetails.Request.ConfirmInteraction())
        mainView.hideConfirmationView()
        tabBarController?.tabBar.isHidden = false
    }
    
    func didTapRefuse() {
        mainView.hideConfirmationView()
        tabBarController?.tabBar.isHidden = false
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
        mainView.setup(viewModel: viewModel)
    }
    
    func displayError(_ viewModel: String) {
        UIAlertController.displayAlert(in: self, title: ProfileDetails
            .Constants
            .Texts
            .addConnectionError, message: viewModel)
    }
    
    func displayNewConnectionType(_ viewModel: ProfileDetails.Info.ViewModel.NewConnectionType) {
        addConnectionButton.setImage(viewModel.image, for: .normal)
    }
    
    func displayAllConnections() {
        router?.routeToAllConnections()
    }
    
    func displayEndRequest() {
        
    }
    
    func displayInterfaceForLogged() {
        inviteToProjectButton.isHidden = true
        editProfileButton.isHidden = false
    }
    
    func displaySignOut() {
        router?.routeToSignIn()
    }
    
    func displayConfirmation(_ viewModel: ProfileDetails.Info.ViewModel.InteractionConfirmation) {
        tabBarController?.tabBar.isHidden = true
        mainView.displayConfirmationView(withText: viewModel.text)
    }
    
    func displayProjectDetails() {
        router?.routeToOnGoingProjectDetails()
    }
    
    func displayFinishedProjectDetails() {
        router?.routeToFinishedProjectsDetails()
    }
}
