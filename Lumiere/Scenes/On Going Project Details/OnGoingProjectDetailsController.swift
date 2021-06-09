//
//  OnGoingProjectDetailsController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 22/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit
import Photos

protocol OnGoingProjectDetailsDisplayLogic: ViewInterface {
    func displayProjectDetails(_ viewModel: OnGoingProjectDetails.Info.ViewModel.Project)
    func displayError(_ viewModel: String)
    func displayUIForRelation(_ viewModel: OnGoingProjectDetails.Info.ViewModel.RelationModel)
    func displayFeedback(_ viewModel: OnGoingProjectDetails.Info.ViewModel.Feedback)
    func displayUserDetails()
    func displayConfirmationModal(_ viewModel: OnGoingProjectDetails.Info.ViewModel.RelationModel)
    func hideConfirmationModal()
    func displayInteractionEffectivated()
    func displayRefusedInteraction()
    func displayEditProgressModal(_ viewModel: OnGoingProjectDetails.Info.ViewModel.Progress)
    func hideEditProgressModal()
    func displayConfirmFinishedProjectAlert()
    func displayInsertMediaScreen()
    func displayRoutingContextUI(_ viewModel: OnGoingProjectDetails.Info.ViewModel.RoutingContext)
}

class OnGoingProjectDetailsController: BaseViewController, UINavigationControllerDelegate {
    
    private lazy var editProgressView: WCEditProgressView = {
        let view = WCEditProgressView(frame: .zero,
                                    delegate: self)
        return view
    }()
    
    private lazy var editProgressTranslucentView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(rgb: 0xededed).withAlphaComponent(0.5)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                         action: #selector(cancelEditProgress)))
        view.isHidden = true
        return view
    }()
    
    private lazy var confirmationModalView: ConfirmationAlertView = {
        let view = ConfirmationAlertView(frame: .zero,
                                         delegate: self,
                                         text: .empty)
        return view
    }()
    
    private lazy var translucentView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(rgb: 0xededed).withAlphaComponent(0.8)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeModal)))
        view.isHidden = true
        return view
    }()
    
    private lazy var progressButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapProgress), for: .touchUpInside)
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
    
    private lazy var projectImageView: WCRelevantItemImageView = {
        let view = WCRelevantItemImageView(frame: .zero)
        view.imageType = .url
        view.delegate = self
        return view
    }()
    
    private lazy var inviteContactsButton: WCPrimaryActionButton = {
        let view = WCPrimaryActionButton(frame: .zero)
        view.layout = .small
        view.text = OnGoingProjectDetails.Constants.Texts.inviteContactsButton
        view.addTarget(self, action: #selector(didTapInvite), for: .touchUpInside)
        return view
    }()
    
    private lazy var interactionButton: WCPrimaryActionButton = {
        let view = WCPrimaryActionButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapInteraction), for: .touchUpInside)
        return view
    }()
    
    private lazy var projectTitleDescriptionEditableView: WCTitleDescriptionEditableView = {
        let view = WCTitleDescriptionEditableView(frame: .zero)
        view.delegate = self
        return view
    }()
    
    private lazy var projectNeedingBulletEditableView: WCBulletEditableItemView = {
        let view = WCBulletEditableItemView(frame: .zero)
        view.delegate = self
        return view
    }()
    
    private lazy var mainView: OnGoingProjectDetailsView = {
        let view = OnGoingProjectDetailsView(frame: .zero,
                                             editProgressView: editProgressView,
                                             editProgressTranslucentView: editProgressTranslucentView,
                                             confirmationModalView: confirmationModalView,
                                             translucentView: translucentView,
                                             teamCollectionView: teamCollectionView,
                                             progressButton: progressButton,
                                             projectImageView: projectImageView,
                                             inviteContactsButton: inviteContactsButton,
                                             interactionButton: interactionButton,
                                             projectTitleDescriptionEditableView: projectTitleDescriptionEditableView,
                                             projectBulletNeedingEditableView: projectNeedingBulletEditableView)
        return view
    }()
    
    private let imagePicker = UIImagePickerController()
    
    private var viewModel: OnGoingProjectDetails.Info.ViewModel.Project? {
        didSet {
            DispatchQueue.main.async {
                self.projectTitleDescriptionEditableView.setup(title: self.viewModel?.title ?? .empty,
                                                               description: self.viewModel?.sinopsis ?? .empty)
                self.projectNeedingBulletEditableView.setup(headerText: OnGoingProjectDetails.Constants.Texts.needFixedLbl,
                                                            needingText: self.viewModel?.needing ?? .empty)
                self.teamCollectionView.reloadData()
            }
        }
    }
    
    private var interactor: OnGoingProjectDetailsBusinessLogic?
    var router: OnGoingProjectDetailsRouterProtocol?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        imagePicker.delegate = self
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.tabBarController?.tabBar.isHidden = true
        interactor?.fetchContext(OnGoingProjectDetails.Request.FetchContext())
        interactor?.fetchProjectRelation(OnGoingProjectDetails.Request.ProjectRelation())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.fetchProjectDetails(OnGoingProjectDetails.Request.FetchProject())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.tabBarController?.tabBar.isHidden = false
        hideConfirmationModal()
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    private func setup() {
        let viewController = self
        let presenter = OnGoingProjectDetailsPresenter(viewController: viewController)
        let interactor = OnGoingProjectDetailsInteractor(presenter: presenter)
        let router = OnGoingProjectDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.dataStore = interactor
        router.viewController = viewController
    }
    
    @objc
    private func closeModal() {
        mainView.hideConfirmationModal()
    }
    
    @objc
    private func didTapMoreInfo() {
        router?.routeToProjectParticipantsList()
    }
    
    @objc
    private func didTapInvite() {
        router?.routeToProjectInvites()
    }
    
    @objc
    private func didTapInteraction() {
        interactor?.fetchInteract(OnGoingProjectDetails.Request.FetchInteraction())
    }
    
    @objc
    private func didTapProgress() {
        interactor?.fetchProgressPercentage(OnGoingProjectDetails.Request.FetchProgress())
    }
    
    @objc
    private func cancelEditProgress() {
        mainView.hideEditProgressView()
    }
    
    private func resetEditableInfo() {
        projectNeedingBulletEditableView.state = .default
        projectTitleDescriptionEditableView.state = .default
    }
}

