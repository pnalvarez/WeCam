//
//  EditProjectDetailsController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 21/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol EditProjectDetailsDisplayLogic: class {
    func displayInviteList()
    func displayPublishedProjectDetails()
    func displayInvitedUsers(_ viewModel: EditProjectDetails.Info.ViewModel.InvitedUsers)
    func displayLoading(_ loading: Bool)
    func displayError(_ viewModel: EditProjectDetails.Info.ViewModel.DisplayError)
}

class EditProjectDetailsController: BaseViewController {
    
    private lazy var backButton: DefaultBackButton = {
        let view = DefaultBackButton(frame: .zero)
        return view
    }()
    
    private lazy var projectTitleTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.textColor = EditProjectDetails.Constants.Colors.projectTitleTextFieldText
        view.backgroundColor = EditProjectDetails.Constants.Colors.projectTitleTextFieldBackground
        view.font = EditProjectDetails.Constants.Fonts.projectTitleTextField
        view.layer.borderWidth = 1
        view.layer.borderColor = EditProjectDetails.Constants.Colors.projectTitleTextFieldLayer
        view.layer.cornerRadius = 4
        view.textAlignment = .left
        return view
    }()

    private lazy var teamValueLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.backgroundColor = EditProjectDetails.Constants.Colors.teamValueLblBackground
        view.textColor = EditProjectDetails.Constants.Colors.teamValueLblFieldText
        view.layer.borderWidth = 1
        view.layer.borderColor = EditProjectDetails.Constants.Colors.teamValueLblFieldLayer
        view.layer.cornerRadius = 4
        view.text = EditProjectDetails.Constants.Texts.teamValueLblEmpty
        view.adjustsFontSizeToFitWidth = true
        return view
    }()
    
    private lazy var sinopsisTextView: UITextView = {
        let view = UITextView(frame: .zero)
        view.textColor = EditProjectDetails.Constants.Colors.sinopsisTextFieldText
        view.font = EditProjectDetails.Constants.Fonts.sinopsisTextField
        view.backgroundColor = EditProjectDetails.Constants.Colors.sinopsisTextFieldBackground
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4
        view.layer.borderColor = EditProjectDetails.Constants.Colors.sinopsisTextFieldLayer
        view.textAlignment = .left
        return view
    }()
    
    private lazy var needTextView: UITextView = {
        let view = UITextView(frame: .zero)
        view.textColor = EditProjectDetails.Constants.Colors.needTextFieldText
        view.font = EditProjectDetails.Constants.Fonts.needTextField
        view.backgroundColor = EditProjectDetails.Constants.Colors.needTextFieldBackground
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4
        view.layer.borderColor = EditProjectDetails.Constants.Colors.needTextFieldLayer
        view.textAlignment = .left
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
                                          backButton: backButton,
                                          projectTitleTextField: projectTitleTextField,
                                          sinopsisTextView: sinopsisTextView,
                                          needTextView: needTextView,
                                          teamValueLbl: teamValueLbl,
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
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    private func setup() {
        let viewController = self
        let interactor = EditProjectDetailsInteractor(viewController: viewController)
        let router = EditProjectDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.dataStore = interactor
        router.viewController = viewController
    }
}

extension EditProjectDetailsController {
    
    @objc
    private func didTapPublish() {
        router?.routeBack()
    }
}

extension EditProjectDetailsController: EditProjectDetailsDisplayLogic {
    
    func displayInviteList() {
        router?.routeToInviteList()
    }
    
    func displayPublishedProjectDetails() {
        router?.routeToPublishedProjectDetails()
    }
    
    func displayInvitedUsers(_ viewModel: EditProjectDetails.Info.ViewModel.InvitedUsers) {
        teamValueLbl.text = viewModel.text
    }
    
    func displayLoading(_ loading: Bool) {
        loadingView.isHidden = !loading
    }
    
    func displayError(_ viewModel: EditProjectDetails.Info.ViewModel.DisplayError) {
        UIAlertController.displayAlert(in: self, title: EditProjectDetails.Constants.Texts.errorTitle, message: viewModel.description)
    }
}
