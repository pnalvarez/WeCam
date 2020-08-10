//
//  FirebaseAuthHelper.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import FirebaseAuth
import FirebaseAnalytics
import FirebaseFirestore
import FirebaseDatabase
import FirebaseStorage
import ObjectMapper

enum FirebaseErrors: String, Error {
    case parseError = "Ocorreu um erro"
    case genericError = "Ocorreu um erro genérico"
    case fetchConnectionsError = "Ocorreu um erro ao buscar as notificações"
    case connectUsersError = "Ocorreu um erro ao aceitar a solicitação"
    case signInError = "Ocorreu um erro ao tentar logar"
}

protocol FirebaseAuthHelperProtocol {
    func createUser(request: CreateUserRequest,
                    completion: @escaping (SignUp.Response.RegisterUser) -> Void)
    func registerUserData(request: SaveUserInfoRequest,
                          completion: @escaping (SignUp.Response.SaveUserInfo) -> Void)
    func fetchUserConnectNotifications<T: Mappable>(request: GetConnectNotificationRequest,
                                       completion: @escaping (BaseResponse<[T]>) -> Void)
    func addConnectNotifications(request: SaveNotificationsRequest,
                                 completion: @escaping (EmptyResponse) -> Void)
    func signInUser<T: Mappable>(request: SignInRequest,
                    completion: @escaping (BaseResponse<T>) -> Void)
    func fetchCurrentUser<T: Mappable>(request: FetchCurrentUserIdRequest,
                                       completion: @escaping (BaseResponse<T>) -> Void)
    func fetchUserData<T: Mappable>(request: FetchUserDataRequest,
                       completion: @escaping (BaseResponse<T>) -> Void)
    func fetchConnectUsers(request: ConnectUsersRequest,
                           completion: @escaping (EmptyResponse) -> Void)
    func fetchDeleteNotification(request: ConnectUsersRequest,
                                 completion: @escaping (EmptyResponse) -> Void)
    func fetchUserRelation<T: Mappable>(request: FetchUserRelationRequest,
                                        completion: @escaping (BaseResponse<T>) -> Void)
    func fetchRemoveConnection(request: [String : Any],
                                            completion: @escaping (EmptyResponse) -> Void)
    func fetchRemovePendingConnection(request: [String : Any],
                                      completion: @escaping (EmptyResponse) -> Void)
    func fetchRemoveSentConnectionRequest(request: [String : Any],
                                          completion: @escaping (EmptyResponse) -> Void)
    func fetchSendConnectionRequest(request: [String : Any],
                                    completion: @escaping (EmptyResponse) -> Void)
    func fetchAcceptConnection(request: [String : Any],
                               completion: @escaping (EmptyResponse) -> Void)
    func fetchCurrentUserConnections<T: Mappable>(completion: @escaping (BaseResponse<[T]>) -> Void)
}

class FirebaseAuthHelper: FirebaseAuthHelperProtocol {
    
    private let realtimeDB = Database.database().reference()
    private let authReference = Auth.auth()
    private let storage = Storage.storage().reference()
    
    func createUser(request: CreateUserRequest,
                    completion: @escaping (SignUp.Response.RegisterUser) -> Void) {
        authReference.createUser(withEmail: request.email,
                               password: request.password) { (response, error) in
            if let error = error {
                completion(.error(error))
                return
            } else {
                if let result = response {
                    let newResult = SignUp.Response.UserResponse(uid: result.user.uid)
                    completion(.success(newResult))
                }
            }
        }
    }
    
