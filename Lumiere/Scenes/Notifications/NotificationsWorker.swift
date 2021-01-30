//
//  NotificationsWorker.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import ObjectMapper

protocol NotificationsWorkerProtocol {
    func fetchConnectionNotifications(_ request: Notifications.Request.FetchConnectionNotifications,
                            completion: @escaping (BaseResponse<Array<Notifications.Response.ConnectNotification>>) -> Void)
    func fetchProjectInviteNotifications(_ request: Notifications.Request.ProjectInviteNotifications,
                                         completion: @escaping (BaseResponse<[Notifications.Response.OnGoingProjectInvite]>) -> Void)
    func fetchUserData(_ request: Notifications.Request.FetchUserData,
                       completion: @escaping (BaseResponse<Notifications.Response.User>) -> Void)
    func fetchConnectUsers(_ request: Notifications.Request.ConnectUsers,
                           completion: @escaping (EmptyResponse) -> Void)
    func fetchRemovePendingConnectNotification(_ request: Notifications.Request.RemovePendingNotification,
                                        completion: @escaping (EmptyResponse) -> Void)
    func fetchInvitingUserData(_ request: Notifications.Request.FetchInvitingUser,
                               completion: @escaping (BaseResponse<Notifications.Response.InvitingUser>) -> Void)
    func fetchAcceptProjectInvite(_ request: Notifications.Request.AcceptProjectInvite,
                                  completion: @escaping (EmptyResponse) -> Void)
    func fetchProjectParticipationRequestNotifications(_ request: Notifications.Request.FetchProjectParticipationRequestNotifications,
                                                       completion: @escaping (BaseResponse<[Notifications.Response.OnGoingProjectParticipationRequest]>) -> Void)
    func fetchAcceptUserIntoProject(_ request: Notifications.Request.FetchAcceptUserIntoProject,
                                    completion: @escaping (EmptyResponse) -> Void)
    func fetchRefuseProjectInvite(_ request: Notifications.Request.RefuseProjectInvite,
                                  completion: @escaping (EmptyResponse) -> Void)
    func fetchRefuseProjectParticipationRequest(_ request: Notifications.Request.RefuseParticipationRequest,
                                                completion: @escaping (EmptyResponse) -> Void)
    func fetchFinishedProjectInviteNotifications(_ request: Notifications.Request.ProjectInviteNotifications,
                                                 completion: @escaping (BaseResponse<[Notifications.Response.FinishedProjectInviteNotification]>) -> Void)
    func fetchAcceptFinishedProjectInvite(_ request: Notifications.Request.AcceptFinishedProjectInvite,
                                          completion: @escaping (EmptyResponse) -> Void)
    func fetchRefuseFinishedProjectInvite(_ request: Notifications.Request.RefuseProjectInvite,
                                          completion: @escaping (EmptyResponse) -> Void)
    func fetchConnectionAcceptNotifications(_ request: Notifications.Request.AcceptNotifications,
                                            completion: @escaping (BaseResponse<[Notifications.Response.AcceptNotification]>) -> Void)
    func fetchProjectInviteAcceptNotifications(_ request: Notifications.Request.AcceptNotifications,
                                            completion: @escaping (BaseResponse<[Notifications.Response.AcceptNotification]>) -> Void)
    func fetchProjectParticipationAcceptNotifications(_ request: Notifications.Request.AcceptNotifications,
                                            completion: @escaping (BaseResponse<[Notifications.Response.AcceptNotification]>) -> Void)
}

class NotificationsWorker: NotificationsWorkerProtocol {
    
    private let builder: FirebaseManagerProtocol
    
    init(builder: FirebaseManagerProtocol = FirebaseManager()) {
        self.builder = builder
    }
    
    func fetchConnectionNotifications(_ request: Notifications.Request.FetchConnectionNotifications,
                            completion: @escaping (BaseResponse<Array<Notifications.Response.ConnectNotification>>) -> Void) {
        let newRequest = GetConnectNotificationRequest(userId: request.userId)
        builder.fetchUserConnectNotifications(request: newRequest,
                                              completion: completion)
    }
    
    func fetchProjectInviteNotifications(_ request: Notifications.Request.ProjectInviteNotifications,
                                         completion: @escaping (BaseResponse<[Notifications.Response.OnGoingProjectInvite]>) -> Void) {
        let headers: [String : Any] = [:]
        builder.fetchProjectInvites(request: headers,
                                    completion: completion)
    }
    
