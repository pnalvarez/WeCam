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
    func didSelectNotification(_ request: Notifications.Request.SelectProfile)
    func didAcceptNotification(_ request: Notifications.Request.NotificationAnswer)
    func didRefuseNotification(_ request: Notifications.Request.NotificationAnswer)
    func fetchRefreshNotifications(_ request: Notifications.Request.RefreshNotifications)
}

protocol NotificationsDataStore {
    var currentUser: Notifications.Info.Received.CurrentUser? { get set }
    var projectInviteNotifications: Notifications.Info.Model.UpcomingProjectInvites? { get set }
    var projectParticipationRequests: Notifications.Info.Model.UpcomingProjectParticipationRequests? { get set }
    var selectedUser: Notifications.Info.Model.User? { get set }
    var selectedProject: Notifications.Info.Model.Project? { get set }
    var allNotifications: Notifications.Info.Model.AllNotifications? { get set }
    var upcomingConnectNotifications: Notifications.Info.Model.UpcomingConnectNotifications? { get set }
    var finishedProjectInviteNotifications: Notifications.Info.Model.UpcomingFinishedProjectInviteNotifications? { get }
}

class NotificationsInteractor: NotificationsDataStore {
    
    var presenter: NotificationsPresentationLogic
    var worker: NotificationsWorkerProtocol
    
    var currentUser: Notifications.Info.Received.CurrentUser?
    var projectInviteNotifications: Notifications.Info.Model.UpcomingProjectInvites?
    var projectParticipationRequests: Notifications.Info.Model.UpcomingProjectParticipationRequests?
    var selectedUser: Notifications.Info.Model.User?
    var selectedProject: Notifications.Info.Model.Project?
    var allNotifications: Notifications.Info.Model.AllNotifications?
    var upcomingConnectNotifications: Notifications.Info.Model.UpcomingConnectNotifications?
    var finishedProjectInviteNotifications: Notifications.Info.Model.UpcomingFinishedProjectInviteNotifications?
    
    init(presenter: NotificationsPresentationLogic,
         worker: NotificationsWorkerProtocol = NotificationsWorker()) {
        self.presenter = presenter
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
        projectInviteNotifications = Notifications.Info.Model.UpcomingProjectInvites(notifications: .empty)
        worker.fetchProjectInviteNotifications(Notifications.Request.ProjectInviteNotifications()) { response in
            switch response {
            case .success(let data):
                if data.isEmpty {
                    self.presenter.presentLoading(false)
                    self.projectInviteNotifications?.notifications = .empty
                    self.fetchProjectParticipationRequests()
                }
                for i in 0..<data.count {
                    self.worker.fetchInvitingUserData(Notifications.Request.FetchInvitingUser(userId: data[i].authorId ?? .empty)) { response in
                        switch response {
                        case .success(let newData):
                            self.projectInviteNotifications?.notifications.append(Notifications
                                                                                    .Info
                                                                                    .Model
                                                                                    .OnGoingProjectInviteNotification(userId: data[i].authorId ?? .empty,
                                                                                                                      userName: newData.name ?? .empty,
                                                                                                                      image: data[i].image ?? .empty,
                                                                                                                      projectId: data[i].projectId ?? .empty,
                                                                                                                      projectName: data[i].projectTitle ?? .empty))
                            if i == data.count-1 {
                                self.fetchProjectParticipationRequests()
                            }
                        case .error(let error):
                            self.presenter.presentLoading(false)
                            self.presenter.presentError(error.localizedDescription)
                        }
                    }
                }
                break
            case .error(let error):
                self.presenter.presentLoading(false)
                self.presenter.presentError(error.localizedDescription)
            }
        }
    }
    
    private func updateNotifications(without userId: String) {
        allNotifications?.notifications.removeAll(where:
                                                    { $0.userId == userId && $0 is Notifications.Info.Model.ConnectNotification})
    }
    
