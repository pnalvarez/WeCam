//
//  NotificationsPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

protocol NotificationsPresentationLogic {
    func presentLoading(_ loading: Bool)
    func presentError(_ response: String)
    func presentNotifications(_ response: Notifications.Info.Model.UpcomingNotifications)
    func didFetchUserData()
    func didAcceptUser()
    func presentAnsweredNotification(index: Int,
                                     answer: Notifications.Info.Model.NotificationAnswer)
}

class NotificationsPresenter: NotificationsPresentationLogic {
    
    private unowned var viewController: NotificationsDisplayLogic
    
    init(viewController: NotificationsDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentLoading(_ loading: Bool) {
        viewController.displayLoading(loading)
    }
    
    func presentError(_ response: String) {
        let viewModel = Notifications
            .Info
            .ViewModel
            .NotificationError(description: response)
        viewController.displayError(viewModel)
    }
    
    func presentNotifications(_ response: Notifications.Info.Model.UpcomingNotifications) {
        var viewModel = Notifications.Info.ViewModel.UpcomingNotifications(notifications: [])
        for notification in response.notifications {
            let upcomingNotification = Notifications
                .Info
                .ViewModel
                .Notification(notificationText: Notifications.Constants.Texts.connectNotificationText,
                              image: notification.image,
                              name: notification.name,
                              ocupation: notification.ocupation,
                              email: NSAttributedString(string: notification.email,
                                                        attributes: [NSAttributedString.Key.font: Notifications
                                                            .Constants
                                                            .Fonts
                                                            .emailLbl,
                                                                     NSAttributedString.Key.foregroundColor:
                                                                        Notifications.Constants.Colors.emailLbl,
                                                                     NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]))
            viewModel.notifications.append(upcomingNotification)
        }
        viewController.displayNotificationns(viewModel)
    }
    
    func didFetchUserData() {
        viewController.displaySelectedUser()
    }
    
    func didAcceptUser() {
        
    }
    
    func presentAnsweredNotification(index: Int,
                                     answer: Notifications.Info.Model.NotificationAnswer) {
        var viewModel: Notifications.Info.ViewModel.NotificationAnswer
        switch answer {
        case .accepted:
            viewModel = Notifications.Info.ViewModel.NotificationAnswer(index: index,
                                                                        text: Notifications.Constants.Texts.acceptedConnection)
            break
        case .refused:
            viewModel = Notifications.Info.ViewModel.NotificationAnswer(index: index,
                                                                        text: Notifications.Constants.Texts.refusedConnection)
            break
        }
        viewController.displayNotificationAnswer(viewModel)
    }
}

extension NotificationsPresenter {

}
