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
}

class NotificationsInteractor: NotificationsDataStore {
    
    var presenter: NotificationsPresentationLogic
    var worker: NotificationsWorkerProtocol
    
    var currentUser: Notifications.Info.Received.CurrentUser?
    var notifications: Notifications.Info.Model.UpcomingNotifications?
    
    init(viewController: NotificationsDisplayLogic,
         worker: NotificationsWorkerProtocol = NotificationsWorker()) {
        self.presenter = NotificationsPresenter(viewController: viewController)
        self.worker = worker
    }
}

extension NotificationsInteractor {
    
    private func buildNotificationsModel(withData data: Notifications.Response.FetchNotificationsResponseData) {
        var upcomingNotifications = [Notifications.Info.Model.Notification]()
        for notification in data.notifications {
            if let dictionary = notification as? [String : Any],
                let imageUrlString = dictionary["image"] as? String,
                let name = dictionary["name"] as? String,
                let email = dictionary["email"] as? String,
                let ocupation = dictionary["ocupation"] as? String,
                let userId = dictionary["userId"] as? String,
                let imageUrl = URL(string: imageUrlString) {
                imageUrl.getData { (data, response, error) in
                    upcomingNotifications.append(Notifications
                        .Info
                        .Model
                        .Notification(type: .connection,
                                      userId: userId,
                                      image: data,
                                      name: name,
                                      ocupation: ocupation,
                                      email: email))
                }
            }
        }
        self.notifications = Notifications.Info.Model.UpcomingNotifications(notifications: upcomingNotifications)
    }
}
extension NotificationsInteractor: NotificationsBusinessLogic {
    
    func fetchNotifications() {
        guard let currentUserId = currentUser?.userId else { return }
        worker.fetchNotifications(Notifications.Request.FetchNotifications(userId: currentUserId)) { response in
            self.presenter.presentLoading(false)
            switch response {
            case .success(let data):
                self.buildNotificationsModel(withData: data)
                guard let notifications = self.notifications else { return }
                self.presenter.presentNotifications(notifications)
                break
            case .error:
                self.presenter.presentError(Notifications
                    .Errors
                    .NotificationError(error: Notifications
                        .Errors
                        .GenericError.generic))
                break
            }
        }
    }
    
    func updateNotifications() {
        
    }
    
    func didSelectProfile(_ request: Notifications.Request.SelectProfile) {
        
    }
    
    func didAcceptNotification(_ request: Notifications.Request.NotificationAnswer) {
        
    }
    
    func didRefuseNotification(_ request: Notifications.Request.NotificationAnswer) {
        
    }
}
