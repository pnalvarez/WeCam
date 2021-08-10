//
//  OnGoingProjectInvitesController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 12/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

protocol ProjectInvitesDisplayLogic: ViewInterface {
    func displayUsers(_ viewModel: ProjectInvites.Info.ViewModel.UpcomingUsers)
    func displayProjectInfo(_ viewModel: ProjectInvites.Info.ViewModel.Project)
    func displayConfirmationView(_ viewModel: ProjectInvites.Info.ViewModel.Alert)
    func displayProfileDetails()
    func displayRelationUpdate(_ viewModel: ProjectInvites.Info.ViewModel.RelationUpdate)
}

class ProjectInvitesController: BaseViewController {

    private lazy var searchTextField: WCDataTextField = {
        let view = WCDataTextField(frame: .zero)
        view.addTarget(self, action: #selector(didSearchTextFieldChange), for: .editingChanged)
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
                                      searchTextField: searchTextField,
                                      tableView: tableView)
        return view
    }()
    
    private var viewModel: ProjectInvites.Info.ViewModel.UpcomingUsers? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.checkEmptyState(text: ProjectInvites.Constants.Texts.emptyList,
                                          layout: .large)
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
    
    @objc
    private func didSearchTextFieldChange() {
        interactor?.fetchSearchUser(ProjectInvites
            .Request
            .Search(preffix: searchTextField.text ?? .empty))
    }
}

extension ProjectInvitesController: ProjectInvitesTableViewCellDelegate {
    
    func didTapInteraction(index: Int) {
        interactor?.fetchInteract(ProjectInvites.Request.Interaction(index: index))
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
        if let isEmpty = self.viewModel?.users.isEmpty, isEmpty {
            mainView.hideHeaderElements()
        }
    }
    
    func displayProjectInfo(_ viewModel: ProjectInvites.Info.ViewModel.Project) {
        mainView.setup(viewModel: viewModel)
    }
    
    func displayConfirmationView(_ viewModel: ProjectInvites.Info.ViewModel.Alert) {
        WCDialogView().show(dialogType: .interaction(confirmText: WCConstants.Strings.yesAnswer, cancelText: WCConstants.Strings.noAnswer), in: self, description: viewModel.text, doneAction: {
            self.interactor?.fetchConfirmInteraction(ProjectInvites.Request.ConfirmInteraction())
        }, cancelAction: {
            self.interactor?.fetchRefuseInteraction(ProjectInvites.Request.RefuseInteraction())
        })
    }
    
    func displayProfileDetails() {
        router?.routeToProfileDetails()
    }
    
    func displayRelationUpdate(_ viewModel: ProjectInvites.Info.ViewModel.RelationUpdate) {
        let cell = tableView.cellForRow(at: IndexPath(row: viewModel.index, section: 0), type: ProjectInvitesTableViewCell.self)
        cell.updateRelation(image: viewModel.relation)
    }
}
