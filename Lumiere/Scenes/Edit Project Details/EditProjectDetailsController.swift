//
//  EditProjectDetailsController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 21/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol EditProjectDetailsDisplayLogic: class {
    func displayPublishedProjectDetails()
    func displayInvitedUsers(_ viewModel: EditProjectDetails.Info.ViewModel.InvitedUsers)
    func displayLoading(_ loading: Bool)
    func displayError(_ viewModel: EditProjectDetails.Info.ViewModel.DisplayError)
    func displayUpdatedProjectContextUI()
    func displayInsertVideo()
}

class EditProjectDetailsController: BaseViewController {
    
    private lazy var activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.color = .black
        view.backgroundColor = .white
        view.startAnimating()
        return view
    }()
    
    private lazy var projectTitleTextField: ProjectDataTextField = {
        let view = ProjectDataTextField(frame: .zero)
        view.delegate = self
        return view
    }()
    
    private lazy var inviteFriendsButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapInviteFriends), for: .touchUpInside)
        view.backgroundColor = EditProjectDetails.Constants.Colors.inviteFriendsButtonBackground
        view.setTitle(EditProjectDetails.Constants.Texts.inviteFriendsButton, for: .normal)
        view.setTitleColor(EditProjectDetails.Constants.Colors.inviteFriendsButtonText, for: .normal)
        view.titleLabel?.font = EditProjectDetails.Constants.Fonts.inviteFriendsButton
        return view
    }()
    
    private lazy var sinopsisTextView: ProjectDataTextView = {
        let view = ProjectDataTextView(frame: .zero)
        view.delegate = self
        return view
    }()
    
    private lazy var needTextView: ProjectDataTextView = {
        let view = ProjectDataTextView(frame: .zero)
        return view
    }()
    
    private lazy var publishButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapPublish), for: .touchUpInside)
        view.setTitle(EditProjectDetails.Constants.Texts.publishButton, for: .normal)
        view.setTitleColor(EditProjectDetails.Constants.Colors.publishButtonText, for: .normal)
        view.backgroundColor = EditProjectDetails.Constants.Colors.publishButtonBackground
        view.titleLabel?.font = EditProjectDetails.Constants.Fonts.publishButton
        view.layer.cornerRadius = 4
        return view
    }()
    
    private lazy var loadingView: LoadingView = {
        let view = LoadingView(frame: .zero)
        view.animateRotate()
        view.isHidden = true
        return view
    }()
    
    private lazy var mainView: EditProjectDetailsView = {
        let view = EditProjectDetailsView(frame: .zero,
                                          activityView: activityView,
                                          inviteFriendsButton: inviteFriendsButton,
                                          backButton: backButton,
                                          projectTitleTextField: projectTitleTextField,
                                          sinopsisTextView: sinopsisTextView,
                                          needTextView: needTextView,
                                          publishButton: publishButton,
                                          loadingView: loadingView)
        return view
    }()
    
    private var interactor: EditProjectDetailsBusinessLogic?
    var router: EditProjectDetailsRouterProtocol?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchContext(EditProjectDetails.Request.FetchContext())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.fetchInvitations(EditProjectDetails.Request.Invitations())
        mainView.cleanTextFields()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mainView.flushCarrousel()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        activityView.isHidden = false
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    private func setup() {
        let viewController = self
        let presenter = EditProjectDetailsPresenter(viewController: viewController)
        let interactor = EditProjectDetailsInteractor(presenter: presenter)
        let router = EditProjectDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.dataStore = interactor
        router.viewController = viewController
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let inputTextField = textField as? ProjectDataTextField {
            inputTextField.textFieldState = .normal
            return true
        }
        return false
    }
}

extension EditProjectDetailsController {
    
    @objc
    private func didTapPublish() {
        interactor?.fetchSubmit(EditProjectDetails.Request.Publish(title: projectTitleTextField.text ?? .empty,
                                                                    sinopsis: sinopsisTextView.text,
                                                                    needing: needTextView.text))
    }
    
    @objc
    private func didTapInviteFriends() {
        router?.routeToInviteList()
    }
    
    @objc
    private func didTapBack() {
        router?.routeBack()
    }
}

extension EditProjectDetailsController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if let inputTextView = textView as? ProjectDataTextView {
            inputTextView.textViewState = .normal
            return true
        }
        return false
    }
}

extension EditProjectDetailsController: EditProjectDetailsDisplayLogic {
    
    func displayPublishedProjectDetails() {
        router?.routeToPublishedProjectDetails()
    }
    
    func displayInvitedUsers(_ viewModel: EditProjectDetails.Info.ViewModel.InvitedUsers) {
        mainView.setup(viewModel: viewModel)
        activityView.isHidden = true
    }
    
    func displayLoading(_ loading: Bool) {
        loadingView.animateRotate()
        loadingView.isHidden = !loading
    }
    
    func displayError(_ viewModel: EditProjectDetails.Info.ViewModel.DisplayError) {
        mainView.updateAllTextFields()
        UIAlertController.displayAlert(in: self, title: EditProjectDetails.Constants.Texts.errorTitle, message: viewModel.description)
    }
    
    func displayUpdatedProjectContextUI() {
        mainView.updateForFinishedProject()
    }
    
    func displayInsertVideo() {
        router?.routeToInsertVideo()
    }
}
