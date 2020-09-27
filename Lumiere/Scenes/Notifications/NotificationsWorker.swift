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
                                         completion: @escaping (BaseResponse<[Notifications.Response.ProjectInvite]>) -> Void)
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
                                                       completion: @escaping (BaseResponse<[Notifications.Response.ProjectParticipationRequest]>) -> Void)
    func fetchAcceptUserIntoProject(_ request: Notifications.Request.FetchAcceptUserIntoProject,
                                    completion: @escaping (EmptyResponse) -> Void)
    func fetchRefuseProjectInvite(_ request: Notifications.Request.RefuseProjectInvite,
                                  completion: @escaping (EmptyResponse) -> Void)
    func fetchRefuseProjectParticipationRequest(_ request: Notifications.Request.RefuseParticipationRequest,
                                                completion: @escaping (EmptyResponse) -> Void)
}

class NotificationsWorker: NotificationsWorkerProtocol {
    
    private let builder: FirebaseAuthHelperProtocol
    
    init(builder: FirebaseAuthHelperProtocol = FirebaseAuthHelper()) {
        self.builder = builder
    }
    
    func fetchConnectionNotifications(_ request: Notifications.Request.FetchConnectionNotifications,
                            completion: @escaping (BaseResponse<Array<Notifications.Response.ConnectNotification>>) -> Void) {
        let newRequest = GetConnectNotificationRequest(userId: request.userId)
        builder.fetchUserConnectNotifications(request: newRequest,
                                              completion: completion)
    }
    
    func fetchProjectInviteNotifications(_ request: Notifications.Request.ProjectInviteNotifications,
                                         completion: @escaping (BaseResponse<[Notifications.Response.ProjectInvite]>) -> Void) {
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
                                                       completion: @escaping (BaseResponse<[Notifications.Response.ProjectParticipationRequest]>) -> Void) {
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
}
