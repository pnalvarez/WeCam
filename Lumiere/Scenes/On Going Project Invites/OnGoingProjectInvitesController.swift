//
//  OnGoingProjectInvitesController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 12/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol OnGoingProjectInvitesDisplayLogic: class {
    func displayUsers(_ viewModel: OnGoingProjectInvites.Info.ViewModel.UpcomingUsers)
    func displayProjectInfo(_ viewModel: OnGoingProjectInvites.Info.ViewModel.Project)
    func displayConfirmationView(_ viewModel: OnGoingProjectInvites.Info.ViewModel.Alert)
    func hideConfirmationView()
    func displayLoading(_ loading: Bool)
    func displayProfileDetails()
    func displayError(_ viewModel: OnGoingProjectInvites.Info.ViewModel.ErrorViewModel)
    func displayRelationUpdate(_ viewModel: OnGoingProjectInvites.Info.ViewModel.RelationUpdate)
}

class OnGoingProjectInvitesController: BaseViewController {
    
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
        view.isHidden = true
        return view
    }()
    
    private lazy var closeButton: DefaultCloseButton = {
        let view = DefaultCloseButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        return view
    }()
    
    private lazy var searchTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.layer.cornerRadius = 4
        view.addTarget(self, action: #selector(didSearchTextFieldChange), for: .editingChanged)
        view.textAlignment = .left
        view.font = OnGoingProjectInvites.Constants.Fonts.searchTextField
        view.textColor = OnGoingProjectInvites.Constants.Colors.searchTextFieldText
        view.layer.borderWidth = 1
        view.layer.borderColor = OnGoingProjectInvites.Constants.Colors.searchTextFieldLayer
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.assignProtocols(to: self)
        view.bounces = false
        view.alwaysBounceVertical = false
        view.registerCell(cellType: OnGoingProjectInvitesTableViewCell.self)
        view.separatorStyle = .none
        return view
    }()
    
    private lazy var mainView: OnGoingProjectInvitesView = {
        let view = OnGoingProjectInvitesView(frame: .zero,
                                             activityView: activityView,
                                             modalAlertView: modalAlertView,
                                             translucentView: translucentView,
                                             closeButton: closeButton,
                                             searchTextField: searchTextField,
                                             tableView: tableView)
        return view
    }()
    
    private var viewModel: OnGoingProjectInvites.Info.ViewModel.UpcomingUsers? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private var interactor: OnGoingProjectInvitesBusinessLogic?
    var router: OnGoingProjectInvitesRouterProtocol?
    
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
        interactor?.fetchUsers(OnGoingProjectInvites.Request.FetchUsers())
        interactor?.fetchProject(OnGoingProjectInvites.Request.FetchProject())
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    private func setup() {
        let viewController = self
        let presenter = OnGoingProjectInvitesPresenter(viewController: viewController)
        let interactor = OnGoingProjectInvitesInteractor(presenter: presenter)
        let router = OnGoingProjectInvitesRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.dataStore = interactor
        router.viewController = viewController
    }
}

extension OnGoingProjectInvitesController {
    
    @objc
    private func didTapClose() {
        router?.routeBack()
    }
    
    @objc
    private func didSearchTextFieldChange() {
        interactor?.fetchSearchUser(OnGoingProjectInvites
            .Request
            .Search(preffix: searchTextField.text ?? .empty))
    }
}

extension OnGoingProjectInvitesController: OnGoingProjectInvitesTableViewCellDelegate {
    
    func didTapInteraction(index: Int) {
        interactor?.fetchInteract(OnGoingProjectInvites.Request.Interaction(index: index))
    }
}

extension OnGoingProjectInvitesController: ConfirmationAlertViewDelegate {
    
    func didTapAccept() {
        interactor?.fetchConfirmInteraction(OnGoingProjectInvites.Request.ConfirmInteraction())
    }
    
    func didTapRefuse() {
        interactor?.fetchRefuseInteraction(OnGoingProjectInvites.Request.RefuseInteraction())
    }
}

extension OnGoingProjectInvitesController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.didSelectUser(OnGoingProjectInvites.Request.SelectUser(index: indexPath.row))
    }
}

extension OnGoingProjectInvitesController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.users.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath, type: OnGoingProjectInvitesTableViewCell.self)
        guard let viewModel = viewModel?.users[indexPath.row] else { return UITableViewCell() }
        cell.setup(delegate: self, index: indexPath.row, viewModel: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return OnGoingProjectInvites.Constants.Dimensions.Heights.cellHeight
    }
}

extension OnGoingProjectInvitesController: OnGoingProjectInvitesDisplayLogic {
    
    func displayUsers(_ viewModel: OnGoingProjectInvites.Info.ViewModel.UpcomingUsers) {
        self.viewModel = viewModel
    }
    
    func displayProjectInfo(_ viewModel: OnGoingProjectInvites.Info.ViewModel.Project) {
        mainView.setup(viewModel: viewModel)
    }
    
    func displayConfirmationView(_ viewModel: OnGoingProjectInvites.Info.ViewModel.Alert) {
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
    
    func displayError(_ viewModel: OnGoingProjectInvites.Info.ViewModel.ErrorViewModel) {
        UIAlertController.displayAlert(in: self, title: viewModel.title, message: viewModel.message)
    }
    
    func displayRelationUpdate(_ viewModel: OnGoingProjectInvites.Info.ViewModel.RelationUpdate) {
        let cell = tableView.cellForRow(at: IndexPath(row: viewModel.index, section: 0), type: OnGoingProjectInvitesTableViewCell.self)
        cell.updateRelation(image: viewModel.relation)
    }
}
