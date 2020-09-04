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
    func didSelectProfile(_ request: Notifications.Request.SelectProfile)
    func didAcceptNotification(_ request: Notifications.Request.NotificationAnswer)
    func didRefuseNotification(_ request: Notifications.Request.NotificationAnswer)
    func fetchRefreshNotifications(_ request: Notifications.Request.RefreshNotifications)
}

protocol NotificationsDataStore {
    var currentUser: Notifications.Info.Received.CurrentUser? { get set }
    var connectNotifications: Notifications.Info.Model.UpcomingNotifications? { get set }
    var projectInviteNotifications: Notifications.Info.Model.UpcomingProjectInvites? { get set }
    var selectedUser: Notifications.Info.Model.User? { get set }
    var allNotifications: Notifications.Info.Model.AllNotifications? { get set }
    var upcomingConnectNotifications: Notifications.Info.Model.UpcomingConnectNotifications? { get set }
}

class NotificationsInteractor: NotificationsDataStore {
    
    var presenter: NotificationsPresentationLogic
    var worker: NotificationsWorkerProtocol
    
    var currentUser: Notifications.Info.Received.CurrentUser?
    var connectNotifications: Notifications.Info.Model.UpcomingNotifications?
    var projectInviteNotifications: Notifications.Info.Model.UpcomingProjectInvites?
    var selectedUser: Notifications.Info.Model.User?
    var allNotifications: Notifications.Info.Model.AllNotifications?
    var upcomingConnectNotifications: Notifications.Info.Model.UpcomingConnectNotifications?
    
    init(viewController: NotificationsDisplayLogic,
         worker: NotificationsWorkerProtocol = NotificationsWorker()) {
        self.presenter = NotificationsPresenter(viewController: viewController)
        self.worker = worker
    }
}

extension NotificationsInteractor {
    
    private func buildConnectNotificationsModel(withData connections: [Notifications.Response.ConnectNotification]){
        var upcomingNotifications = [Notifications.Info.Model.ConnectNotification]()
        for notification in connections {
            upcomingNotifications.append(Notifications.Info.Model.ConnectNotification(userId: notification.userId ?? .empty,
                                                                                      userName: notification.name ?? .empty,
                                                                                      image: notification.image ?? .empty,
                                                                                      ocupation: notification.ocupation ?? .empty,
                                                                                      email: notification.email ?? .empty))
        }
        self.upcomingConnectNotifications = Notifications.Info.Model.UpcomingConnectNotifications(notifications: upcomingNotifications)
        self.allNotifications = Notifications.Info.Model.AllNotifications(notifications: upcomingNotifications)
    }
    
    private func fetchProjectInvites() {
        worker.fetchProjectInviteNotifications(Notifications.Request.ProjectInviteNotifications()) { response in
            switch response {
            case .success(let data):
                for invite in data {
                    self.worker.fetchInvitingUserData(Notifications.Request.FetchInvitingUser(userId: invite.authorId ?? .empty)) { response in
                        switch response {
                        case .success(let newData):
                            self.presenter.presentLoading(false)
                            self.projectInviteNotifications = Notifications
                                .Info
                                .Model
                                .UpcomingProjectInvites(notifications: data.map({ _ in Notifications
                                    .Info
                                    .Model
                                    .ProjectInviteNotification(userId: invite.authorId ?? .empty,
                                                               userName: newData.name ?? .empty,
                                                               image: invite.image ?? .empty,
                                                               projectId: invite.projectId ?? .empty,
                                                               projectName: invite.projectTitle ?? .empty)}))
//                            guard let projectInviteNotifications = self.projectInviteNotifications else { return }
                            self.allNotifications = Notifications
                                .Info
                                .Model
                                .AllNotifications(notifications: self.upcomingConnectNotifications?.notifications ?? .empty)
                            self.allNotifications?.notifications.append(contentsOf: self.projectInviteNotifications?.notifications ?? .empty)
                            guard let allNotifications = self.allNotifications else { return }
                            self.presenter.presentNotifications(allNotifications)
                        case .error(let error):
                            self.presenter.presentLoading(false)
                            break
                        }
                    }
                }
                break
            case .error(let error):
                break
            }
        }
    }
    
    private func updateNotifications(without userId: String) {
        connectNotifications?.notifications.removeAll(where: { $0.userId == userId })
    }
}

extension NotificationsInteractor: NotificationsBusinessLogic {
    
    func fetchNotifications() {
        presenter.presentLoading(true)
        guard let currentUserId = currentUser?.userId else { return }
        worker.fetchConnectionNotifications(Notifications.Request.FetchConnectionNotifications(userId: currentUserId)) { response in
            switch response {
            case .success(let data):
                self.buildConnectNotificationsModel(withData: data)
                self.fetchProjectInvites()
//                self.presenter.presentLoading(false)
//                guard let notifications = self.connectNotifications else { return }
//                self.presenter.presentNotifications(notifications)
                break
            case .error(let error):
                self.presenter.presentLoading(false)
                self.presenter.presentError(error.localizedDescription)
                break
            }
        }
    }
    
    func didSelectProfile(_ request: Notifications.Request.SelectProfile) {
        self.presenter.presentLoading(true)
        guard let id = connectNotifications?.notifications[request.index].userId else {
            return
        }
        selectedUser = Notifications.Info.Model.User(userId: id)
        presenter.didFetchUserData()
    }
    
    func didAcceptNotification(_ request: Notifications.Request.NotificationAnswer) {
        let index = request.index
        let notification = connectNotifications?.notifications[index]
        guard let fromUserId = notification?.userId, let toUserId = currentUser?.userId else { return }
        let newRequest = Notifications.Request.ConnectUsers(fromUserId: fromUserId,
                                                            toUserId: toUserId)
        self.presenter.presentLoading(true)
        worker.fetchConnectUsers(newRequest) { response in
            switch response {
            case .success:
                self.presenter.presentLoading(false)
                guard let index = self.connectNotifications?.notifications.firstIndex(where: { $0.userId == fromUserId }) else { return }
                self.updateNotifications(without: fromUserId)
                self.presenter.presentAnsweredNotification(index: index, answer: .accepted)
                break
            case .error(let error):
                self.presenter.presentLoading(false)
                self.presenter.presentError(error.localizedDescription)
                break
            }
        }
    }
    
    func didRefuseNotification(_ request: Notifications.Request.NotificationAnswer) {
        let index = request.index
        let notification = connectNotifications?.notifications[index]
        guard let userId = notification?.userId else { return }
        let newRequest = Notifications.Request.RemovePendingNotification(userId: userId)
        presenter.presentLoading(true)
        worker.fetchRemovePendingNotification(newRequest) { response in
            switch response {
            case .success:
                self.presenter.presentLoading(false)
                guard let index = self.connectNotifications?.notifications.firstIndex(where: { $0.userId == userId }) else { return }
                self.updateNotifications(without: userId)
                self.presenter.presentAnsweredNotification(index: index, answer: .refused)
                break
            case .error(let error):
                self.presenter.presentLoading(false)
                self.presenter.presentError(error.localizedDescription)
                break
            }
        }
    }
    
    func fetchRefreshNotifications(_ request: Notifications.Request.RefreshNotifications) {
        guard let allNotifications = self.allNotifications else { return }
        self.presenter.presentNotifications(allNotifications)
    }
}
