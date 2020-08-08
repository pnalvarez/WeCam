//
//  NotificationsInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import Foundation

protocol NotificationsBusinessLogic {
    func fetchNotifications()
    func updateNotifications()
    func didSelectProfile(_ request: Notifications.Request.SelectProfile)
    func didAcceptNotification(_ request: Notifications.Request.NotificationAnswer)
    func didRefuseNotification(_ request: Notifications.Request.NotificationAnswer)
}

protocol NotificationsDataStore {
    var currentUser: Notifications.Info.Received.CurrentUser? { get set }
    var notifications: Notifications.Info.Model.UpcomingNotifications? { get set }
    var selectedUser: Notifications.Info.Model.User? { get set }
}

class NotificationsInteractor: NotificationsDataStore {

    var presenter: NotificationsPresentationLogic
    var worker: NotificationsWorkerProtocol
    
    var currentUser: Notifications.Info.Received.CurrentUser?
    var notifications: Notifications.Info.Model.UpcomingNotifications?
    var selectedUser: Notifications.Info.Model.User?
    
    init(viewController: NotificationsDisplayLogic,
         worker: NotificationsWorkerProtocol = NotificationsWorker()) {
        self.presenter = NotificationsPresenter(viewController: viewController)
        self.worker = worker
    }
}

extension NotificationsInteractor {
    
    private func buildNotificationsModel(withData connections: [Notifications.Response.ConnectNotification]){
        var upcomingNotifications = [Notifications.Info.Model.Notification]()
        for notification in connections {
            upcomingNotifications.append(Notifications.Info.Model.Notification(type: .connection,
                                                                               userId: notification.userId ?? .empty,
                                                                               image: notification.image ?? .empty,
                                                                               name: notification.name ?? .empty,
                                                                               ocupation: notification.ocupation ?? .empty,
                                                                               email: notification.email ?? .empty))
        }
        self.notifications = Notifications.Info.Model.UpcomingNotifications(notifications: upcomingNotifications)
    }
    
    private func buildSelectedUser(withData data: Notifications.Response.User,
                                   userId: String) {
        selectedUser = Notifications.Info.Model.User(id: userId,
                                                     name: data.name ?? .empty,
                                                     email: data.email ?? .empty,
                                                     phoneNumber: data.phoneNumber ?? .empty,
                                                     image: data.image ?? .empty,
                                                     ocupation: data.ocupation ?? .empty,
                                                     connectionsCount: "\(data.connectionsCount ?? 0)")
    }
}

extension NotificationsInteractor: NotificationsBusinessLogic {
    
    func fetchNotifications() {
        presenter.presentLoading(true)
        guard let currentUserId = currentUser?.userId else { return }
        worker.fetchNotifications(Notifications.Request.FetchNotifications(userId: currentUserId)) { response in
            switch response {
            case .success(let data):
                self.buildNotificationsModel(withData: data)
                self.presenter.presentLoading(false)
                guard let notifications = self.notifications else { return }
                self.presenter.presentNotifications(notifications)
                break
            case .error(let error):
                self.presenter.presentLoading(false)
                self.presenter.presentError(error.localizedDescription)
                break
            }
        }
    }
    
    func updateNotifications() {
        
    }
    
    func didSelectProfile(_ request: Notifications.Request.SelectProfile) {
        guard let id = notifications?.notifications[request.index].userId else {
            return
        }
        let request = Notifications.Request.FetchUserData(userId: id)
        worker.fetchUserData(request) { response in
            switch response {
            case .success(let data):
                self.buildSelectedUser(withData: data, userId: id)
                self.presenter.didFetchUserData()
                break
            case .error:
                break
            }
        }
    }
    
    func didAcceptNotification(_ request: Notifications.Request.NotificationAnswer) {
        let index = request.index
        let notification = notifications?.notifications[index]
        guard let fromUserId = notification?.userId, let toUserId = currentUser?.userId else { return }
        let newRequest = Notifications.Request.ConnectUsers(fromUserId: fromUserId,
                                                            toUserId: toUserId)
        worker.fetchConnectUsers(newRequest) { response in
            switch response {
            case .success:
                self.presenter.didAcceptUser()
                break
            case .error(let error):
                self.presenter.presentError(error.localizedDescription)
                break
            }
        }
    }
    
    func didRefuseNotification(_ request: Notifications.Request.NotificationAnswer) {
        
    }
}
