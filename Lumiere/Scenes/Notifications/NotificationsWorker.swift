//
//  NotificationsWorker.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import ObjectMapper

protocol NotificationsWorkerProtocol {
    func fetchNotifications(_ request: Notifications.Request.FetchNotifications,
                            completion: @escaping (BaseResponse<Array<Notifications.Response.ConnectNotification>>) -> Void)
    func fetchUserData(_ request: Notifications.Request.FetchUserData,
                       completion: @escaping (BaseResponse<Notifications.Response.User>) -> Void)
    func fetchConnectUsers(_ request: Notifications.Request.ConnectUsers,
                           completion: @escaping (EmptyResponse) -> Void)
    func fetchUserRelation(_ request: Notifications.Request.UserRelation,
                           completion: @escaping (BaseResponse<Notifications.Response.Relation>) -> Void)
    func fetchRemovePendingNotification(_ request: Notifications.Request.RemovePendingNotification,
                                        completion: @escaping (EmptyResponse) -> Void)
}

class NotificationsWorker: NotificationsWorkerProtocol {
    
    private let builder: FirebaseAuthHelperProtocol
    
    init(builder: FirebaseAuthHelperProtocol = FirebaseAuthHelper()) {
        self.builder = builder
    }
    
    func fetchNotifications(_ request: Notifications.Request.FetchNotifications,
                            completion: @escaping (BaseResponse<Array<Notifications.Response.ConnectNotification>>) -> Void) {
        let newRequest = GetConnectNotificationRequest(userId: request.userId)
        builder.fetchUserConnectNotifications(request: newRequest,
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
    
    func fetchUserRelation(_ request: Notifications.Request.UserRelation,
                           completion: @escaping (BaseResponse<Notifications.Response.Relation>) -> Void) {
        let newRequest = FetchUserRelationRequest(fromUserId: request.fromUserId,
                                                  toUserId: request.toUserId)
        builder.fetchUserRelation(request: newRequest,
                                  completion: completion)
    }
    
    func fetchRemovePendingNotification(_ request: Notifications.Request.RemovePendingNotification,
                                        completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["userId": request.userId]
        builder.fetchRefusePendingConnection(request: headers,
                                             completion: completion)
    }
}
