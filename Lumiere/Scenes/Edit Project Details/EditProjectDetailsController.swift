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
    
    private lazy var projectTitleTextField: WCProjectDataTextField = {
        let view = WCProjectDataTextField(frame: .zero)
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
    
    private lazy var sinopsisTextView: WCProjectDataTextView = {
        let view = WCProjectDataTextView(frame: .zero, textContainer: nil, layout: .big)
        view.delegate = self
        return view
    }()
    
    private lazy var needTextView: WCProjectDataTextView = {
        let view = WCProjectDataTextView(frame: .zero, textContainer: nil)
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

    private lazy var publishButton: WCActionButton = {
        let view = WCActionButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapPublish), for: .touchUpInside)
        view.text = EditProjectDetails.Constants.Texts.publishButton
        return view
    }()
    
    private lazy var mainView: EditProjectDetailsView = {
        let view = EditProjectDetailsView(frame: .zero,
                                          inviteFriendsButton: inviteFriendsButton,
                                          projectTitleTextField: projectTitleTextField,
                                          sinopsisTextView: sinopsisTextView,
                                          needTextView: needTextView,
                                          invitationsCollectionView: invitationsCollectionView,
                                          publishButton: publishButton)
        return view
    }()
    
    private var invitedUsersViewModel: EditProjectDetails.Info.ViewModel.InvitedUsers? {
        didSet {
            DispatchQueue.main.async {
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mainView.flushCarrousel()
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
        if let inputTextField = textField as? WCProjectDataTextField {
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
}

extension EditProjectDetailsController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if let inputTextView = textView as? WCProjectDataTextView {
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
        
        return CGSize(width: 128, height: 38)
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
        mainView.setup(viewModel: viewModel)
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