    func registerUserData(request: SaveUserInfoRequest,
                          completion: @escaping (SignUp.Response.SaveUserInfo) -> Void) {
        if let imageData = request.image {
            let profileImageReference = storage.child(Constants.profileImagesPath).child(request.userId)
            profileImageReference.putData(imageData, metadata: nil) { (metadata, error) in
                if let error = error {
                    completion(.error(error))
                }
                profileImageReference.downloadURL { (url, error) in
                    if let error = error {
                        completion(.error(error))
                    }
                    guard let url = url else {
                        completion(.genericError)
                        return
                    }
                    let urlString = url.absoluteString
                    let dictionary: [String : Any] = ["profile_image_url": urlString,
                                                      "name": request.name,
                                                      "email" : request.email,
                                                      "password" : request.password,
                                                      "phone_number": request.phoneNumber,
                                                      "professional_area": request.professionalArea,
                                                      "interest_cathegories": request.interestCathegories,
                                                      "connections_count": 0,
                                                      "connect_notifications": [],
                                                      "project_notifications": [],
                                                      "author_notifications": []]
                    
                    self.realtimeDB.child(Constants.usersPath).child(request.userId).updateChildValues(dictionary) {
                    (error, ref) in
                        if let error = error {
                            completion(.error(error))
                        } else {
                            completion(.success)
                        }
                    }
                }
            }
        }
    }
    
    func fetchUserConnectNotifications<T: Mappable>(request: GetConnectNotificationRequest,
                                       completion: @escaping (BaseResponse<Array<T>>) -> Void) {
        var notifications: Array<Any> = .empty
        realtimeDB
        .child(Constants.usersPath)
        .child(request.userId)
        .child("connect_notifications")
            .observeSingleEvent(of: .value) { snapshot in
                if snapshot.value is NSNull {
                    let response = Mapper<T>().mapArray(JSONArray: .empty)
                    completion(.success(response))
                    return
                } else if let values = snapshot.value as? Array<Any> {
                    notifications = values
                    guard let notificationsArray = notifications as? Array<[String : Any]> else {
                        completion(.error(FirebaseErrors.parseError))
                        return
                    }
                    let response = Mapper<T>().mapArray(JSONArray: notificationsArray)
                    completion(.success(response))
                    return
                } else {
                    completion(.error(FirebaseErrors.fetchConnectionsError))
                    return
                }
        }
    }
    
    func addConnectNotifications(request: SaveNotificationsRequest,
                                 completion: @escaping (EmptyResponse) -> Void) {
        var integerDict = [String : Any]()
        for index in 0..<request.notifications.count {
            integerDict["\(index)"] = request.notifications[index]
        }
        realtimeDB
            .child(Constants.usersPath)
            .child(request.toUserId)
            .updateChildValues(["connect_notifications": request.notifications]) { error, ref in
                if let error = error {
                    completion(.error(error))
                }
                self.realtimeDB
                    .child(Constants.usersPath)
                    .child(request.fromUserId)
                    .child("pending_connections").observeSingleEvent(of: .value) { snapshot in
                        guard var pendingConnections = snapshot.value as? Array<Any> else {
                            self.realtimeDB
                                .child(Constants.usersPath)
                                .child(request.fromUserId)
                                .updateChildValues(["pending_connections": [request.toUserId]]) { error, ref in
                                    if let error = error {
                                        completion(.error(error))
                                        return
                                    }
                                    completion(.success)
                                    return
                            }
                            completion(.error(FirebaseErrors.genericError))
                            return
                        }
                        pendingConnections.append(request.toUserId)
                        self.realtimeDB
                            .child(Constants.usersPath)
                            .child(request.fromUserId)
                            .updateChildValues(["pending_connections": pendingConnections]) { error, ref in
                                if let error = error {
                                    completion(.error(error))
                                    return
                                }
                                completion(.success)
                                return
                        }
                }
                completion(.error(FirebaseErrors.genericError))
        }
    }
    
    func signInUser<T: Mappable>(request: SignInRequest,
                    completion: @escaping (BaseResponse<T>) -> Void) {
        authReference.signIn(withEmail: request.email, password: request.password) { (credentials, error) in
            if let error = error {
                completion(.error(error))
                return
            } else {
                let response: [String : Any] = ["id": credentials?.user.uid ?? .empty]
                guard let signInResponse = Mapper<T>().map(JSON: response) else {
                    completion(.error(FirebaseErrors.parseError))
                    return
                }
                completion(.success(signInResponse))
            }
        }
    }
    
