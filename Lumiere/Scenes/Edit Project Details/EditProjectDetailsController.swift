//
//  EditProjectDetailsController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 21/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

protocol EditProjectDetailsDisplayLogic: ViewInterface {
    func displayPublishedProjectDetails()
    func displayInvitedUsers(_ viewModel: EditProjectDetails.Info.ViewModel.InvitedUsers)
    func displayError(_ viewModel: EditProjectDetails.Info.ViewModel.DisplayError)
    func displayUpdatedProjectContextUI()
    func displayInsertVideo()
}

class EditProjectDetailsController: BaseViewController {
    
    private lazy var projectTitleTextField: WCDataInputTextFieldView = {
        let view = WCDataInputTextFieldView(frame: .zero, textFieldType: .textField)
        view.setup(placeholder: EditProjectDetails.Constants.Texts.projectTitleLbl)
        view.delegate = self
        return view
    }()
    
    private lazy var inviteFriendsButton: WCSecondaryButton = {
        let view = WCSecondaryButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapInviteFriends), for: .touchUpInside)
        view.text = EditProjectDetails.Constants.Texts.inviteFriendsButton
        return view
    }()
    
    private lazy var sinopsisTextField: WCDataInputTextFieldView = {
        let view = WCDataInputTextFieldView(frame: .zero, textFieldType: .textView(layout: .big))
        view.setup(placeholder: EditProjectDetails.Constants.Texts.sinopsisFixedLbl)
        view.delegate = self
        return view
    }()
    
    private lazy var needTextField: WCDataInputTextFieldView = {
        let view = WCDataInputTextFieldView(frame: .zero, textFieldType: .textView(layout: .medium))
        view.setup(placeholder: EditProjectDetails.Constants.Texts.needLbl)
        view.delegate = self
        return view
    }()
    
    private lazy var invitationsStackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .vertical
        view.spacing = 12
        return view
    }()
    
    private lazy var teamFixedLbl: WCUILabelRobotoRegular16Gray = {
        let view = WCUILabelRobotoRegular16Gray(frame: .zero)
        view.text = EditProjectDetails.Constants.Texts.teamFixedLbl
        return view
    }()
    
    private lazy var invitationsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.assignProtocols(to: self)
        view.alwaysBounceHorizontal = true
        view.bounces = false
        view.registerCell(cellType: TeamMemberCollectionViewCell.self)
        view.backgroundColor = .white
        return view
    }()

    private lazy var publishButton: WCPrimaryActionButton = {
        let view = WCPrimaryActionButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapPublish), for: .touchUpInside)
        view.text = EditProjectDetails.Constants.Texts.publishButton
        return view
    }()
    
    private lazy var mainView: EditProjectDetailsView = {
        let view = EditProjectDetailsView(frame: .zero,
                                          inviteFriendsButton: inviteFriendsButton,
                                          projectTitleTextField: projectTitleTextField,
                                          sinopsisTextView: sinopsisTextField,
                                          needTextView: needTextField,
                                          teamFixedLbl: teamFixedLbl,
                                          invitationsStackView: invitationsStackView,
                                          invitationsCollectionView: invitationsCollectionView,
                                          publishButton: publishButton)
        return view
    }()
    
    private var invitedUsersViewModel: EditProjectDetails.Info.ViewModel.InvitedUsers? {
        didSet {
            DispatchQueue.main.async {
                self.teamFixedLbl.isHidden = self.invitedUsersViewModel?.users.isEmpty ?? true
                self.invitationsCollectionView.isHidden = self.invitedUsersViewModel?.users.isEmpty ?? true
                self.invitationsCollectionView.reloadData()
            }
        }
    }
    
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        mainView.defaultScreenLoading(false)
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
        if let inputTextField = textField as? WCDataTextField {
            inputTextField.textFieldState = .normal
            return true
        }
        return false
    }
    
    @objc
    private func didTapPublish() {
        interactor?.fetchSubmit(EditProjectDetails.Request.Publish(title: projectTitleTextField.text ?? .empty,
                                                                   sinopsis: sinopsisTextField.text ?? .empty,
                                                                   needing: needTextField.text ?? .empty))
    }
    
    @objc
    private func didTapInviteFriends() {
        router?.routeToInviteList()
    }
}

extension EditProjectDetailsController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if let inputTextView = textView as? WCDataTextView {
            inputTextView.textViewState = .normal
            return true
        }
        return false
    }
}

extension EditProjectDetailsController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return invitedUsersViewModel?.users.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = invitationsCollectionView.dequeueReusableCell(indexPath: indexPath, type: TeamMemberCollectionViewCell.self)
        guard let user = invitedUsersViewModel?.users[indexPath.row] else {
            return UICollectionViewCell()
        }
        cell.setup(name: user.name, jobDescription: user.ocupation, image: user.image)
        return cell
    }
}

extension EditProjectDetailsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 128, height: 42)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 11
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 10, left: 22, bottom: 0, right: 22)
    }
}

extension EditProjectDetailsController: EditProjectDetailsDisplayLogic {
    
    func displayPublishedProjectDetails() {
        router?.routeToPublishedProjectDetails()
    }
    
    func displayInvitedUsers(_ viewModel: EditProjectDetails.Info.ViewModel.InvitedUsers) {
        self.invitedUsersViewModel = viewModel
        mainView.defaultScreenLoading(true)
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