extension OnGoingProjectDetailsController: WCTitleDescriptionEditableViewDelegate {
    
    func didTapSave(title: String, description: String, titleDescriptionView: WCTitleDescriptionEditableView) {
        resetEditableInfo()
        interactor?.fetchUpdateProjectInfo(OnGoingProjectDetails.Request.UpdateInfo(title: title,
                                                                                    sinopsis: description))
    }
    
    func didTapCancel(titleDescriptionView: WCTitleDescriptionEditableView) {
        projectNeedingBulletEditableView.state = .default
    }
}

extension OnGoingProjectDetailsController: WCBulletEditableItemViewDelegate {
    
    func didTapSave(text: String, bulletEditableView: WCBulletEditableItemView) {
        resetEditableInfo()
        interactor?.fetchUpdateProjectNeeding(OnGoingProjectDetails.Request.UpdateNeeding(needing: text))
    }
    
    func didTapCancel(bulletEditableView: WCBulletEditableItemView) {
        projectTitleDescriptionEditableView.state = .default
    }
}

extension OnGoingProjectDetailsController: WCRelevantItemImageViewDelegate {
    
    func didTapImageView(imageView: WCRelevantItemImageView) {
        imagePicker.allowsEditing = true
        PHPhotoLibrary.requestAuthorization { newStatus in
            if newStatus == .authorized {
                DispatchQueue.main.async {
                    self.present(self.imagePicker, animated: true, completion: nil)
                }
            }
        }
    }
}

extension OnGoingProjectDetailsController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.teamMembers.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = teamCollectionView.dequeueReusableCell(indexPath: indexPath, type: TeamMemberCollectionViewCell.self)
        guard let viewModel = viewModel?.teamMembers else { return UICollectionViewCell() }
        cell.setup(name: viewModel[indexPath.row].name,
                   jobDescription: viewModel[indexPath.row].ocupation,
                   image: viewModel[indexPath.row].image)
        return cell
    }
}