    func fetchCurrentUser<T: Mappable>(request: FetchCurrentUserIdRequest,
                          completion: @escaping (BaseResponse<T>) -> Void) {
        guard let id = Auth.auth().currentUser?.uid else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        realtimeDB
            .child(Constants.usersPath)
            .child(id)
            .observeSingleEvent(of: .value) { snapshot in
                if var value = snapshot.value as? [String : Any] {
                    value["id"] = id
                    guard let response = Mapper<T>().map(JSON: value) else {
                        completion(.error(FirebaseErrors.parseError))
                        return
                    }
                    completion(.success(response))
                    return
                }
                completion(.error(FirebaseErrors.genericError))
        }
    }
    
    func fetchUserData<T: Mappable>(request: FetchUserDataRequest,
                       completion: @escaping (BaseResponse<T>) -> Void) {
        realtimeDB
            .child(Constants.usersPath)
            .child(request.userId)
            .observeSingleEvent(of: .value) { snapshot in
                if let value = snapshot.value as? [String : Any] {
                    guard let response = Mapper<T>().map(JSON: value) else {
                        completion(.error(FirebaseErrors.parseError))
                        return
                    }
                    completion(.success(response))
                    return
                }
                completion(.error(FirebaseErrors.genericError))
        }
    }
    
    //MARK: **** Mehod name: fetchConnectUsers
    //This method takes to user ids and connect each other in the database
    func fetchConnectUsers(request: ConnectUsersRequest,
                           completion: @escaping (EmptyResponse) -> Void) {
        let fromUserConnections = realtimeDB
                                    .child(Constants.usersPath)
                                    .child(request.fromUserId)
        let toUserConnections = realtimeDB
                                .child(Constants.usersPath)
                                .child(request.toUserId)
        
        fromUserConnections.child("connections").observeSingleEvent(of: .value) { snapshot in
            if snapshot.value is NSNull {
                fromUserConnections.updateChildValues(["connections": [request.toUserId],
                                                       "connections_count": 1]) { error, ref in
                    if let error = error {
                        completion(.error(error))
                        return
                    }
                }
                toUserConnections.child("connections").observeSingleEvent(of: .value) { snapshot in
                    if snapshot.value is NSNull {
                        toUserConnections.updateChildValues(["connections" : [request.fromUserId],
                                                             "connections_count": 1]) { error, ref in
                            if let error = error {
                                completion(.error(error))
                                return
                            }
                            completion(.success)
                            return
                        }
                    }
                    else if var connections = snapshot.value as? Array<Any> {
                        connections.append(request.fromUserId)
                        toUserConnections.updateChildValues(["connections": [request.fromUserId],
                                                             "connections_count": 1]) { error, ref in
                            if let error = error {
                                completion(.error(error))
                                return
                            }
                        }
                        completion(.success)
                        return
                    }
                }
            }
            else if var connections = snapshot.value as? Array<Any> {
                connections.append(request.toUserId)
                fromUserConnections.updateChildValues(["connections": connections,
                                                       "connections_count": connections.count]) { error, ref in
                    if let error = error {
                        completion(.error(error))
                        return
                    }
                }
                toUserConnections.child("connections").observeSingleEvent(of: .value) { snapshot in
                    if snapshot.value is NSNull {
                        toUserConnections.updateChildValues(["connections" : [request.fromUserId],
                                                             "connections_count": 1 ]) { error, ref in
                            if let error = error {
                                completion(.error(error))
                                return
                            }
                            completion(.success)
                            return
                        }
                    }
                    else if var connections = snapshot.value as? Array<Any> {
                        connections.append(request.fromUserId)
                        toUserConnections.updateChildValues(["connections": connections,
                                                             "connections_count": connections.count]) { error, ref in
                            if let error = error {
                                completion(.error(error))
                                return
                            }
                        }
                        completion(.success)
                        return
                    }
                }
            }
            else {
                completion(.error(FirebaseErrors.genericError))
            }
        }
    }
    
