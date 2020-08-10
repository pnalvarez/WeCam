//
//  ConnectionsListController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 09/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

protocol ConnectionsListDisplayLogic: class {
    func displayCurrentUser(_ viewModel: ConnectionsList.Info.ViewModel.CurrentUser)
    func displayConnections(_ viewModel: ConnectionsList.Info.ViewModel.UpcomingConnections)
    func displayLoading(_ loading: Bool)
    func displayProfileDetails()
}

class ConnectionsListController: BaseViewController {
    
    private lazy var activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.backgroundColor = .white
        view.color = .black
        view.startAnimating()
        view.isHidden = true
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.bounces = false
        view.alwaysBounceVertical = false
        view.backgroundColor = .white
        view.separatorStyle = .none
        view.assignProtocols(to: self)
        view.registerCell(cellType: ConnectionsListTableViewCell.self)
        return view
    }()
    
    private lazy var mainView: ConnectionsListView = {
        let view = ConnectionsListView(frame: .zero,
                                       activityView: activityView,
                                       tableView: tableView)
        return view
    }()
    
    private var connectionsViewModel: ConnectionsList.Info.ViewModel.UpcomingConnections? {
        didSet {
            refreshList()
        }
    }
    
    private var interactor: ConnectionsListBusinessLogic?
    var router: ConnectionsListRouterProtocol?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        interactor?.fetchUserDetails(ConnectionsList.Request.FetchUserDetails())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactor?.fetchConnectionList(ConnectionsList.Request.FetchConnections())
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    private func setup() {
        let viewController = self
        let interactor = ConnectionsListInteractor(viewController: viewController)
        let router = ConnectionsListRouter()
        viewController.router = router
        viewController.interactor = interactor
        router.dataStore = interactor
        router.viewController = viewController
    }
}

extension ConnectionsListController: ConnectionsListTableViewCellDelegate {
    
    func didTapRemoveButton(index: Int?) {
        guard let index = index else { return }
        interactor?.fetchRemoveConnection(ConnectionsList.Request.FetchRemoveConnection(index: index))
    }
}

extension ConnectionsListController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return connectionsViewModel?.connections.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath,
                                                 type: ConnectionsListTableViewCell.self)
        guard let viewModel = connectionsViewModel?.connections[indexPath.row] else {
            return UITableViewCell()
        }
        cell.setup(index: indexPath.row,
                   viewModel: viewModel)
        return cell
    }
}

extension ConnectionsListController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ConnectionsListController {

    private func refreshList() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ConnectionsListController: ConnectionsListDisplayLogic {
    
    func displayCurrentUser(_ viewModel: ConnectionsList.Info.ViewModel.CurrentUser) {
        mainView.setup(viewModel: viewModel)
    }
    
    func displayConnections(_ viewModel: ConnectionsList.Info.ViewModel.UpcomingConnections) {
        self.connectionsViewModel = viewModel
    }
    
    func displayLoading(_ loading: Bool) {
        activityView.isHidden = !loading
    }
    
    func displayProfileDetails() {
        
    }
}
