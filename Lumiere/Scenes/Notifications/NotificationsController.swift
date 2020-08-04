//
//  NotificationsController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol NotificationsDisplayLogic: class {
    func displayLoading(_ loading: Bool)
    func displayError(_ viewModel: Notifications.Info.ViewModel.NotificationError)
    func displayNotificationns(_ viewModel: Notifications.Info.ViewModel.UpcomingNotifications)
}

class NotificationsController: BaseViewController {
    
    private lazy var activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.backgroundColor = Notifications.Constants.Colors.activityBackground
        view.color = Notifications.Constants.Colors.activity
        view.startAnimating()
        view.isHidden = true
        return view
    }()
    
    private lazy var tableView: NotificationsTableView = {
        let view = NotificationsTableView(frame: .zero)
        view.assignProtocols(to: self)
        return view
    }()
    
    private lazy var mainView: NotificationsView = {
        let view = NotificationsView(frame: .zero,
                                     activityView: activityView,
                                     tableView: tableView)
        return view
    }()
    
    private var interactor: NotificationsBusinessLogic?
    var router: NotificationsRouterProtocol?
    
    private var viewModel: Notifications.Info.ViewModel.UpcomingNotifications? {
        didSet {
            refreshTableView()
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        interactor?.fetchNotifications()
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    private func setup() {
        let viewController = self
        let interactor = NotificationsInteractor(viewController: viewController)
        let router = NotificationsRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.dataStore = interactor
        router.viewController = viewController
    }
}

extension NotificationsController {
    
    private func registerCells() {
        tableView.registerCell(cellType: NotificationTableViewCell.self)
    }
    
    private func refreshTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension NotificationsController: NotificationTableViewCellDelegate {
    
    func didTapYesButton(index: Int) {
        
    }
    
    func didTapNoButton(index: Int) {
        
    }
}

extension NotificationsController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.notifications.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath, type: NotificationTableViewCell.self)
        cell.setup(viewModel: viewModel?.notifications[indexPath.row],
                   index: indexPath.row,
                   delegate: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Notifications.Constants.Dimensions.Heights.notificationTableViewCell
    }
}

extension NotificationsController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension  NotificationsController: NotificationsDisplayLogic {
    
    func displayLoading(_ loading: Bool) {
        activityView.isHidden = !loading
    }
    
    func displayError(_ viewModel: Notifications.Info.ViewModel.NotificationError) {
        let alertController = UIAlertController(title: "Erro",
                                                message: viewModel.description,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func displayNotificationns(_ viewModel: Notifications.Info.ViewModel.UpcomingNotifications) {
        self.viewModel = viewModel
    }
}