    func fetchDeleteNotification(request: ConnectUsersRequest,
                                 completion: @escaping (EmptyResponse) -> Void) {
        realtimeDB
            .child(Constants.usersPath)
            .child(request.toUserId)
            .child("connect_notifications").observeSingleEvent(of: .value) { snapshot in
                guard var notifications = snapshot.value as? Array<Any> else {
                    completion(.error(FirebaseErrors.parseError))
                    return
                }
                notifications.removeAll {
                    if let notification = $0 as? [String : Any] {
                        if let userId = notification["userId"] as? String {
                            return userId == request.fromUserId
                        }
                    }
                    return false
                }
                self.realtimeDB
                    .child(Constants.usersPath)
                    .child(request.toUserId)
                    .updateChildValues(["connect_notifications": notifications]) { error, ref in
                        if let error = error {
                            completion(.error(error))
                        }
                        completion(.success)
                }
        }
    }
    
    func fetchUserRelation<T>(request: FetchUserRelationRequest,
                              completion: @escaping (BaseResponse<T>) -> Void) where T : Mappable {
        checkConnected(request: request) { result in
            if result {
                let response: [String : Any] = ["relation" : "CONNECTED"]
                guard let mappedResponse = Mapper<T>().map(JSON: response) else {
                    completion(.error(FirebaseErrors.parseError))
                    return
                }
                completion(.success(mappedResponse))
                return
            }
            self.checkPending(request: request) { result in
                if result {
                    let response: [String : Any] = ["relation" : "PENDING"]
                    guard let mappedResponse = Mapper<T>().map(JSON: response) else {
                        completion(.error(FirebaseErrors.parseError))
                        return
                    }
                    completion(.success(mappedResponse))
                    return
                }
                self.checkSent(request: request) { result in
                    if result {
                        let response: [String : Any] = ["relation" : "SENT"]
                        guard let mappedResponse = Mapper<T>().map(JSON: response) else {
                            completion(.error(FirebaseErrors.parseError))
                            return
                    }
                    completion(.success(mappedResponse))
                    return
                    }
                    let response: [String : Any] = ["relation" : "NOTHING"]
                    guard let mappedResponse = Mapper<T>().map(JSON: response) else {
                        completion(.error(FirebaseErrors.parseError))
                        return
                    }
                    completion(.success(mappedResponse))
                }
            }
        }
    }
    
    func fetchRemoveConnection(request: [String : Any],
                               completion: @escaping (EmptyResponse) -> Void) {
        if let userId = request["userId"] as? String,
            let currentUserId = authReference.currentUser?.uid {
            realtimeDB
                .child(Constants.usersPath)
                .child(userId)
                .child("connections")
                .observeSingleEvent(of: .value) { snapshot in
                    guard var connections = snapshot.value as? Array<Any> else {
                        completion(.error(FirebaseErrors.genericError))
                        return
                    }
                    connections.removeAll(where: { connection in
                        if let id = connection as? String {
                            return id == currentUserId
                        }
                        return false
                    })
                    self.realtimeDB
                        .child(Constants.usersPath)
                        .child(userId)
                        .updateChildValues(["connections": connections]) { error, ref in
                            if let error = error {
                                completion(.error(error))
                                return
                            }
                            self.realtimeDB
                                .child(Constants.usersPath)
                                .child(userId).updateChildValues(["connections_count": connections.count]) { error, ref in
                                    self.realtimeDB
                                        .child(Constants.usersPath)
                                        .child(currentUserId)
                                        .child("connections")
                                        .observeSingleEvent(of: .value) { snapshot in
                                            guard var connections = snapshot.value as? Array<Any> else {
                                                completion(.error(FirebaseErrors.genericError))
                                                return
                                            }
                                            connections.removeAll(where: { connection in
                                                if let id = connection as? String {
                                                    return id == userId
                                                }
                                                return false
                                            })
                                            self.realtimeDB
                                                .child(Constants.usersPath)
                                                .child(currentUserId)
                                                .updateChildValues(["connections": connections]) { error, ref in
                                                    if let error = error {
                                                        completion(.error(error))
                                                        return
                                                    }
                                                    self.realtimeDB
                                                        .child(Constants.usersPath)
                                                        .child(currentUserId).updateChildValues(["connections_count": connections.count]) { error, ref in
                                                            if let error = error {
                                                                completion(.error(error))
                                                                return
                                                            }
                                                            completion(.success)
                                                            return
                                                    }
                                            }
                                    }
                                    
                            }
                    }
            }
        }
    }
    