    func fetchUserData(_ request: Notifications.Request.FetchUserData,
                       completion: @escaping (BaseResponse<Notifications.Response.User>) -> Void) {
        builder.fetchUserData(request: ["userId": request.userId],
                              completion: completion)
    }

    func fetchConnectUsers(_ request: Notifications.Request.ConnectUsers,
                           completion: @escaping (EmptyResponse) -> Void) {
        builder.fetchAcceptConnection(request: ["userId": request.fromUserId],
                                      completion: completion)
    }
    
    func fetchRemovePendingConnectNotification(_ request: Notifications.Request.RemovePendingNotification,
                                        completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["userId": request.userId]
        builder.fetchRefusePendingConnection(request: headers,
                                             completion: completion)
    }
    
    func fetchInvitingUserData(_ request: Notifications.Request.FetchInvitingUser,
                               completion: @escaping (BaseResponse<Notifications.Response.InvitingUser>) -> Void) {
        let headers: [String : Any] = ["userId": request.userId]
        builder.fetchUserData(request: headers,
                              completion: completion)
    }
    
    func fetchAcceptProjectInvite(_ request: Notifications.Request.AcceptProjectInvite,
                                  completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["projectId": request.projectId]
        builder.acceptProjectInvite(request: headers, completion: completion)
    }
    
    func fetchProjectParticipationRequestNotifications(_ request: Notifications.Request.FetchProjectParticipationRequestNotifications,
                                                       completion: @escaping (BaseResponse<[Notifications.Response.OnGoingProjectParticipationRequest]>) -> Void) {
        let headers: [String : Any] = .empty
        builder.fetchProjectParticipationRequestNotifications(request: headers,
                                                              completion: completion)
    }
    func fetchAcceptUserIntoProject(_ request: Notifications.Request.FetchAcceptUserIntoProject,
                                    completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["userId": request.userId,
                                       "projectId": request.projectId]
        builder.acceptUserIntoProject(request: headers, completion: completion)
    }
    
    func fetchRefuseProjectInvite(_ request: Notifications.Request.RefuseProjectInvite,
                                  completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["projectId": request.projectId]
        builder.refuseProjectInvite(request: headers, completion: completion)
    }
    
    func fetchRefuseProjectParticipationRequest(_ request: Notifications.Request.RefuseParticipationRequest,
                                                completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["projectId": request.projectId, "userId": request.userId]
        builder.refuseUserIntoProject(request: headers, completion: completion)
    }
    
    func fetchFinishedProjectInviteNotifications(_ request: Notifications.Request.ProjectInviteNotifications,
                                                 completion: @escaping (BaseResponse<[Notifications.Response.FinishedProjectInviteNotification]>) -> Void) {
        let headers: [String : Any] = .empty
        builder.fetchFinishedProjectInviteNotifications(request: headers, completion: completion)
    }
    
    func fetchAcceptFinishedProjectInvite(_ request: Notifications.Request.AcceptFinishedProjectInvite,
                                          completion: @escaping (EmptyResponse) -> Void) {
        let headers = ["projectId": request.projectId]
        builder.acceptFinishedProjectInvite(request: headers, completion: completion)
    }
    
    func fetchRefuseFinishedProjectInvite(_ request: Notifications.Request.RefuseProjectInvite,
                                          completion: @escaping (EmptyResponse) -> Void) {
        let headers = ["projectId": request.projectId]
        builder.refuseFinishedProjectInvite(request: headers, completion: completion)
    }
    
    func fetchConnectionAcceptNotifications(_ request: Notifications.Request.AcceptNotifications,
                                            completion: @escaping (BaseResponse<[Notifications.Response.AcceptNotification]>) -> Void) {
        let headers: [String : Any] = .empty
        builder.fetchConnectionAcceptNotifications(request: headers, completion: completion)
        
    }
    func fetchProjectInviteAcceptNotifications(_ request: Notifications.Request.AcceptNotifications,
                                               completion: @escaping (BaseResponse<[Notifications.Response.AcceptNotification]>) -> Void) {
        let headers: [String : Any] = .empty
        builder.fetchProjectInviteAcceptNotifications(request: headers, completion: completion)
    }
    
    func fetchProjectParticipationAcceptNotifications(_ request: Notifications.Request.AcceptNotifications,
                                                      completion: @escaping (BaseResponse<[Notifications.Response.AcceptNotification]>) -> Void) {
        let headers: [String : Any] = .empty
        builder.fetchProjectParticipationAcceptNotifications(request: headers, completion: completion)
    }
}
