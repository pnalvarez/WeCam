//
//  ProfileDetailsController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol ProfileDetailsDisplayLogic: class {
    func displayUserInfo(_ viewModel: ProfileDetails.Info.ViewModel.User)
    func displayError(_ viewModel: String)
    func displayNewConnectionType(_ viewModel: ProfileDetails.Info.ViewModel.NewConnectionType)
    func displayAllConnections()
    func displayEndRequest()
    func displayInterfaceForLogged()
    func displayLoading(_ loading: Bool)
    func displaySignOut()
    func displayConfirmation(_ viewModel: ProfileDetails.Info.ViewModel.InteractionConfirmation)
    func displayProjectDetails()
}

class ProfileDetailsController: BaseViewController {
    
    private lazy var onGoingProjectsCarrousel: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.alwaysBounceVertical = false
        view.alwaysBounceHorizontal = false
        view.bounces = false
        view.delegate = self
        view.backgroundColor = ThemeColors.whiteThemeColor.rawValue
        return view
    }()
    
    private lazy var projectsContainer: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
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
    
    private lazy var activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.color = ProfileDetails.Constants.Colors.activity
        view.backgroundColor = .white
        view.startAnimating()
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.setImage(ProfileDetails.Constants.Images.backButton, for: .normal)
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
                                      activityView: activityView,
                                      projectsCarrousel: onGoingProjectsCarrousel,
                                      projectsContainer: projectsContainer,
                                      confirmationAlertView: confirmationAlertView,
                                      translucentView: translucentView,
                                      backButton: backButton,
                                      inviteToProjectButton: inviteToProjectButton,
                                      addConnectionButton: addConnectionButton,
                                      allConnectionsButton: allConnectionsButton,
                                      editProfileButton: editProfileButton)
        return view
    }()
    
    
    private(set) var projectViews: [OnGoingProjectDisplayView] = []
    
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
        clearCarrousel()
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

extension ProfileDetailsController {
    
    private func buildOnGoingProjectsCarrousel() {
        onGoingProjectsCarrousel.contentSize = CGSize(width: 110 * projectViews.count + 50, height: 105)
//        onGoingProjectsCarrousel.isHidden = projectViews.isEmpty
        for i in 0..<projectViews.count {
            projectsContainer.addSubview(projectViews[i])
            projectViews[i].snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.width.equalTo(105)
                if i == 0 {
                    make.left.equalToSuperview().inset(26)
                } else {
                    make.left.equalTo(projectViews[i-1].snp.right).offset(5)
                }
                if i == projectViews.count {
                    make.right.equalToSuperview()
                }
            }
        }
    }
    
    private func clearCarrousel() {
        for view in projectsContainer.subviews {
            view.removeFromSuperview()
        }
    }
}

extension ProfileDetailsController {
    
    @objc
    private func closeModal() {
        mainView.hideConfirmationView()
        tabBarController?.tabBar.isHidden = false
    }
    
    @objc
    private func didTapBackButton() {
        router?.routeBack()
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
    private func didTapCarrouselItem() {
        print("Click")
    }
    
    @objc
    private func didTapInviteToProject() {
        router?.routeToInviteToProjects()
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

extension ProfileDetailsController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.layoutIfNeeded()
        for view in projectViews {
            view.layoutIfNeeded()
        }
    }
}

extension ProfileDetailsController: ProfileDetailsDisplayLogic {
    
    func displayUserInfo(_ viewModel: ProfileDetails.Info.ViewModel.User) {
        projectViews = viewModel.progressingProjects.map({ OnGoingProjectDisplayView(frame: .zero, projectImage: $0.image)})
        for i in 0..<projectViews.count {
//            let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapCarrouselItem))
//            projectViews[i].addGestureRecognizer(gesture)
            projectViews[i].callback = { self.interactor?.didSelectOnGoingProject(ProfileDetails.Request.SelectProjectWithIndex(index: i))
            }
        }
//        for i in 0..<viewModel.progressingProjects.count {
//            var views = [OnGoingProjectDisplayView]()
//            views.append(OnGoingProjectDisplayView(frame: .zero,
//                                                        projectImage: viewModel.progressingProjects[i].image,
//                                                        callback: { self.interactor?.didSelectOnGoingProject(ProfileDetails.Request.SelectProjectWithIndex(index: i))}))
//            projectViews = views
//        }
        buildOnGoingProjectsCarrousel()
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
        backButton.isHidden = true
        inviteToProjectButton.isHidden = true
        editProfileButton.isHidden = false
    }
    
    func displayLoading(_ loading: Bool) {
        activityView.isHidden = !loading
    }
    
    func displaySignOut() {
        router?.routeToSignIn()
    }
    
    func displayConfirmation(_ viewModel: ProfileDetails.Info.ViewModel.InteractionConfirmation) {
        tabBarController?.tabBar.isHidden = true
        mainView.displayConfirmationView(withText: viewModel.text)
    }
    
    func displayProjectDetails() {
        router?.routeToProjectDetails()
    }
}