    func fetchRemovePendingConnection(request: [String : Any],
                                      completion: @escaping (EmptyResponse) -> Void) {
        if let userId = request["userId"] as? String,
            let currentUserId = authReference.currentUser?.uid {
            realtimeDB
                .child(Constants.usersPath)
                .child(currentUserId)
                .child("pending_connections")
                .observeSingleEvent(of: .value) { snapshot in
                    guard var pendingConnections = snapshot.value as? Array<Any> else {
                        completion(.error(FirebaseErrors.genericError))
                        return
                    }
                    pendingConnections.removeAll(where: { pendingConnection in
                        if let id = pendingConnection as? String {
                            return id == userId
                        }
                        return false
                    })
                    self.realtimeDB
                        .child(Constants.usersPath)
                        .child(currentUserId)
                        .updateChildValues(["pending_connections": pendingConnections]) { error, ref in
                            if let error = error {
                                completion(.error(error))
                                return
                            }
                            self.realtimeDB
                                .child(Constants.usersPath)
                                .child(userId)
                                .child("connect_notifications")
                                .observeSingleEvent(of: .value) { snapshot in
                                    guard var notifications = snapshot.value as? Array<Any> else {
                                        completion(.error(FirebaseErrors.genericError))
                                        return
                                    }
                                    notifications.removeAll(where: { notification in
                                        if let notification = notification as? [String : Any] {
                                            if let id = notification["userId"] as? String {
                                                return id == currentUserId
                                            }
                                        }
                                        return false
                                    })
                                    self.realtimeDB
                                        .child(Constants.usersPath)
                                        .child(userId)
                                        .updateChildValues(["connect_notifications": notifications]) { error, ref in
                                            if let error = error {
                                                completion(.error(error))
                                                return
                                            }
                                            completion(.success)
                                    }
                            }
                    }
            }
        }
    }
    
    func fetchRemoveSentConnectionRequest(request: [String : Any],
                                          completion: @escaping (EmptyResponse) -> Void) {
        if let userId = request["userId"] as? String,
            let currentUserId = authReference.currentUser?.uid {
            realtimeDB
                .child(Constants.usersPath)
                .child(currentUserId)
                .child("connect_notifications")
                .observeSingleEvent(of: .value) { snapshot in
                    guard var notifications = snapshot.value as? Array<Any> else {
                        completion(.error(FirebaseErrors.genericError))
                        return
                    }
                    notifications.removeAll(where: { notification in
                        if let notification = notification as? [String : Any],
                            let id = notification["userId"] as? String{
                            return id == currentUserId
                        }
                        return false
                    })
                    self.realtimeDB
                        .child(Constants.usersPath)
                        .child(currentUserId)
                        .updateChildValues(["connect_notifications": notifications]) { error, ref in
                            if let error = error {
                                completion(.error(error))
                                return
                            }
                            self.realtimeDB
                                .child(Constants.usersPath)
                                .child(userId)
                                .child("pending_connections")
                                .observeSingleEvent(of: .value) { snapshot in
                                    guard var pendingConnections = snapshot.value as? Array<Any> else {
                                        completion(.error(FirebaseErrors.genericError))
                                        return
                                    }
                                    pendingConnections.removeAll(where: { pendingConnection in
                                        if let id = pendingConnection as? String {
                                            return id == currentUserId
                                        }
                                        return false
                                    })
                                    self.realtimeDB
                                        .child(Constants.usersPath)
                                        .child(userId)
                                        .updateChildValues(["pending_connections": pendingConnections]) { error, ref in
                                            if let error = error {
                                                completion(.error(error))
                                                return
                                            }
                                            completion(.success)
                                    }
                            }
                    }
            }
        }
    }
    