    private func fetchProjectParticipationRequests() {
        projectParticipationRequests = Notifications.Info.Model.UpcomingProjectParticipationRequests(notifications: .empty)
        worker.fetchProjectParticipationRequestNotifications(Notifications.Request.FetchProjectParticipationRequestNotifications()) { response in
            switch response {
            case .success(let data):
                self.presenter.presentLoading(false)
                if data.isEmpty {
                    self.projectParticipationRequests?.notifications = .empty
                    self.fetchFinishedProjectInviteNotifications()
                } else {
                    self.projectParticipationRequests?.notifications = data.map({ Notifications
                                                                                    .Info
                                                                                    .Model
                                                                                    .OnGoingProjectParticipationRequestNotification(userId: $0.userId ?? .empty,
                                                                                                                                    userName: $0.userName ?? .empty,
                                                                                                                                    image: $0.image ?? .empty,
                                                                                                                                    projectId: $0.projectId ?? .empty,
                                                                                                                                    projectName: $0.projectName ?? .empty,
                                                                                                                                    email: $0.userEmail ?? .empty,
                                                                                                                                    ocupation: $0.ocupation ?? .empty) })
                    self.fetchFinishedProjectInviteNotifications()
                }
            case .error(let error):
                self.presenter.presentLoading(false)
                self.presenter.presentError(error.localizedDescription)
            }
        }
    }
    
