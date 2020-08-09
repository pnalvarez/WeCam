//
//  ProfileDetailsWorker.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import ObjectMapper

protocol ProfileDetailsWorkerProtocol {
    func fetchUserConnectNotifications(_ request: ProfileDetails.Request.FetchNotifications,
                                                    completion: @escaping (BaseResponse<Array<ProfileDetails.Response.Notification>>) -> Void)
    func fetchCurrentUserId(_ request: ProfileDetails.Request.FetchCurrentUserId,
                            completion: @escaping (BaseResponse<ProfileDetails.Response.User>) -> Void)
    func fetchCurrentUserData(_ request: ProfileDetails.Request.FetchCurrentUserData,
                              completion: @escaping (BaseResponse<ProfileDetails.Response.User>) -> Void)
    func fetchProjectData(_ request: ProfileDetails.Request.ProjectInfo)
    func fetchAddConnection(_ request: ProfileDetails.Request.NewConnectNotification,
                            completion: @escaping (EmptyResponse) -> Void)
    func fetchRemoveConnection(_ request: ProfileDetails.Request.RemoveConnection,
                                completion: @escaping (EmptyResponse) -> Void)
    func fetchRemovePendingConnection(_ request: ProfileDetails.Request.RemovePendingConnection,
                                      completion: @escaping (EmptyResponse) -> Void)
    func fetchSendConnectionRequest(_ request: ProfileDetails.Request.SendConnectionRequest,
                                    completion: @escaping (EmptyResponse) -> Void)
    func fetchAcceptConnection(_ request: ProfileDetails.Request.AcceptConnectionRequest,
                               completion: @escaping (EmptyResponse) -> Void)
}

class ProfileDetailsWorker: ProfileDetailsWorkerProtocol {
    
    
    private let builder: FirebaseAuthHelperProtocol
    
    init(builder: FirebaseAuthHelperProtocol = FirebaseAuthHelper()) {
        self.builder = builder
    }
    
    func fetchUserConnectNotifications(_ request: ProfileDetails.Request.FetchNotifications, completion: @escaping (BaseResponse<Array<ProfileDetails.Response.Notification>>) -> Void) {
        let newRequest = GetConnectNotificationRequest(userId: request.userId)
        builder.fetchUserConnectNotifications(request: newRequest, completion: completion)
    }
    
    func fetchCurrentUserId(_ request: ProfileDetails.Request.FetchCurrentUserId,
                            completion: @escaping (BaseResponse<ProfileDetails.Response.User>) -> Void) {
        let newRequest = FetchCurrentUserIdRequest()
        builder.fetchCurrentUser(request: newRequest, completion: completion)
    }
    
    func fetchCurrentUserData(_ request: ProfileDetails.Request.FetchCurrentUserData,
                              completion: @escaping (BaseResponse<ProfileDetails.Response.User>) -> Void) {
        let newRequest = FetchUserDataRequest(userId: request.userId)
        builder.fetchUserData(request: newRequest, completion: completion)
    }
    
    func fetchProjectData(_ request: ProfileDetails.Request.ProjectInfo) {
        //TO DO
    }
    
    func fetchAddConnection(_ request: ProfileDetails.Request.NewConnectNotification,
                            completion: @escaping (EmptyResponse) -> Void) {
        let notificationDict: [String : Any] = ["image": request.image,
                                                "email": request.email,
                                                "name": request.name,
                                                "ocupation": request.ocupation,
                                                "userId": request.fromUserId]
        var notifications = request.oldNotifications.toJSON()
        notifications.append(notificationDict)
        let newRequest = SaveNotificationsRequest(fromUserId: request.fromUserId,
                                                  toUserId: request.toUserId,
                                                  notifications: notifications)
        builder.addConnectNotifications(request: newRequest, completion: completion)
    }
    
    func fetchRemoveConnection(_ request: ProfileDetails.Request.RemoveConnection,
                                completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["userId": request.id]
        builder.fetchRemoveConnection(request: headers, completion: completion)
    }
    
    func fetchRemovePendingConnection(_ request: ProfileDetails.Request.RemovePendingConnection,
                                      completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String: Any] = ["userId": request.id]
        builder.fetchRemovePendingConnection(request: headers, completion: completion)
    }
    
    func fetchSendConnectionRequest(_ request: ProfileDetails.Request.SendConnectionRequest,
                                    completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["userId": request.id]
        builder.fetchSendConnectionRequest(request: headers, completion: completion)
    }
    
    func fetchAcceptConnection(_ request: ProfileDetails.Request.AcceptConnectionRequest,
                               completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String: Any] = ["userId": request.id]
        builder.fetchAcceptConnection(request: headers, completion: completion)
    }
}

