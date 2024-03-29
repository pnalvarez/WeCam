//
//  OnGoingProjectDetailsController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 22/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import Photos

protocol OnGoingProjectDetailsDisplayLogic: class {
    func displayProjectDetails(_ viewModel: OnGoingProjectDetails.Info.ViewModel.Project)
    func displayError(_ viewModel: String)
    func displayLoading(_ loading: Bool)
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
    
    private lazy var editProgressView: EditProgressView = {
        let view = EditProgressView(frame: .zero,
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
    
    private lazy var titleTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.textAlignment = .center
        view.textColor = OnGoingProjectDetails.Constants.Colors.titleLbl
        view.font = OnGoingProjectDetails.Constants.Fonts.titleLbl
        view.layer.borderWidth = 0
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private lazy var sinopsisTextView: UITextView = {
        let view = UITextView(frame: .zero)
        view.textAlignment = .center
        view.textColor = OnGoingProjectDetails.Constants.Colors.sinopsisLbl
        view.font = OnGoingProjectDetails.Constants.Fonts.sinopsisLbl
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = true
        view.sizeToFit()
        view.isScrollEnabled = false
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
        view.setAttributedTitle(NSAttributedString(string: OnGoingProjectDetails.Constants.Texts.moreInfoButton,
                                                   attributes: [NSAttributedString.Key.foregroundColor: OnGoingProjectDetails.Constants.Colors.moreInfoButtonText, NSAttributedString.Key.font: OnGoingProjectDetails.Constants.Fonts.moreInfoButton, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]), for: .normal)
        return view
    }()
    
    private lazy var editButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapEditInfo), for: .touchUpInside)
        view.setTitle(OnGoingProjectDetails.Constants.Texts.editButton, for: .normal)
        view.setTitleColor(OnGoingProjectDetails.Constants.Colors.editButtonText, for: .normal)
        view.titleLabel?.font = OnGoingProjectDetails.Constants.Fonts.editButton
        view.backgroundColor = OnGoingProjectDetails.Constants.Colors.editButtonBackground
        view.layer.borderWidth = 1
        view.layer.borderColor = OnGoingProjectDetails.Constants.Colors.editButtonLayer
        view.layer.cornerRadius = 4
        return view
    }()
    
    private lazy var cancelEditingDetailsButton: DefaultCloseButton = {
        let view = DefaultCloseButton(frame: .zero)
        view.addTarget(self,
                       action: #selector(didTapCancelEditing),
                       for: .touchUpInside)
        view.isHidden = true
        return view
    }()
    
    private lazy var cancelEditingNeedingButton: DefaultCloseButton = {
        let view = DefaultCloseButton(frame: .zero)
        view.addTarget(self,
                       action: #selector(didTapCancelEditing),
                       for: .touchUpInside)
        view.isHidden = true
        return view
    }()
    
    private lazy var imageButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.imageView?.contentMode = .scaleToFill
        view.clipsToBounds = true
        view.addTarget(self, action: #selector(didTapImageButton), for: .touchUpInside)
        view.layer.cornerRadius = 41
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    private lazy var inviteContactsButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapInvite), for: .touchUpInside)
        view.setTitle(OnGoingProjectDetails.Constants.Texts.inviteContactsButton, for: .normal)
        view.setTitleColor(OnGoingProjectDetails.Constants.Colors.inviteContactsButtonText, for: .normal)
        view.titleLabel?.font = OnGoingProjectDetails.Constants.Fonts.inviteContactsButton
        view.backgroundColor = OnGoingProjectDetails.Constants.Colors.inviteContactsButtonBackground
        view.layer.cornerRadius = 4
        return view
    }()
    
    private lazy var editNeedingButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapEditNeeding), for: .touchUpInside)
        view.setTitle(OnGoingProjectDetails.Constants.Texts.editButton, for: .normal)
        view.setTitleColor(OnGoingProjectDetails.Constants.Colors.editButtonText, for: .normal)
        view.titleLabel?.font = OnGoingProjectDetails.Constants.Fonts.editButton
        view.backgroundColor = OnGoingProjectDetails.Constants.Colors.editButtonBackground
        view.layer.borderWidth = 1
        view.layer.borderColor = OnGoingProjectDetails.Constants.Colors.editButtonLayer
        view.layer.cornerRadius = 4
        return view
    }()
    
    private lazy var interactionButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapInteraction), for: .touchUpInside)
        view.setTitleColor(OnGoingProjectDetails.Constants.Colors.interactionButtonText, for: .normal)
        view.titleLabel?.font = OnGoingProjectDetails.Constants.Fonts.interactionButton
        view.titleLabel?.adjustsFontSizeToFitWidth = true
        view.layer.cornerRadius = 4
        view.backgroundColor = OnGoingProjectDetails.Constants.Colors.interactionButtonBackground
        return view
    }()
    
    private lazy var needValueTextfield: UITextField = {
        let view = UITextField(frame: .zero)
        view.textColor = OnGoingProjectDetails.Constants.Colors.needValueLbl
        view.font = OnGoingProjectDetails.Constants.Fonts.needValueLbl
        view.textAlignment = .left
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private lazy var activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.color = .black
        view.backgroundColor = .white
        view.startAnimating()
        view.isHidden = true
        return view
    }()
    
    private lazy var mainView: OnGoingProjectDetailsView = {
        let view = OnGoingProjectDetailsView(frame: .zero,
                                             backButton: backButton,
                                             editProgressView: editProgressView,
                                             editProgressTranslucentView: editProgressTranslucentView,
                                             titleTextField: titleTextField,
                                             sinopsisTextView: sinopsisTextView,
                                             confirmationModalView: confirmationModalView,
                                             translucentView: translucentView,
                                             closeButton: closeButton,
                                             teamCollectionView: teamCollectionView,
                                             moreInfoButton: moreInfoButton,
                                             progressButton: progressButton,
                                             imageButton: imageButton,
                                             inviteContactsButton: inviteContactsButton,
                                             editButton: editButton,
                                             cancelEditingDetailsButton: cancelEditingDetailsButton,
                                             interactionButton: interactionButton,
                                             editNeedingButton: editNeedingButton,
                                             cancelEditingNeedingButton: cancelEditingNeedingButton,
                                             needValueTextfield: needValueTextfield,
                                             activityView: activityView)
        return view
    }()
    
    private let imagePicker = UIImagePickerController()
    
    private var viewModel: OnGoingProjectDetails.Info.ViewModel.Project? {
        didSet {
            DispatchQueue.main.async {
                self.teamCollectionView.reloadData()
            }
        }
    }
    
    private var editingDetails = false {
        didSet {
            if editingDetails {
                editButton.setTitle(OnGoingProjectDetails.Constants.Texts.editConclude,
                                    for: .normal)
                editButton.setTitleColor(OnGoingProjectDetails.Constants.Colors.editConcludeText, for: .normal)
                editButton.backgroundColor = OnGoingProjectDetails.Constants.Colors.editConclude
            } else {
                editButton.setTitle(OnGoingProjectDetails.Constants.Texts.editButton,
                                    for: .normal)
                editButton.setTitleColor(OnGoingProjectDetails.Constants.Colors.editButtonText, for: .normal)
                editButton.backgroundColor = OnGoingProjectDetails.Constants.Colors.editButtonBackground
            }
            titleTextField.isUserInteractionEnabled = editingDetails
            sinopsisTextView.isUserInteractionEnabled = editingDetails
            editNeedingButton.isHidden = editingDetails
            cancelEditingDetailsButton.isHidden = !editingDetails
        }
    }
    private var editingNeeding = false {
        didSet {
            if editingNeeding {
                editNeedingButton.setTitle(OnGoingProjectDetails.Constants.Texts.editConclude, for: .normal)
                editNeedingButton.setTitleColor(OnGoingProjectDetails.Constants.Colors.editConcludeText, for: .normal)
                editNeedingButton.backgroundColor = OnGoingProjectDetails.Constants.Colors.editConclude
            } else {
                editNeedingButton.setTitle(OnGoingProjectDetails.Constants.Texts.editButton,
                                    for: .normal)
                editNeedingButton.setTitleColor(OnGoingProjectDetails.Constants.Colors.editButtonText, for: .normal)
                editNeedingButton.backgroundColor = OnGoingProjectDetails.Constants.Colors.editButtonBackground
            }
            needValueTextfield.isUserInteractionEnabled = editingNeeding
            editButton.isHidden = editingNeeding
            cancelEditingNeedingButton.isHidden = !editingNeeding
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
        navigationController?.isNavigationBarHidden = true
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
}

extension OnGoingProjectDetailsController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.teamMembers.count ?? 0 >= 4 ? 4 : viewModel?.teamMembers.count ?? 0
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

extension OnGoingProjectDetailsController {
    
    @objc
    private func closeModal() {
        mainView.hideConfirmationModal()
    }
    
    @objc
    private func didTapMoreInfo() {
        router?.routeToProjectParticipantsList()
    }
    
    @objc
    private func didTapImageButton() {
        imagePicker.allowsEditing = true
        PHPhotoLibrary.requestAuthorization { newStatus in
            if newStatus == .authorized {
                DispatchQueue.main.async {
                    self.present(self.imagePicker, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc
    private func didTapInvite() {
        router?.routeToProjectInvites()
    }
    
    @objc
    private func didTapEditInfo() {
        if editingDetails {
            interactor?.fetchUpdateProjectInfo(OnGoingProjectDetails.Request.UpdateInfo(title: titleTextField.text ?? .empty, sinopsis: sinopsisTextView.text ?? .empty))
            editingDetails = false
        } else {
            editingDetails = true
        }
    }
    
    @objc
    private func didTapCancelEditing(sender: UIButton) {
        interactor?.didCancelEditing(OnGoingProjectDetails
                                        .Request
                                        .CancelEditing())
        editingDetails = false
        editingNeeding = false
    }
    
    @objc
    private func didTapEditNeeding() {
        if editingNeeding {
            interactor?.fetchUpdateProjectNeeding(OnGoingProjectDetails.Request.UpdateNeeding(needing: needValueTextfield.text ?? .empty))
            editingNeeding = false
        } else {
            editingNeeding = true
        }
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
}

extension OnGoingProjectDetailsController: EditProgressViewDelegate {
    
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
    
    func displayLoading(_ loading: Bool) {
        activityView.isHidden = !loading
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
         backButton.isHidden = viewModel.context == .justCreatedProject
        closeButton.isHidden = viewModel.context == .checkingProject
    }
}