    func fetchSendConnectionRequest(request: [String : Any],
                                    completion: @escaping (EmptyResponse) -> Void) {
        if let userId = request["userId"] as? String,
            let currentUserId = authReference.currentUser?.uid {
            realtimeDB
                .child(Constants.usersPath)
                .child(currentUserId)
                .child("pending_connections")
                .observeSingleEvent(of: .value) { snapshot in
                    var pendingArray: Array<Any>
                    if var pendingConnections = snapshot.value as? Array<Any> {
                        pendingConnections.append(userId)
                        pendingArray = pendingConnections
                    } else {
                        pendingArray = [userId]
                    }
                    self.realtimeDB
                        .child(Constants.usersPath)
                        .child(currentUserId)
                        .updateChildValues(["pending_connections": pendingArray]) { error, ref in
                            if let error = error {
                                completion(.error(error))
                                return
                            }
                            self.realtimeDB
                                .child(Constants.usersPath)
                                .child(currentUserId)
                                .observeSingleEvent(of: .value) { snapshot in
                                    if let user = snapshot.value as? [String : Any],
                                        let email = user["email"] as? String,
                                        let image = user["profile_image_url"] as? String,
                                        let name = user["name"] as? String,
                                        let ocupation = user["professional_area"] as? String {
                                        self.realtimeDB
                                            .child(Constants.usersPath)
                                            .child(userId)
                                            .child("connect_notifications")
                                            .observeSingleEvent(of: .value) { snapshot in
                                                var notificationsArray: Array<Any>
                                                if var notifications = snapshot.value as? Array<Any> {
                                                    notifications.append(
                                                        ["email": email,
                                                        "image": image,
                                                        "name": name,
                                                        "ocupation": ocupation,
                                                        "userId": currentUserId
                                                        ])
                                                    notificationsArray = notifications
                                                } else {
                                                    notificationsArray = [
                                                        ["email": email,
                                                         "image": image,
                                                         "name": name,
                                                         "ocupation": ocupation,
                                                        "userId": currentUserId
                                                                        ]
                                                    ]
                                                }
                                                self.realtimeDB
                                                    .child(Constants.usersPath)
                                                    .child(userId)
                                                    .updateChildValues(["connect_notifications": notificationsArray]) { error, ref in
                                                        if let error = error {
                                                            completion(.error(error))
                                                            return
                                                        }
                                                        completion(.success)
                                                        return
                                                }
                                        }
                                    } else {
                                        completion(.error(FirebaseErrors.parseError))
                                    }
                            }
                    }
            }
        }
    }
    
