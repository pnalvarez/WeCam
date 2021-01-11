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
    func displayFinishedProjectDetails()
}

class ProfileDetailsController: BaseViewController {
    
    private lazy var onGoingProjectsCarrousel: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.alwaysBounceHorizontal = false
        view.bounces = false
        view.delegate = self
        view.backgroundColor = ThemeColors.whiteThemeColor.rawValue
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var projectsContainer: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = ThemeColors.whiteThemeColor.rawValue
        view.isHidden = true
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
    
    private lazy var finishedProjectsCarrousel: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.alwaysBounceHorizontal = false
        view.bounces = false
        view.delegate = self
        view.backgroundColor = ThemeColors.whiteThemeColor.rawValue
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var finishedProjectsContainer: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = ThemeColors.whiteThemeColor.rawValue
        view.isHidden = true
        return view
    }()
    
    private lazy var mainView: ProfileDetailsView = {
        let view = ProfileDetailsView(frame: .zero,
                                      activityView: activityView,
                                      projectsCarrousel: onGoingProjectsCarrousel,
                                      finishedProjectsCarrousel: finishedProjectsCarrousel,
                                      projectsContainer: projectsContainer,
                                      finishedProjectsContainer: finishedProjectsContainer,
                                      confirmationAlertView: confirmationAlertView,
                                      translucentView: translucentView,
                                      backButton: backButton,
                                      inviteToProjectButton: inviteToProjectButton,
                                      addConnectionButton: addConnectionButton,
                                      allConnectionsButton: allConnectionsButton,
                                      editProfileButton: editProfileButton)
        return view
    }()
    
    
    private(set) var projectViews: [OnGoingProjectDisplayView] = .empty
    private(set) var finishedProjectButtons: [UIButton] = .empty
    private var projectButtons: [UIButton] = .empty
    
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
        clearProjectsCarrousels()
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
        let scrollWidth =  ProfileDetails.Constants.Dimensions.projectViewDefaultOffset + (ProfileDetails.Constants.Dimensions.Widths.projectView + CGFloat(ProfileDetails.Constants.Dimensions.Widths.spaceBetweenProjects)) * CGFloat(projectViews.count)
        onGoingProjectsCarrousel.contentSize = CGSize(width: scrollWidth, height: ProfileDetails.Constants.Dimensions.Heights.scrollView)
        for i in 0..<projectViews.count {
            onGoingProjectsCarrousel.addSubview(projectViews[i])
            projectViews[i].snp.makeConstraints { make in
                make.top.equalToSuperview().offset(10)
                make.height.equalTo(84)
                make.width.equalTo(84)
                if i == 0 {
                    make.left.equalToSuperview().inset(26)
                } else {
                    make.left.equalTo(projectViews[i-1].snp.right).offset(35)
                }
                if i == projectViews.count-1 {
                    make.right.equalToSuperview().inset(10)
                }
            }
        }
    }
    
    private func buildFinishedProjectsCarrousel() {
        let scrollWidth = ProfileDetails.Constants.Dimensions.finishedProjectButtonDefaultOffset + (ProfileDetails.Constants.Dimensions.Widths.finishedProjectButton + CGFloat(ProfileDetails.Constants.Dimensions.Widths.spaceBetweenFinishedProjects)) * CGFloat(finishedProjectButtons.count)
        finishedProjectsCarrousel.contentSize = CGSize(width: scrollWidth, height: ProfileDetails.Constants.Dimensions.Heights.finishedScrollView)
        for i in 0..<finishedProjectButtons.count {
            finishedProjectsCarrousel.addSubview(finishedProjectButtons[i])
            finishedProjectButtons[i].snp.makeConstraints { make in
                make.top.equalToSuperview().offset(10)
                make.height.equalTo(254)
                make.width.equalTo(180)
                if i == 0 {
                    make.left.equalToSuperview().inset(23)
                } else {
                    make.left.equalTo(finishedProjectButtons[i-1].snp.right).offset(12)
                }
                if i == finishedProjectButtons.count-1 {
                    make.right.equalToSuperview().inset(10)
                }
            }
        }
    }
    private func clearProjectsCarrousels() {
        for view in onGoingProjectsCarrousel.subviews {
            if view is OnGoingProjectDisplayView {
                view.removeFromSuperview()
            }
        }
        for view in finishedProjectButtons {
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
    private func didTapInviteToProject() {
        router?.routeToInviteToProjects()
    }
    
    @objc
    private func didTapFinishedProject(_ sender: UIButton) {
        guard let index = finishedProjectButtons.firstIndex(where: { $0.image(for: .normal)?.isEqual(sender.image(for: .normal)) ?? false }) else { return }
        interactor?.didSelectFinishedProject(ProfileDetails.Request.SelectProjectWithIndex(index: index))
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
        finishedProjectButtons = viewModel.finishedProjects.map({
            let button = UIButton(frame: .zero)
            button.sd_setImage(with: URL(string: $0.image), for: .normal, completed: nil)
            button.addTarget(self, action: #selector(didTapFinishedProject(_:)), for: .touchUpInside)
            return button
        })
        for i in 0..<projectViews.count {
            projectViews[i].callback = { self.interactor?.didSelectOnGoingProject(ProfileDetails.Request.SelectProjectWithIndex(index: i))
            }
        }
        buildOnGoingProjectsCarrousel()
        buildFinishedProjectsCarrousel()
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
    
    func displayFinishedProjectDetails() {
        router?.routeToFinishedProjectsDetails()
    }
}
