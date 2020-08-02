//
//  ProfileDetailsWorker.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol ProfileDetailsWorkerProtocol {
    func fetchUserConnectNotifications(_ request: ProfileDetails.Request.FetchNotifications,
                                       completion: @escaping (ProfileDetails.Response.AllNotifications) -> Void)
    func fetchCurrentUserId(_ request: ProfileDetails.Request.FetchCurrentUserId,
                            completion: @escaping (ProfileDetails.Response.CurrentUserId) -> Void)
    func fetchCurrentUserData(_ request: ProfileDetails.Request.FetchCurrentUserData,
                              completion: @escaping (ProfileDetails.Response.CurrentUser) -> Void)
    func fetchProjectData(_ request: ProfileDetails.Request.ProjectInfo)
    func fetchAddConnection(_ request: ProfileDetails.Request.NewConnectNotification,
                            completion: @escaping (ProfileDetails.Response.AddConnection) -> Void)
}

class ProfileDetailsWorker: ProfileDetailsWorkerProtocol {
    
    private let builder: FirebaseAuthHelperProtocol
    
    init(builder: FirebaseAuthHelperProtocol = FirebaseAuthHelper()) {
        self.builder = builder
    }
    
    func fetchUserConnectNotifications(_ request: ProfileDetails.Request.FetchNotifications, completion: @escaping (ProfileDetails.Response.AllNotifications) -> Void) {
        let newRequest = GetConnectNotificationRequest(userId: request.userId)
        builder.fetchUserConnectNotifications(request: newRequest) { response in
            switch response {
            case .success(let data):
                let newResponseData = ProfileDetails
                    .Response
                    .NotificationsResponseData(notifications: data)
                let newResponse = ProfileDetails
                    .Response
                    .AllNotifications
                    .success(newResponseData)
                completion(newResponse)
                break
            case .error:
                completion(.error)
            }
        }
    }
    
    func fetchCurrentUserId(_ request: ProfileDetails.Request.FetchCurrentUserId, completion: @escaping (ProfileDetails.Response.CurrentUserId) -> Void) {
        let newRequest = FetchCurrentUserIdRequest()
        builder.fetchCurrentUser(request: newRequest) { response in
            switch response {
            case .success(let data):
                let newResponse = ProfileDetails
                    .Response
                    .CurrentUserId
                    .success(data)
                completion(newResponse)
                break
            case .error:
                completion(.error)
            }
        }
    }
    
    func fetchCurrentUserData(_ request: ProfileDetails.Request.FetchCurrentUserData,
                              completion: @escaping (ProfileDetails.Response.CurrentUser) -> Void) {
        let newRequest = FetchUserDataRequest(userId: request.userId)
        builder.fetchUserData(request: newRequest) { response in
            switch response {
            case .success(let data):
                let newResponse = ProfileDetails
                    .Response
                    .CurrentUser.success(ProfileDetails
                        .Response
                        .CurrentUserResponseData(userData: data))
                completion(newResponse)
                break
            case .error:
                completion(.error)
            }
        }
    }
    
    func fetchProjectData(_ request: ProfileDetails.Request.ProjectInfo) {
        //TO DO
    }
    
    func fetchAddConnection(_ request: ProfileDetails.Request.NewConnectNotification,
                            completion: @escaping (ProfileDetails.Response.AddConnection) -> Void) {
        let notificationDict: [String : Any] = ["image": request.image,
                                                "email": request.email,
                                                "name": request.name,
                                                "ocupation": request.ocupation,
                                                "userId": request.fromUserId]
        var notifications = request.oldNotifications
        notifications.append(notificationDict)
        let newRequest = SaveNotificationsRequest(userId: request.toUserId,
                                                  notifications: notifications)
        builder.addConnectNotifications(request: newRequest) { response in
            switch response {
            case .success:
                completion(.success)
                break
            case .error(let error):
                completion(.error(error))
            }
        }
    }
}
