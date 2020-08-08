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
        let newRequest = SaveNotificationsRequest(userId: request.toUserId,
                                                  notifications: notifications)
        builder.addConnectNotifications(request: newRequest, completion: completion)
    }
}
