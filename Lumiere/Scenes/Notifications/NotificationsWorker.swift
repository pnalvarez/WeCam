//
//  NotificationsWorker.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol NotificationsWorkerProtocol {
    func fetchNotifications(_ request: Notifications.Request.FetchNotifications,
                            completion: @escaping (Notifications.Response.FetchNotifications) -> Void)
    func fetchImageData(_ request: Notifications.Request.FetchImageData,
                        completion: @escaping (Notifications.Response.FetchImageData) -> Void)
    func fetchUserData(_ request: Notifications.Request.FetchUserData,
                       completion: @escaping (Notifications.Response.FetchUser) -> Void)
}

class NotificationsWorker: NotificationsWorkerProtocol {
    
    private let builder: FirebaseAuthHelperProtocol
    
    init(builder: FirebaseAuthHelperProtocol = FirebaseAuthHelper()) {
        self.builder = builder
    }
    
    func fetchNotifications(_ request: Notifications.Request.FetchNotifications, completion: @escaping (Notifications.Response.FetchNotifications) -> Void) {
        let newRequest = GetConnectNotificationRequest(userId: request.userId)
        builder.fetchUserConnectNotifications(request: newRequest) { response in
            switch response {
            case .success(let data):
                let newResponse = Notifications
                    .Response
                    .FetchNotifications
                    .success(Notifications
                        .Response
                        .FetchNotificationsResponseData(notifications: data))
                completion(newResponse)
                break
            case .error:
                completion(.error)
                break
            }
        }
    }
    
    func fetchImageData(_ request: Notifications.Request.FetchImageData,
                        completion: @escaping (Notifications.Response.FetchImageData) -> Void) {
        request.url.getData { data, response, error in
            if let error = error {
                completion(.error(error))
            } else if let data = data {
                completion(.success(Notifications
                    .Response
                    .FetchImageDataResponseData(data: data)))
            }
        }
    }
    
    func fetchUserData(_ request: Notifications.Request.FetchUserData,
                       completion: @escaping (Notifications.Response.FetchUser) -> Void) {
        let newRequest = FetchUserDataRequest(userId: request.userId)
        builder.fetchUserData(request: newRequest) { response in
            switch response {
            case .success(let data):
                completion(.success(Notifications.Response.FetchUserResponseData(data: data)))
                break
            case .error:
                completion(.error)
                break
            }
        }
    }
}