extension OnGoingProjectDetailsController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor?.didSelectTeamMember(OnGoingProjectDetails.Request.SelectedTeamMember(index: indexPath.row))
    }
}

extension OnGoingProjectDetailsController: UICollectionViewDelegateFlowLayout {
    
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

extension OnGoingProjectDetailsController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            guard let imageData = image.jpegData(compressionQuality: 0.5) else {
                return
            }
            interactor?.fetchUpdateProjectImage(OnGoingProjectDetails.Request.UpdateImage(image: imageData))
        }
        self.dismiss(animated: true, completion: nil)
    }
}

extension OnGoingProjectDetailsController: WCEditProgressViewDelegate {
    
    func didConfirm(progress: Float) {
        interactor?.fetchUpdateProgress(OnGoingProjectDetails.Request.UpdateProgress(newProgress: progress))
    }
    
    func didClose() {
        mainView.hideEditProgressView()
    }
}

extension OnGoingProjectDetailsController: ConfirmationAlertViewDelegate {
    
    func didTapAccept() {
        interactor?.fetchConfirmInteraction(OnGoingProjectDetails.Request.ConfirmInteraction())
    }
    
    func didTapRefuse() {
        interactor?.fetchRefuseInteraction(OnGoingProjectDetails.Request.RefuseInteraction())
    }
}

extension OnGoingProjectDetailsController: OnGoingProjectDetailsDisplayLogic {
    
    func displayProjectDetails(_ viewModel: OnGoingProjectDetails.Info.ViewModel.Project) {
        self.viewModel = viewModel
        mainView.setup(viewModel: viewModel)
    }
    
    func displayError(_ viewModel: String) {
        UIAlertController.displayAlert(in: self, title: "Erro", message: viewModel)
    }

    func displayUIForRelation(_ viewModel: OnGoingProjectDetails.Info.ViewModel.RelationModel) {
        mainView.updateUI(forRelation: viewModel)
    }
    
    func displayFeedback(_ viewModel: OnGoingProjectDetails.Info.ViewModel.Feedback) {
        UIAlertController.displayAlert(in: self, title: viewModel.title, message: viewModel.message)
    }
    
    func displayUserDetails() {
        router?.routeToUserDetails()
    }
    
    func displayConfirmationModal(_ viewModel: OnGoingProjectDetails.Info.ViewModel.RelationModel) {
        mainView.displayConfirmationModal(forRelation: viewModel)
    }
    
    func hideConfirmationModal() {
        mainView.hideConfirmationModal()
    }
    
    func displayInteractionEffectivated() {
        mainView.hideConfirmationModal()
        interactor?.fetchProjectRelation(OnGoingProjectDetails.Request.ProjectRelation())
        interactor?.fetchProjectDetails(OnGoingProjectDetails.Request.FetchProject())
    }
    
    func displayRefusedInteraction() {
        mainView.hideConfirmationModal()
    }
    
    func displayEditProgressModal(_ viewModel: OnGoingProjectDetails.Info.ViewModel.Progress) {
        mainView.displayEditProgressView(withProgress: viewModel.percentage)
    }
    
    func hideEditProgressModal() {
        mainView.hideEditProgressView()
    }
    
    func displayConfirmFinishedProjectAlert() {
            UIAlertController.displayConfirmationDialog(in: self,
                                                        title: OnGoingProjectDetails.Constants.Texts.finishConfirmationTitle, message: OnGoingProjectDetails.Constants.Texts.finishConfirmationMessage, confirmationCallback: {
                                                            self.mainView.hideEditProgressView()
                                                        }, refuseCallback: {
                                                            self.interactor?.fetchConfirmNewProgress(OnGoingProjectDetails.Request.ConfirmProgress())
                                                            self.mainView.hideEditProgressView()
                                                        },  animated: true)
    }
    
    func displayInsertMediaScreen() {
        router?.routeToInsertMedia()
    }
    
    func displayRoutingContextUI(_ viewModel: OnGoingProjectDetails.Info.ViewModel.RoutingContext) {
        mainView.setupAuxiliarComponentsVisibility(backButtonVisible: viewModel.context != .justCreatedProject, closeButtonVisible: viewModel.context != .checkingProject)
        interactionButton.isHidden = viewModel.context == .justCreatedProject
    }
}