    func fetchAcceptConnection(request: [String : Any],
                               completion: @escaping (EmptyResponse) -> Void) {
        if let userId = request["userId"] as? String,
            let currentUserId = authReference.currentUser?.uid {
            realtimeDB
                .child(Constants.usersPath)
                .child(currentUserId)
                .child("connect_notifications")
                .observeSingleEvent(of: .value) { snapshot in
                    guard var notifications = snapshot.value as? Array<Any> else {
                        completion(.error(FirebaseErrors.genericError))
                        return
                    }
                    notifications.removeAll(where: { notification in
                        if let notification = notification as? [String : Any],
                            let id = notification["userId"] as? String {
                            return id == userId
                        }
                        return false
                    })
                    self.realtimeDB
                        .child(Constants.usersPath)
                        .child(currentUserId)
                        .updateChildValues(["connect_notifications": notifications]) { error, ref in
                            if let error = error {
                                completion(.error(error))
                                return
                            }
                            self.realtimeDB
                                .child(Constants.usersPath)
                                .child(userId)
                                .child("pending_connections")
                                .observeSingleEvent(of: .value) { snapshot in
                                    guard var pendingConnections = snapshot.value as? Array<Any> else {
                                        completion(.error(FirebaseErrors.genericError))
                                        return
                                    }
                                    pendingConnections.removeAll(where: { pendingConnection in
                                        if let id = pendingConnection as? String {
                                            return id == currentUserId
                                        }
                                        return false
                                    })
                                    self.realtimeDB
                                        .child(Constants.usersPath)
                                        .child(userId)
                                        .updateChildValues(["pending_connections": pendingConnections]) { error, ref in
                                            if let error = error {
                                                completion(.error(error))
                                                return
                                            }
                                            self.fetchConnectUsers(request: ConnectUsersRequest(
                                                fromUserId: userId,
                                                toUserId: currentUserId)) { response in
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
                    }
            }
        }
    }
    
    func fetchCurrentUserConnections<T: Mappable>(completion: @escaping (BaseResponse<[T]>) -> Void) {
        var responseConnections = [[String : Any]]()
        if let currentUserId = authReference.currentUser?.uid {
            realtimeDB
                .child(Constants.usersPath)
                .child(currentUserId)
                .child("connections")
                .observeSingleEvent(of: .value) { snapshot in
                    guard let connections = snapshot.value as? Array<Any> else {
                        let response = Mapper<T>().mapArray(JSONArray: [])
                        completion(.success(response))
                        return
                    }
                    for connection in connections {
                        guard let connectionId = connection as? String else {
                            completion(.error(FirebaseErrors.parseError))
                            return
                        }
                        self.realtimeDB
                            .child(Constants.usersPath)
                            .child(connectionId)
                            .observeSingleEvent(of: .value) { snapshot in
                                guard let response = snapshot.value as? [String : Any] else {
                                    completion(.error(FirebaseErrors.genericError))
                                    return
                                }
                                if let name = response["name"] as? String,
                                    let ocupation = response["professional_area"] as? String,
                                    let image = response["profile_image_url"] as? String {
                                    let newJson: [String : Any] = ["name": name,
                                                                   "ocupation" : ocupation,
                                                                   "image": image,
                                                                   "userId": connectionId]
                                    responseConnections.append(newJson)
                                    let mappedResponse = Mapper<T>().mapArray(JSONArray: responseConnections)
                                    completion(.success(mappedResponse))
                                }
                        }
                    }
            }
        } else {
            completion(.error(FirebaseErrors.genericError))
        }
    }
}

//MARK: User Relationships
extension FirebaseAuthHelper {
    
    private func checkConnected(request: FetchUserRelationRequest,
                                completion: @escaping (Bool) -> Void) {
        realtimeDB
            .child(Constants.usersPath)
            .child(request.fromUserId)
            .child("connections").observeSingleEvent(of: .value) { snapshot in
                guard let connections = snapshot.value as? Array<Any> else {
                    completion(false)
                    return
                }
                if connections.contains(where: { connection in
                    if let userId = connection as? String {
                        return userId == request.toUserId
                    }
                    return false
                }) {
                    completion(true)
                    return
                }
                completion(false)
        }
    }
    
    private func checkPending(request: FetchUserRelationRequest,
                              completion: @escaping (Bool) -> Void) {
        realtimeDB
            .child(Constants.usersPath)
            .child(request.fromUserId)
            .child("pending_connections").observeSingleEvent(of: .value) { snapshot in
                guard let pendingConnections = snapshot.value as? Array<Any> else {
                    completion(false)
                    return
                }
                if pendingConnections.contains(where: { connection in
                    if let userId = connection as? String {
                        return userId == request.toUserId
                    }
                    return false
                }) {
                    completion(true)
                    return
                }
                completion(false)
        }
    }
    
    private func checkSent(request: FetchUserRelationRequest,
                           completion: @escaping (Bool) -> Void) {
        realtimeDB
            .child(Constants.usersPath)
            .child(request.toUserId)
            .child("pending_connections").observeSingleEvent(of: .value) { snapshot in
                guard let pendingConnections = snapshot.value as? Array<Any> else {
                    completion(false)
                    return
                }
                if pendingConnections.contains(where: { connection in
                    if let userId = connection as? String {
                        return userId == request.fromUserId
                    }
                    return false
                }) {
                    completion(true)
                    return
                }
                completion(false)
        }
    }
}