    private func fetchFinishedProjectInviteNotifications() {
        finishedProjectInviteNotifications = Notifications.Info.Model.UpcomingFinishedProjectInviteNotifications(notifications: .empty)
        worker.fetchFinishedProjectInviteNotifications(Notifications.Request.ProjectInviteNotifications()) { response in
            switch response {
            case .success(let notifications):
                self.finishedProjectInviteNotifications?.notifications = notifications.map({Notifications.Info.Model.FinishedProjectInviteNotification(userId: $0.authorId ?? .empty, userName: $0.authorName ?? .empty, image: $0.projectImage ?? .empty, projectId: $0.projectId ?? .empty, projectName: $0.projectTitle ?? .empty)})
                self.allNotifications = Notifications.Info.Model.AllNotifications(notifications: self.projectParticipationRequests?.notifications ?? .empty)
                self.allNotifications?.notifications.append(contentsOf: self.projectInviteNotifications?.notifications ?? .empty)
                self.allNotifications?.notifications.append(contentsOf: self.upcomingConnectNotifications?.notifications ?? .empty)
                self.allNotifications?.notifications.append(contentsOf: self.finishedProjectInviteNotifications?.notifications ?? .empty)
                guard let allNotifications = self.allNotifications else { return }
                self.presenter.presentNotifications(allNotifications)
            case .error(_):
                break
            }
        }
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
                break
            case .error(let error):
                self.presenter.presentLoading(false)
                self.presenter.presentError(error.localizedDescription)
                break
            }
        }
    }
    
    func didSelectNotification(_ request: Notifications.Request.SelectProfile) {
        self.presenter.presentLoading(true)
        if let notification = allNotifications?.notifications[request.index] as? Notifications.Info.Model.ConnectNotification {
            let id = notification.userId
            selectedUser = Notifications.Info.Model.User(userId: id)
            presenter.didFetchUserData()
        } else if let notification = allNotifications?.notifications[request.index] as? Notifications.Info.Model.OnGoingProjectInviteNotification {
            let id = notification.projectId
            selectedProject = Notifications.Info.Model.Project(projectId: id)
            presenter.didFetchProjectData()
        } else if let notification = allNotifications?.notifications[request.index] as? Notifications.Info.Model.OnGoingProjectParticipationRequestNotification {
            let id = notification.userId
            selectedUser = Notifications.Info.Model.User(userId: id)
            presenter.didFetchUserData()
        }
    }
    
    func didAcceptNotification(_ request: Notifications.Request.NotificationAnswer) {
        let index = request.index
        let notification = allNotifications?.notifications[index]
        if let connectNotification = notification as? Notifications.Info.Model.ConnectNotification {
            let fromUserId = connectNotification.userId
            let toUserId = currentUser?.userId ?? .empty
            let newRequest = Notifications.Request.ConnectUsers(fromUserId: fromUserId,
                                                                toUserId: toUserId)
            presenter.presentLoading(true)
            worker.fetchConnectUsers(newRequest) { response in
                switch response {
                case .success:
                    self.presenter.presentLoading(false)
                    guard let index = self.allNotifications?.notifications.firstIndex(where: { $0.userId == fromUserId }) else { return }
                    self.updateNotifications(without: fromUserId)
                    self.presenter.presentAnsweredConnectNotification(index: index, answer: .accepted)
                case .error(let error):
                    self.presenter.presentLoading(false)
                    self.presenter.presentError(error.localizedDescription)
                }
            }
        } else if let projectInviteNotification = notification as? Notifications.Info.Model.OnGoingProjectInviteNotification {
            let projectId = projectInviteNotification.projectId
            let newRequest = Notifications.Request.AcceptProjectInvite(projectId: projectId)
            presenter.presentLoading(true)
            worker.fetchAcceptProjectInvite(newRequest) { response in
                switch response {
                case .success:
                    self.presenter.presentLoading(false)
                    self.allNotifications?.notifications.removeAll(where: {
                        if let notification = $0 as? Notifications.Info.Model.OnGoingProjectInviteNotification {
                            return notification.projectId == projectId
                        }
                        return false
                    })
                    self.presenter.presentAnsweredProjectInviteNotification(index: index,
                                                                            answer: .accepted)
                case .error(let error):
                    self.presenter.presentLoading(false)
                    self.presenter.presentError(error.localizedDescription)
                }
            }
        } else if let projectParticipationRequest = notification as? Notifications.Info.Model.OnGoingProjectParticipationRequestNotification {
            let projectId = projectParticipationRequest.projectId
            let userId = projectParticipationRequest.userId
            let newRequest = Notifications.Request.FetchAcceptUserIntoProject(userId: userId,
                                                                              projectId: projectId)
            presenter.presentLoading(true)
            worker.fetchAcceptUserIntoProject(newRequest) { response in
                switch response {
                case .success:
                    self.presenter.presentLoading(false)
                    self.allNotifications?.notifications.removeAll(where: {
                        if let notification = $0 as? Notifications.Info.Model.OnGoingProjectParticipationRequestNotification {
                            return notification.projectId == projectId && notification.userId == userId
                        }
                        return false
                    })
                    self.presenter.presentAnsweredProjectParticipationRequest(index: index,
                                                                              answer: .accepted)
                case .error(let error):
                    self.presenter.presentLoading(false)
                    self.presenter.presentError(error.localizedDescription)
                }
            }
        } else if let finishedProjectInviteNotification = notification as? Notifications.Info.Model.FinishedProjectInviteNotification {
            let projectId = finishedProjectInviteNotification.projectId
            let newRequest = Notifications.Request.AcceptFinishedProjectInvite(projectId: projectId)
            presenter.presentLoading(true)
            worker.fetchAcceptFinishedProjectInvite(newRequest) { response in
                switch response {
                case .success:
                    self.presenter.presentLoading(false)
                    guard let index = self.allNotifications?.notifications.firstIndex(where: {
                        guard let notification = $0 as? Notifications
                                .Info
                                .Model
                                .FinishedProjectInviteNotification else {
                            return false
                        }
                        return notification.projectId == projectId
                    }) else { return }
                    self.allNotifications?.notifications.remove(at: index)
                    self.presenter.presentAnsweredFinishedProjectInviteNotifications(index: index, answer: .accepted)
                case .error(let error):
                    self.presenter.presentLoading(false)
                    self.presenter.presentError(error.localizedDescription)
                }
            }
        }
    }
    
    
    func didRefuseNotification(_ request: Notifications.Request.NotificationAnswer) {
        let index = request.index
        let notification = allNotifications?.notifications[index]
        if let connectNotification = notification as? Notifications.Info.Model.ConnectNotification {
            let userId = connectNotification.userId
            let newRequest = Notifications.Request.RemovePendingNotification(userId: userId)
            presenter.presentLoading(true)
            worker.fetchRemovePendingConnectNotification(newRequest) { response in
                switch response {
                case .success:
                    self.presenter.presentLoading(false)
                    guard let index = self.allNotifications?.notifications.firstIndex(where: { $0.userId == userId && $0 is Notifications.Info.Model.ConnectNotification }) else { return }
                    self.updateNotifications(without: userId)
                    self.presenter.presentAnsweredConnectNotification(index: index, answer: .refused)
                case .error(let error):
                    self.presenter.presentLoading(false)
                    self.presenter.presentError(error.localizedDescription)
                    break
                }
            }
        } else if let projectInviteNotification = notification as? Notifications.Info.Model.OnGoingProjectInviteNotification {
            let projectId = projectInviteNotification.projectId
            let newRequest = Notifications.Request.RefuseProjectInvite(projectId: projectId)
            presenter.presentLoading(true)
            worker.fetchRefuseProjectInvite(newRequest) { response in
                switch response {
                case .success:
                    self.presenter.presentLoading(false)
                    guard let index = self.allNotifications?.notifications.firstIndex(where: {
                        guard let notification = $0 as? Notifications.Info.Model.OnGoingProjectInviteNotification else {
                            return false
                        }
                        return notification.projectId == projectId
                    }) else { return }
                    self.allNotifications?.notifications.removeAll(where: {
                        guard let notification = $0 as? Notifications.Info.Model.OnGoingProjectInviteNotification else {
                            return false
                        }
                        return notification.projectId == projectId
                    })
                    self.presenter.presentAnsweredProjectInviteNotification(index: index, answer: .refused)
                case .error(let error):
                    self.presenter.presentLoading(false)
                    self.presenter.presentError(error.localizedDescription)
                }
            }
        } else if let projectParticipationRequest = notification as? Notifications.Info.Model.OnGoingProjectParticipationRequestNotification {
            let projectId = projectParticipationRequest.projectId
            let userId = projectParticipationRequest.userId
            let newRequest = Notifications.Request.RefuseParticipationRequest(projectId: projectId,
                                                                              userId: userId)
            presenter.presentLoading(true)
            worker.fetchRefuseProjectParticipationRequest(newRequest) { response in
                switch response {
                case .success:
                    self.presenter.presentLoading(false)
                    guard let index = self.allNotifications?.notifications.firstIndex(where: {
                        guard let notification = $0 as? Notifications
                                .Info
                                .Model
                                .OnGoingProjectParticipationRequestNotification else {
                            return false
                        }
                        return notification.projectId == projectId && notification.userId == userId
                    }) else { return }
                    self.allNotifications?.notifications.removeAll(where: {
                        guard let notification = $0 as? Notifications
                                .Info
                                .Model
                                .OnGoingProjectParticipationRequestNotification else {
                            return false
                        }
                        return notification.projectId == projectId && notification.userId == userId
                    })
                    self.presenter.presentAnsweredProjectParticipationRequest(index: index,
                                                                              answer: .refused)
                case .error(let error):
                    self.presenter.presentLoading(false)
                    self.presenter.presentError(error.localizedDescription)
                }
            }
        } else if let finishedProjectNotification = notification as? Notifications.Info.Model.FinishedProjectInviteNotification {
            let projectId = finishedProjectNotification.projectId
            let newRequest = Notifications.Request.RefuseProjectInvite(projectId: projectId)
            presenter.presentLoading(true)
            worker.fetchRefuseFinishedProjectInvite(newRequest) { response in
                switch response {
                case .success:
                    self.presenter.presentLoading(false)
                    guard let index = self.allNotifications?.notifications.firstIndex(where: {
                        guard let notification = $0 as? Notifications
                                .Info
                                .Model
                                .FinishedProjectInviteNotification else {
                            return false
                        }
                        return notification.projectId == projectId
                    }) else { return }
                    self.allNotifications?.notifications.remove(at: index)
                    self.presenter.presentAnsweredFinishedProjectInviteNotifications(index: index, answer: .refused)
                case .error(let error):
                    self.presenter.presentLoading(false)
                    self.presenter.presentError(error.localizedDescription)
                }
            }
        }
    }
    func fetchRefreshNotifications(_ request: Notifications.Request.RefreshNotifications) {
        guard let allNotifications = self.allNotifications else { return }
        self.presenter.presentNotifications(allNotifications)
    }
}
