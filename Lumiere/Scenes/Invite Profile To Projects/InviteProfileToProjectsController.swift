//
//  InviteProfileToProjectsController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 13/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

protocol InviteProfileToProjectsDisplayLogic: ViewInterface {
    func displayProjects(_ viewModel: InviteProfileToProjects.Info.ViewModel.UpcomingProjects)
    func displayRelationUpdate(_ viewModel: InviteProfileToProjects.Info.ViewModel.RelationUpdate)
    func displayConfirmationAlert(_ viewModel: InviteProfileToProjects.Info.ViewModel.Alert)
}

class InviteProfileToProjectsController: BaseViewController, HasNoTabBar {
    
    private lazy var searchTextField: WCDataTextField = {
        let view = WCDataTextField(frame: .zero)
        view.addTarget(self, action: #selector(didSearchChange), for: .editingChanged)
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.separatorStyle = .none
        view.bounces = false
        view.alwaysBounceVertical = false
        view.assignProtocols(to: self)
        view.registerCell(cellType: InviteProfileToProjectsTableViewCell.self)
        return view
    }()
    
    private lazy var mainView: InviteProfileToProjectsView = {
        let view = InviteProfileToProjectsView(frame: .zero,
                                               searchTextField: searchTextField,
                                               tableView: tableView)
        return view
    }()
    
    private var viewModel: InviteProfileToProjects.Info.ViewModel.UpcomingProjects? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.checkEmptyState(text: InviteProfileToProjects.Constants.Texts.emptyText,
                                               layout: .large)
            }
        }
    }
    
    private var interactor: InviteProfileToProjectsBusinessLogic?
    var router: InviteProfileToProjectsRouterProtocol?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.fetchProjects(InviteProfileToProjects.Request.FetchProjects())
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    private func setup() {
        let viewController = self
        let presenter = InviteProfileToProjectsPresenter(viewController: viewController)
        let interactor = InviteProfileToProjectsInteractor(presenter: presenter)
        let router = InviteProfileToProjectsRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.dataStore = interactor
        router.viewController = viewController
    }
    
    @objc
    private func didSearchChange() {
        interactor?.fetchSearchProject(InviteProfileToProjects
            .Request
            .SearchProject(preffix: searchTextField.text ?? .empty))
    }
}

extension InviteProfileToProjectsController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.projects.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath, type: InviteProfileToProjectsTableViewCell.self)
        guard let viewModel = viewModel?.projects[indexPath.row] else { return UITableViewCell() }
        cell.setup(delegate: self,
                   index: indexPath.row,
                   viewModel: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return InviteProfileToProjects.Constants.Dimensions.Heights.cellHeight
    }
}

extension InviteProfileToProjectsController: InviteProfileToProjectsTableViewCellDelegate {
    
    func didTapInteraction(index: Int) {
        interactor?.fetchInteraction(InviteProfileToProjects.Request.Interaction(index: index))
    }
}

extension InviteProfileToProjectsController: InviteProfileToProjectsDisplayLogic {
    
    func displayProjects(_ viewModel: InviteProfileToProjects.Info.ViewModel.UpcomingProjects) {
        self.viewModel = viewModel
    }
    
    func displayRelationUpdate(_ viewModel: InviteProfileToProjects.Info.ViewModel.RelationUpdate) {
        let cell = tableView.cellForRow(at: IndexPath(row: viewModel.index, section: 0), type: InviteProfileToProjectsTableViewCell.self)
        cell.updateRelation(relation: viewModel.relation)
    }
    
    func displayConfirmationAlert(_ viewModel: InviteProfileToProjects.Info.ViewModel.Alert) {
        WCDialogView().show(dialogType: .interaction(confirmText: WCConstants.Strings.yesAnswer, cancelText: WCConstants.Strings.noAnswer), in: self, description: viewModel.text, doneAction: {
            self.interactor?.fetchConfirmInteraction(InviteProfileToProjects.Request.ConfirmInteraction())
        }, cancelAction: {
            self.interactor?.fetchRefuseInteraction(InviteProfileToProjects.Request.RefuseInteraction())
        })
    }
}
