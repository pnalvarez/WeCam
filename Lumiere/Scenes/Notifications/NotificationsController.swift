//
//  NotificationsController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

protocol NotificationsDisplayLogic: class {
    func displayLoading(_ loading: Bool)
    func displayError(_ viewModel: Notifications.Info.ViewModel.NotificationError)
    func displayNotifications(_ viewModel: Notifications.Info.ViewModel.UpcomingNotifications)
    func displaySelectedUser()
    func displayNotificationAnswer(_ viewModel: Notifications.Info.ViewModel.NotificationAnswer)
    func displayProjectDetails()
    func displayNotificationCriterias(_ viewModel: Notifications.Info.ViewModel.UpcomingNotificationCriterias)
}

class NotificationsController: BaseViewController {
    
    private lazy var refreshHeader: UIRefreshControl = {
        let view = UIRefreshControl(frame: .zero)
        view.backgroundColor = .clear
        view.tintColor = ThemeColors.mainRedColor.rawValue
        view.addTarget(self, action: #selector(refreshNotifications), for: .valueChanged)
        return view
    }()
    
    private lazy var criteriaSegmentedControl: UISegmentedControl = {
        let view = UISegmentedControl(frame: .zero)
        view.tintColor = Notifications.Constants.Colors.criteriaSegmentedControlUnselected
        view.selectedSegmentTintColor = Notifications.Constants.Colors.criteriaSegmentedControlSelected
        view.addTarget(self, action: #selector(didChangeSelectedCriteria), for: .valueChanged)
        view.layer.cornerRadius = 8
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
                                     criteriaSegmentedControl: criteriaSegmentedControl,
                                     tableView: tableView)
        return view
    }()
    
    private var interactor: NotificationsBusinessLogic?
    var router: NotificationsRouterProtocol?
    
    private var viewModel: Notifications.Info.ViewModel.UpcomingNotifications?
    
    private var isRequestType: Bool {
        return criteriaSegmentedControl.selectedSegmentIndex == Notifications.Constants.BusinessLogic.SegmentedControlIndexes.request
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
        interactor?.fetchNotificationCriterias(Notifications.Request.NotificationCriterias())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.fetchNotifications()
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    private func setup() {
        let viewController = self
        let presenter = NotificationsPresenter(viewController: viewController)
        let interactor = NotificationsInteractor(presenter: presenter)
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
    
    @objc
    private func didChangeSelectedCriteria() {
        tableView.bounces = !tableView.bounces
        refreshTableView()
    }
}

extension NotificationsController {
    
    private func setupTableView() {
        tableView.assignProtocols(to: self)
        tableView.registerCell(cellType: NotificationTableViewCell.self)
    }
    
    private func refreshTableView() {
        if criteriaSegmentedControl.selectedSegmentIndex == Notifications.Constants.BusinessLogic.SegmentedControlIndexes.request {
            tableView.backgroundView = (viewModel?.defaultNotifications.isEmpty ?? true) ? WCEmptyListView(frame: .zero,
                                                                                       text: Notifications.Constants.Texts.emptyNotifications) : nil
        } else if criteriaSegmentedControl.selectedSegmentIndex == Notifications.Constants.BusinessLogic.SegmentedControlIndexes.acceptance {
            tableView.backgroundView = (viewModel?.acceptNotifications.isEmpty ?? true) ? WCEmptyListView(frame: .zero,
                                                                                       text: Notifications.Constants.Texts.emptyHistory) : nil
        }
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
        if criteriaSegmentedControl.selectedSegmentIndex == Notifications.Constants.BusinessLogic.SegmentedControlIndexes.request {
            return viewModel?.defaultNotifications.count ?? 0
        } else {
            return viewModel?.acceptNotifications.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath, type: NotificationTableViewCell.self)
        if criteriaSegmentedControl.selectedSegmentIndex == Notifications.Constants.BusinessLogic.SegmentedControlIndexes.request {
            cell.setup(viewModel: viewModel?.defaultNotifications[indexPath.row],
                       index: indexPath.row,
                       delegate: self,
                       choosable: true)
        } else {
            cell.setup(acceptViewModel: viewModel?.acceptNotifications[indexPath.row],
                       index: indexPath.row,
                       delegate: self,
                       choosable: false)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isRequestType {
            return Notifications.Constants.Dimensions.Heights.notificationTableViewCellRequest
        } else {
            return Notifications.Constants.Dimensions.Heights.notificationTableViewCellAcceptance
        }
    }
}

extension NotificationsController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isRequestType {
            guard let enabled = viewModel?.defaultNotifications[indexPath.row].selectable, enabled else {
                return
            }
            interactor?.didSelectNotification(Notifications.Request.SelectProfile(index: indexPath.row))
        }
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
        self.viewModel = viewModel
        refreshTableView()
    }
    
    func displaySelectedUser() {
        router?.routeToProfileDetails()
    }
    
    func displayNotificationAnswer(_ viewModel: Notifications.Info.ViewModel.NotificationAnswer) {
        let cell = tableView.cellForRow(at: IndexPath(row: viewModel.index, section: 0),
                                        type: NotificationTableViewCell.self)
        cell.displayAnswer(viewModel.text)
        self.viewModel?.defaultNotifications[viewModel.index].selectable = false
    }
    
    func displayProjectDetails() {
        router?.routeToProjectDetails()
    }
    
    func displayNotificationCriterias(_ viewModel: Notifications.Info.ViewModel.UpcomingNotificationCriterias) {
        for i in 0..<viewModel.criterias.count {
            criteriaSegmentedControl.insertSegment(withTitle: viewModel.criterias[i].criteria, at: i, animated: false)
        }
        criteriaSegmentedControl.selectedSegmentIndex = 0
    }
}
