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
    func presentNotifications(_ response: Notifications.Info.Model.AllNotifications)
    func didFetchUserData()
    func presentAnsweredConnectNotification(index: Int,
                                            answer: Notifications.Info.Model.NotificationAnswer)
    func presentAnsweredProjectInviteNotification(index: Int,
                                                  answer: Notifications.Info.Model.NotificationAnswer)
    func presentAnsweredProjectParticipationRequest(index: Int,
                                                    answer: Notifications.Info.Model.NotificationAnswer)
    func presentAnsweredFinishedProjectInviteNotifications(index: Int,
                                                           answer: Notifications.Info.Model.NotificationAnswer)
    func presentNotificationCriterias(response: Notifications.Info.Model.UpcomingCriterias)
    func didFetchProjectData()
}

class NotificationsPresenter: NotificationsPresentationLogic {
    
    private unowned var viewController: NotificationsDisplayLogic
    
    init(viewController: NotificationsDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentLoading(_ loading: Bool) {
        viewController.defaultScreenLoading(!loading)
    }
    
    func presentError(_ response: String) {
        viewController.showErrorToast(withText: response)
    }
    
    func presentNotifications(_ response: Notifications.Info.Model.AllNotifications) {
        var viewModel = Notifications.Info.ViewModel.UpcomingNotifications(defaultNotifications: .empty, acceptNotifications: response.acceptNotifications.map({Notifications.Info.ViewModel.AcceptNotification(image: $0.image, text: $0.text)}))
        for notification in response.defaultNotifications {
            var upcomingNotification: Notifications.Info.ViewModel.DefaultNotification
            if let connectNotification = notification as? Notifications.Info.Model.ConnectNotification {
                upcomingNotification = Notifications
                    .Info
                    .ViewModel
                    .DefaultNotification(notificationText: Notifications.Constants.Texts.connectNotificationText,
                                  image: notification.image,
                                  name: connectNotification.userName,
                                  ocupation: connectNotification.ocupation,
                                  email: NSAttributedString(string: connectNotification.email,
                                                            attributes: [NSAttributedString.Key.font: Notifications
                                                                            .Constants
                                                                            .Fonts
                                                                            .emailLbl,
                                                                         NSAttributedString.Key.foregroundColor:
                                                                            Notifications.Constants.Colors.emailLbl,
                                                                         NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]), selectable: true)
                viewModel.defaultNotifications.append(upcomingNotification)
            } else if let inviteProjectNotification = notification as? Notifications.Info.Model.OnGoingProjectInviteNotification {
                upcomingNotification = Notifications
                    .Info
                    .ViewModel
                    .DefaultNotification(notificationText: "\(notification.userName) te convidou para este projeto, deseja participar?",
                                  image: inviteProjectNotification.image,
                                  name: inviteProjectNotification.projectName,
                                  ocupation: .empty,
                                  email: .empty,
                                  selectable: true)
                viewModel.defaultNotifications.append(upcomingNotification)
            } else if let projectParticipationRequest = notification as? Notifications.Info.Model.OnGoingProjectParticipationRequestNotification {
                upcomingNotification = Notifications
                    .Info
                    .ViewModel
                    .DefaultNotification(notificationText: "Solicitou participar do projeto \(projectParticipationRequest.projectName), deseja aceitá-lo?",
                                  image: projectParticipationRequest.image,
                                  name: projectParticipationRequest.userName,
                                  ocupation: projectParticipationRequest.ocupation,
                                  email: NSAttributedString(string: projectParticipationRequest.email,
                                                            attributes: [NSAttributedString.Key.font: Notifications
                                                                            .Constants
                                                                            .Fonts
                                                                            .emailLbl,
                                                                         NSAttributedString.Key.foregroundColor:
                                                                            Notifications.Constants.Colors.emailLbl,
                                                                         NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]),
                                  selectable: true)
                viewModel.defaultNotifications.append(upcomingNotification)
            } else if let finishedProjectInviteNotification = notification as? Notifications.Info.Model.FinishedProjectInviteNotification {
                upcomingNotification = Notifications
                    .Info
                    .ViewModel
                    .DefaultNotification(notificationText: "\(finishedProjectInviteNotification.userName) disse que você participou deste projeto. Deseja confirmar?",
                                  image: finishedProjectInviteNotification.image,
                                  name: finishedProjectInviteNotification.projectName,
                                  ocupation: .empty,
                                  email: .empty,
                                  selectable: true)
                viewModel.defaultNotifications.append(upcomingNotification)
            }
        }
        viewController.displayNotifications(viewModel)
    }
    
    func didFetchUserData() {
        viewController.displaySelectedUser()
    }
    
    func presentAnsweredConnectNotification(index: Int,
                                            answer: Notifications.Info.Model.NotificationAnswer) {
        var viewModel: Notifications.Info.ViewModel.NotificationAnswer
        switch answer {
        case .accepted:
            viewModel = Notifications.Info.ViewModel.NotificationAnswer(index: index,
                                                                        text: Notifications.Constants.Texts.acceptedConnection)
        case .refused:
            viewModel = Notifications.Info.ViewModel.NotificationAnswer(index: index,
                                                                        text: Notifications.Constants.Texts.refusedConnection)
        }
        viewController.displayNotificationAnswer(viewModel)
    }
    
    func presentAnsweredProjectInviteNotification(index: Int,
                                                  answer: Notifications.Info.Model.NotificationAnswer) {
        var viewModel: Notifications.Info.ViewModel.NotificationAnswer
        switch answer {
        case .accepted:
            viewModel = Notifications.Info.ViewModel.NotificationAnswer(index: index,
                                                                        text: Notifications.Constants.Texts.acceptedProjectInvite)
        case .refused:
            viewModel = Notifications.Info.ViewModel.NotificationAnswer(index: index,
                                                                        text: Notifications.Constants.Texts.refusedProjectInvite)
        }
        viewController.displayNotificationAnswer(viewModel)
    }
    
    func presentAnsweredProjectParticipationRequest(index: Int,
                                                    answer: Notifications.Info.Model.NotificationAnswer) {
        var viewModel: Notifications.Info.ViewModel.NotificationAnswer
        switch answer {
        case .accepted:
            viewModel = Notifications.Info.ViewModel.NotificationAnswer(index: index,
                                                                        text: Notifications.Constants.Texts.acceptedProjectParticipationRequest)
        case .refused:
            viewModel = Notifications.Info.ViewModel.NotificationAnswer(index: index,
                                                                        text: Notifications.Constants.Texts.refusedProjectParticipationRequest)
        }
        viewController.displayNotificationAnswer(viewModel)
    }
    
    func presentAnsweredFinishedProjectInviteNotifications(index: Int,
                                                           answer: Notifications.Info.Model.NotificationAnswer) {
        var viewModel: Notifications.Info.ViewModel.NotificationAnswer
        switch answer {
        case .accepted:
            viewModel = Notifications.Info.ViewModel.NotificationAnswer(index: index, text: Notifications.Constants.Texts.acceptedFinishedProjectInvite)
        case .refused:
            viewModel = Notifications.Info.ViewModel.NotificationAnswer(index: index, text: Notifications.Constants.Texts.refusedFinishedProjectInvite)
        }
        viewController.displayNotificationAnswer(viewModel)
    }
    
    func presentNotificationCriterias(response: Notifications.Info.Model.UpcomingCriterias) {
        let viewModel = Notifications.Info.ViewModel.UpcomingNotificationCriterias(criterias: response.criterias.map({Notifications.Info.ViewModel.NotificationCriteria(criteria: $0.rawValue)}))
        viewController.displayNotificationCriterias(viewModel)
    }
    
    func didFetchProjectData() {
        viewController.displayProjectDetails()
    }
}

