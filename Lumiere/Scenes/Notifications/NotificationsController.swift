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
    func displayNotifications(_ viewModel: Notifications.Info.ViewModel.UpcomingNotifications)
    func displaySelectedUser()
    func displayNotificationAnswer(_ viewModel: Notifications.Info.ViewModel.NotificationAnswer)
    func displayProjectDetails()
}

class NotificationsController: BaseViewController {
    
    private lazy var refreshHeader: UIRefreshControl = {
        let view = UIRefreshControl(frame: .zero)
        view.backgroundColor = .clear
        view.tintColor = ThemeColors.mainRedColor.rawValue
        view.addTarget(self, action: #selector(refreshNotifications), for: .valueChanged)
        return view
    }()
    
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
        view.refreshControl = refreshHeader
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
        setupTableView()
        refreshTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
    
    @objc
    private func refreshNotifications() {
        interactor?.fetchRefreshNotifications(Notifications.Request.RefreshNotifications())
    }
}

extension NotificationsController {
    
    private func setupTableView() {
        tableView.assignProtocols(to: self)
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
        interactor?.didAcceptNotification(Notifications.Request.NotificationAnswer(index: index))
    }
    
    func didTapNoButton(index: Int) {
        interactor?.didRefuseNotification(Notifications.Request.NotificationAnswer(index: index))
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
        interactor?.didSelectNotification(Notifications.Request.SelectProfile(index: indexPath.row))
    }
}

extension  NotificationsController: NotificationsDisplayLogic {
    
    func displayLoading(_ loading: Bool) {
        activityView.isHidden = !loading
        tableView.backgroundView = nil
    }
    
    func displayError(_ viewModel: Notifications.Info.ViewModel.NotificationError) {
        UIAlertController.displayAlert(in: self, title: "Erro", message: viewModel.description)
    }
    
    func displayNotifications(_ viewModel: Notifications.Info.ViewModel.UpcomingNotifications) {
        refreshHeader.endRefreshing()
        tableView.backgroundView = viewModel.notifications.isEmpty ? EmptyListView(frame: .zero,
                                                                                   text: Notifications.Constants.Texts.emptyNotifications) : nil
        self.viewModel = viewModel
    }
    
    func displaySelectedUser() {
        router?.routeToProfileDetails()
    }
    
    func displayNotificationAnswer(_ viewModel: Notifications.Info.ViewModel.NotificationAnswer) {
        let cell = tableView.cellForRow(at: IndexPath(row: viewModel.index, section: 0),
                                        type: NotificationTableViewCell.self)
        cell.displayAnswer(viewModel.text)
    }
    
    func displayProjectDetails() {
        router?.routeToProjectDetails()
    }
}
