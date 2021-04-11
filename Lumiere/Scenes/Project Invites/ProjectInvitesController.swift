//
//  OnGoingProjectInvitesController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 12/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

protocol ProjectInvitesDisplayLogic: class {
    func displayUsers(_ viewModel: ProjectInvites.Info.ViewModel.UpcomingUsers)
    func displayProjectInfo(_ viewModel: ProjectInvites.Info.ViewModel.Project)
    func displayConfirmationView(_ viewModel: ProjectInvites.Info.ViewModel.Alert)
    func hideConfirmationView()
    func displayLoading(_ loading: Bool)
    func displayProfileDetails()
    func displayError(_ viewModel: ProjectInvites.Info.ViewModel.ErrorViewModel)
    func displayRelationUpdate(_ viewModel: ProjectInvites.Info.ViewModel.RelationUpdate)
}

class ProjectInvitesController: BaseViewController {
    
    private lazy var activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.startAnimating()
        view.color = ThemeColors.mainRedColor.rawValue
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var modalAlertView: ConfirmationAlertView = {
        let view = ConfirmationAlertView(frame: .zero,
                                         delegate: self,
                                         text: .empty)
        return view
    }()
    
    private lazy var translucentView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapTranslucentView)))
        view.isHidden = true
        return view
    }()
    
    private lazy var searchTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.layer.cornerRadius = 4
        view.addTarget(self, action: #selector(didSearchTextFieldChange), for: .editingChanged)
        view.textAlignment = .left
        view.font = ProjectInvites.Constants.Fonts.searchTextField
        view.textColor = ProjectInvites.Constants.Colors.searchTextFieldText
        view.layer.borderWidth = 1
        view.layer.borderColor = ProjectInvites.Constants.Colors.searchTextFieldLayer
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.assignProtocols(to: self)
        view.bounces = false
        view.alwaysBounceVertical = false
        view.registerCell(cellType: ProjectInvitesTableViewCell.self)
        view.separatorStyle = .none
        return view
    }()
    
    private lazy var mainView: ProjectInvitesView = {
        let view = ProjectInvitesView(frame: .zero,
                                      activityView: activityView,
                                      modalAlertView: modalAlertView,
                                      translucentView: translucentView,
                                      backButton: backButton,
                                      searchTextField: searchTextField,
                                      tableView: tableView)
        return view
    }()
    
    private var viewModel: ProjectInvites.Info.ViewModel.UpcomingUsers? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private var interactor: ProjectInvitesBusinessLogic?
    var router: ProjectInvitesRouterProtocol?
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.fetchUsers(ProjectInvites.Request.FetchUsers())
        interactor?.fetchProject(ProjectInvites.Request.FetchProject())
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    private func setup() {
        let viewController = self
        let presenter = ProjectInvitesPresenter(viewController: viewController)
        let interactor = ProjectInvitesInteractor(presenter: presenter)
        let router = ProjectInvitesRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.dataStore = interactor
        router.viewController = viewController
    }
}

extension ProjectInvitesController {
    
    @objc
    private func didTapClose() {
        router?.routeBack()
    }
    
    @objc
    private func didSearchTextFieldChange() {
        interactor?.fetchSearchUser(ProjectInvites
            .Request
            .Search(preffix: searchTextField.text ?? .empty))
    }
    
    @objc
    private func didTapTranslucentView() {
        mainView.hideConfirmationView()
    }
}

extension ProjectInvitesController: ProjectInvitesTableViewCellDelegate {
    
    func didTapInteraction(index: Int) {
        interactor?.fetchInteract(ProjectInvites.Request.Interaction(index: index))
    }
}

extension ProjectInvitesController: ConfirmationAlertViewDelegate {
    
    func didTapAccept() {
        interactor?.fetchConfirmInteraction(ProjectInvites.Request.ConfirmInteraction())
    }
    
    func didTapRefuse() {
        interactor?.fetchRefuseInteraction(ProjectInvites.Request.RefuseInteraction())
    }
}

extension ProjectInvitesController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.didSelectUser(ProjectInvites.Request.SelectUser(index: indexPath.row))
    }
}

extension ProjectInvitesController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.users.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath, type: ProjectInvitesTableViewCell.self)
        guard let viewModel = viewModel?.users[indexPath.row] else { return UITableViewCell() }
        cell.setup(delegate: self, index: indexPath.row, viewModel: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ProjectInvites.Constants.Dimensions.Heights.cellHeight
    }
}

extension ProjectInvitesController: ProjectInvitesDisplayLogic {
    
    func displayUsers(_ viewModel: ProjectInvites.Info.ViewModel.UpcomingUsers) {
        self.viewModel = viewModel
    }
    
    func displayProjectInfo(_ viewModel: ProjectInvites.Info.ViewModel.Project) {
        mainView.setup(viewModel: viewModel)
    }
    
    func displayConfirmationView(_ viewModel: ProjectInvites.Info.ViewModel.Alert) {
        mainView.displayConfirmationView(withText: viewModel.text)
    }
    
    func hideConfirmationView() {
        mainView.hideConfirmationView()
    }
    
    func displayLoading(_ loading: Bool) {
        activityView.isHidden = !loading
    }
    
    func displayProfileDetails() {
        router?.routeToProfileDetails()
    }
    
    func displayError(_ viewModel: ProjectInvites.Info.ViewModel.ErrorViewModel) {
        UIAlertController.displayAlert(in: self, title: viewModel.title, message: viewModel.message)
    }
    
    func displayRelationUpdate(_ viewModel: ProjectInvites.Info.ViewModel.RelationUpdate) {
        let cell = tableView.cellForRow(at: IndexPath(row: viewModel.index, section: 0), type: ProjectInvitesTableViewCell.self)
        cell.updateRelation(image: viewModel.relation)
    }
}
