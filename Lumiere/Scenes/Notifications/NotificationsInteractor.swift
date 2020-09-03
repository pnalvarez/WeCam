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
}

class NotificationsInteractor: NotificationsDataStore {
    
    var presenter: NotificationsPresentationLogic
    var worker: NotificationsWorkerProtocol
    
    var currentUser: Notifications.Info.Received.CurrentUser?
    var connectNotifications: Notifications.Info.Model.UpcomingNotifications?
    var projectInviteNotifications: Notifications.Info.Model.UpcomingProjectInvites?
    var selectedUser: Notifications.Info.Model.User?
    
    init(viewController: NotificationsDisplayLogic,
         worker: NotificationsWorkerProtocol = NotificationsWorker()) {
        self.presenter = NotificationsPresenter(viewController: viewController)
        self.worker = worker
    }
}

extension NotificationsInteractor {
    
    private func buildNotificationsModel(withData connections: [Notifications.Response.ConnectNotification]){
        var upcomingNotifications = [Notifications.Info.Model.ConnectionNotification]()
        for notification in connections {
            upcomingNotifications.append(Notifications.Info.Model.ConnectionNotification(userId: notification.userId ?? .empty, image: notification.image ?? .empty,
                                                                                         name: notification.name ?? .empty,
                                                                                         ocupation: notification.ocupation ?? .empty,
                                                                                         email: notification.email ?? .empty))
        }
        self.connectNotifications = Notifications.Info.Model.UpcomingNotifications(notifications: upcomingNotifications)
    }
    
    private func fetchProjectInvites() {
        worker.fetchProjectInviteNotifications(Notifications.Request.ProjectInviteNotifications()) { response in
            switch response {
            case .success(let data):
                for invite in data {
                    self.worker.fetchInvitingUserData(Notifications.Request.FetchInvitingUser(userId: invite.authorId ?? .empty)) { response in
                        switch response {
                        case .success(let newData):
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
                            break
                        case .error(let error):
                            break
                        }
                    }
                }
//                self.projectInviteNotifications = Notifications.Info.Model.UpcomingProjectInvites(notifications: data.map({ Notifications
//                    .Info
//                    .Model
//                    .ProjectInviteNotification(userId: $0.authorId ?? .empty,
//                                               userName: <#T##String#>, image: <#T##String#>, projectId: <#T##String#>, projectName: <#T##String#>) }))
                break
            case .error(let error):
                break
            }
        }
    }
    
    private func fetchInvitingUser(withId id: String) {
        
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
                self.buildNotificationsModel(withData: data)
                self.presenter.presentLoading(false)
                guard let notifications = self.connectNotifications else { return }
                self.presenter.presentNotifications(notifications)
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
        guard let notifications = self.connectNotifications else { return }
        self.presenter.presentNotifications(notifications)
    }
}
