//
//  ProjectParticipantsListController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 05/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

protocol ProjectParticipantsListDisplayLogic: ViewInterface {
    func displayParticipants(_ viewModel: ProjectParticipantsList.Info.ViewModel.UpcomingParticipants)
    func displayProfileDetails()
}

class ProjectParticipantsListController: BaseViewController {
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.bounces = false
        view.alwaysBounceVertical = false
        view.backgroundColor = .white
        view.separatorStyle = .none
        view.assignProtocols(to: self)
        view.registerCell(cellType: ProjectParticipantsListTableViewCell.self)
        return view
    }()
    
    private lazy var mainView: ProjectParticipantsListView = {
        let view = ProjectParticipantsListView(frame: .zero,
                                               tableView: tableView)
        return view
    }()
    
    private var viewModel: ProjectParticipantsList.Info.ViewModel.UpcomingParticipants?
    
    private var interactor: ProjectParticipantsListInteractor?
    var router: ProjectParticipantsListRouterProtocol?
    
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
        interactor?.fetchParticipants(ProjectParticipantsList.Request.FetchParticipants())
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    private func setup() {
        let viewController = self
        let presenter = ProjectParticipantsListPresenter(viewController: viewController)
        let interactor = ProjectParticipantsListInteractor(presenter: presenter)
        let router = ProjectParticipantsListRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.dataStore = interactor
        router.viewController = viewController
    }
}

extension ProjectParticipantsListController {
    
    @objc
    private func didTapClose() {
        router?.routeBack()
    }
}

extension ProjectParticipantsListController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.participants.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath, type: ProjectParticipantsListTableViewCell.self)
        guard let viewModel = self.viewModel?.participants[indexPath.row] else { return UITableViewCell() }
        cell.setup(viewModel: viewModel)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
}

extension ProjectParticipantsListController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.didSelectParticipant(ProjectParticipantsList.Request.SelectParticipant(index: indexPath.row))
    }
}

extension ProjectParticipantsListController: ProjectParticipantsListDisplayLogic {
    
    func displayParticipants(_ viewModel: ProjectParticipantsList.Info.ViewModel.UpcomingParticipants) {
        self.viewModel = viewModel
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func displayProfileDetails() {
        router?.routeToProfileDetails()
    }
}
