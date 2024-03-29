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

protocol FirebaseManagerProtocol {
    func createUser(request: CreateUserRequest,
                    completion: @escaping (SignUp.Response.RegisterUser) -> Void)
    func registerUserData(request: SaveUserInfoRequest,
                          completion: @escaping (SignUp.Response.SaveUserInfo) -> Void)
    func fetchUserConnectNotifications<T: Mappable>(request: GetConnectNotificationRequest,
                                                    completion: @escaping (BaseResponse<[T]>) -> Void)
    func fetchSignInUser<T: Mappable>(request: [String : Any],
                                      completion: @escaping (BaseResponse<T>) -> Void)
    func fetchCurrentUser<T: Mappable>(request: [String : Any],
                                       completion: @escaping (BaseResponse<T>) -> Void)
    func fetchUserData<T: Mappable>(request: [String : Any],
                                    completion: @escaping (BaseResponse<T>) -> Void)
    func fetchConnectUsers(request: [String : Any],
                           completion: @escaping (EmptyResponse) -> Void)
    func fetchUserRelation<T: Mappable>(request: [String : Any],
                                        completion: @escaping (BaseResponse<T>) -> Void)
    func fetchRemoveConnection(request: [String : Any],
                               completion: @escaping (EmptyResponse) -> Void)
    func fetchRemovePendingConnection(request: [String : Any],
                                      completion: @escaping (EmptyResponse) -> Void)
    func fetchSendConnectionRequest(request: [String : Any],
                                    completion: @escaping (EmptyResponse) -> Void)
    func fetchAcceptConnection(request: [String : Any],
                               completion: @escaping (EmptyResponse) -> Void)
    func fetchCurrentUserConnections<T: Mappable>(completion: @escaping (BaseResponse<[T]>) -> Void)
    func fetchUserConnections<T: Mappable>(request: [String : Any],
                                           completion: @escaping (BaseResponse<[T]>) -> Void)
    func fetchRefusePendingConnection(request: [String: Any],
                                      completion: @escaping (EmptyResponse) -> Void)
    func fetchSignOut(request: [String : Any],
                      completion: @escaping (EmptyResponse) -> Void)
    func fetchCreateProject<T: Mappable>(request: [String : Any],
                                         completion: @escaping (BaseResponse<T>) -> Void)
    func fetchProjectWorking<T: Mappable>(request: [String : Any],
                                          completion: @escaping (BaseResponse<T>) -> Void)
    func updateUserData(request: [String : Any],
                        completion: @escaping (EmptyResponse) -> Void)
    func inviteUserToProject(request: [String : Any],
                             completion: @escaping (EmptyResponse) -> Void)
    func fetchProjectRelation<T: Mappable>(request: [String : Any],
                                           completion: @escaping (BaseResponse<T>) -> Void)
    func updateProjectInfo(request: [String : Any],
                           completion: @escaping (EmptyResponse) -> Void)
    func updateProjectImage<T: Mappable>(request: [String : Any],
                                         completion: @escaping (BaseResponse<T>) -> Void)
    func updateProjectNeedingField(request: [String : Any],
                                   completion: @escaping (EmptyResponse) -> Void)
    func fetchUserParticipatingProjects<T: Mappable>(request: [String : Any],
                                                     completion: @escaping (BaseResponse<[T]>) -> Void)
    func fetchProjectInvites<T: Mappable>(request: [String : Any],
                                          completion: @escaping (BaseResponse<[T]>) -> Void)
    func acceptProjectInvite(request: [String : Any],
                             completion: @escaping (EmptyResponse) -> Void)
    func fetchProjectParticipants<T: Mappable>(request: [String : Any],
                                               completion: @escaping (BaseResponse<[T]>) -> Void)
    func refuseProjectInvite(request: [String : Any],
                             completion: @escaping (EmptyResponse) -> Void)
    func sendProjectParticipationRequest(request: [String : Any],
                                         completion: @escaping (EmptyResponse) -> Void)
    func removeProjectParticipationRequest(request: [String : Any],
                                           completion: @escaping (EmptyResponse) -> Void)
    func exitProject(request: [String : Any],
                     completion: @escaping (EmptyResponse) -> Void)
    func fetchProjectParticipationRequestNotifications<T: Mappable>(request: [String : Any],
                                                                    completion: @escaping (BaseResponse<[T]>) -> Void)
    func acceptUserIntoProject(request: [String : Any],
                               completion: @escaping (EmptyResponse) -> Void)
    func refuseUserIntoProject(request: [String : Any],
                               completion: @escaping (EmptyResponse) -> Void)
    func fetchUserRelationToOnGoingProject<T: Mappable>(request: [String : Any],
                                                 completion: @escaping (BaseResponse<T>) -> Void)
    func removeProjectInviteToUser(request: [String : Any],
                                   completion: @escaping (EmptyResponse) -> Void)
    func removeUserFromProject(request: [String : Any],
                               completion: @escaping (EmptyResponse) -> Void)
    func fetchCurrentUserAuthoringProjects<T: Mappable>(request: [String : Any],
                                                        completion: @escaping (BaseResponse<[T]>) -> Void)
    func updateProjectProgress(request: [String : Any],
                               completion: @escaping (EmptyResponse) -> Void)
    func fetchSearchProfiles<T: Mappable>(request: [String : Any],
                                          completion: @escaping (BaseResponse<[T]>) -> Void)
    func fetchSearchOngoingProjects<T: Mappable>(request: [String : Any],
                                          completion: @escaping (BaseResponse<[T]>) -> Void)
    func fetchSearchFinishedProjects<T: Mappable>(request: [String : Any],
                                                  completion: @escaping (BaseResponse<[T]>) -> Void)
    func fetchDataFromId<T: Mappable>(request: [String : Any],
                                      completion: @escaping (BaseResponse<T>) -> Void)
    func fetchGeneralProfileSuggestions<T: Mappable>(request: [String : Any],
                                                     completion: @escaping (BaseResponse<[T]>) -> Void)
    func fetchCommonConnectionsProfileSuggestions<T: Mappable>(request: [String : Any],
                                                               completion: @escaping (BaseResponse<[T]>) -> Void)
    func fetchCommonProjectsProfileSuggestions<T: Mappable>(request: [String : Any],
                                                            completion: @escaping (BaseResponse<[T]>) -> Void)
    func fetchCommonCathegoriesProfileSuggestions<T: Mappable>(request: [String : Any],
                                                               completion: @escaping (BaseResponse<[T]>) -> Void)
    func removeProfileSuggestion(request: [String : Any],
                                 completion: @escaping (EmptyResponse) -> Void)
    func fetchOnGoingProjectsFeed<T: Mappable>(request: [String : Any],
                                               completion: @escaping (BaseResponse<[T]>) -> Void)
    func publishProject(request: [String : Any],
                        completion: @escaping (EmptyResponse) -> Void)
    func fetchFinishedProjectData<T: Mappable>(request: [String : Any],
                                               completion: @escaping (BaseResponse<T>) -> Void)
    func fetchFinishedProjectRelation<T: Mappable>(request: [String : Any],
                                                   completion: @escaping (BaseResponse<T>) -> Void)
    func fetchUserFinishedProjects<T: Mappable>(request: [String : Any],
                                                completion: @escaping (BaseResponse<[T]>) -> Void)
    func publishNewProject<T: Mappable>(request: [String : Any],
                                        completion: @escaping (BaseResponse<T>) -> Void)
    func addViewToProject(request: [String : Any],
                          completion: @escaping (EmptyResponse) -> Void)
    func fetchFinishedProjectsLogicFeed<T: Mappable>(request: [String : Any],
                                                     completion: @escaping (BaseResponse<[T]>) -> Void)
    func fetchFinishedProjectCathegoryFeed<T: Mappable>(request: [String : Any],
                                                        completion: @escaping (BaseResponse<[T]>) -> Void)
    func fetchFinishedProjectsNewFeed<T: Mappable>(request: [String : Any],
                                                   completion: @escaping (BaseResponse<[T]>) -> Void)
    func inviteUserToFinishedProject(request: [String : Any],
                                     completion: @escaping (EmptyResponse) -> Void)
    func fetchFinishedProjectInviteNotifications<T: Mappable>(request: [String : Any],
                                                              completion: @escaping (BaseResponse<[T]>) -> Void)
    func acceptFinishedProjectInvite(request: [String : Any],
                                     completion: @escaping (EmptyResponse) -> Void)
    
    func refuseFinishedProjectInvite(request: [String : Any],
                                     completion: @escaping (EmptyResponse) -> Void)
    func fetchUserRelationToFinishedProject<T: Mappable>(request: [String : Any],
                                                         completion: @escaping (BaseResponse<T>) -> Void)
    func removeInviteToFinishedProjectFromUser(request: [String : Any],
                                               completion: @escaping (EmptyResponse) -> Void)
    func fetchConnectionAcceptNotifications<T: Mappable>(request: [String : Any],
                                                         completion: @escaping (BaseResponse<[T]>) -> Void)
    func fetchProjectInviteAcceptNotifications<T: Mappable>(request: [String : Any],
                                                         completion: @escaping (BaseResponse<[T]>) -> Void)
    func fetchProjectParticipationAcceptNotifications<T: Mappable>(request: [String : Any],
                                                         completion: @escaping (BaseResponse<[T]>) -> Void)
    func sendPasswordRecoveryEmail(request: [String : Any],
                                   completion: @escaping (EmptyResponse) -> Void)
    func fetchUserDataByEmail<T: Mappable>(request: [String : Any],
                              completion: @escaping (BaseResponse<T>) -> Void)
    func fetchRecentSearches<T: Mappable>(request: [String : Any],
                                          completion: @escaping (BaseResponse<[T]>) -> Void)
    func registerRecentSearch(request: [String : Any],
                                   completion: @escaping (EmptyResponse) -> Void)
    func fetchEntityType<T: Mappable>(request: [String : Any],
                         completion: @escaping (BaseResponse<T>) -> Void)
}

class FirebaseManager: FirebaseManagerProtocol {
    
    private let realtimeDB = Database.database().reference()
    private let authReference = Auth.auth()
    private let storage = Storage.storage().reference()
    
    private let commonConnectionsScore: Int = 3
    private let commonProjectsScore: Int = 4
    private let commonCathegoriesScore: Int = 1
    
    private let connectionInProjectScore: Int = 1
    private let projectCathegoriesScore: Int = 3
    
    private let maxRecentSearches: Int = 10
    
    private var mutex: Bool = true //Profile details mutex
    
    private enum FinishedProjectsLogicCriteria: String {
        case connections = "Conexões"
        case popular = "Popular"
        case recent = "Recente"
    }
    
    private enum AcceptNotificationType {
        case connection(username: String? = nil, image: String? = nil)
        case projectInvite(username: String? = nil, projectName: String? = nil, image: String? = nil)
        case projectParticipationRequest(projectName: String? = nil, image: String? = nil)
        
        var notificationText: String {
            switch self {
            case .connection(let username, _):
                return "\(username ?? .empty) te aceitou como conexão"
            case .projectInvite(let username, let projectName,_):
                return "\(username ?? .empty) aceitou seu convite para o projeto \(projectName ?? .empty)"
            case .projectParticipationRequest(let projectName, _):
                return "Você foi aceito no projeto \(projectName ?? .empty)"
            }
        }
        
        var path: String {
            switch self {
            case .connection:
                return "connection_accept_notification"
            case .projectInvite:
                return "project_invite_accept_notification"
            case .projectParticipationRequest:
                return "project_participation_accept_notification"
            }
        }
        
        var image: String {
            switch self {
            case .connection(_, let image),
                 .projectInvite(_, _, let image),
                 .projectParticipationRequest(_, let image):
                return image ?? .empty
            }
        }
    }
    
    init() {
        realtimeDB.keepSynced(true)
    }
    
    func createUser(request: CreateUserRequest,
                    completion: @escaping (SignUp.Response.RegisterUser) -> Void) {
        
        authReference.createUser(withEmail: request.email,
                                 password: request.password) { (response, error) in
            if error != nil {
                completion(.error(WCError.createUser))
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
            let profileImageReference = storage.child(Paths.profileImagesPath).child(request.userId)
            profileImageReference.putData(imageData, metadata: nil) { (metadata, error) in
                if error != nil {
                    completion(.error(WCError.saveImage))
                }
                profileImageReference.downloadURL { (url, error) in
                    if error != nil {
                        completion(.error(WCError.saveImage))
                    }
                    guard let url = url else {
                        completion(.genericError)
                        return
                    }
                    let urlString = url.absoluteString
                    let dictionary: [String : Any] = ["profile_image_url": urlString,
                                                      "name": request.name,
                                                      "email" : request.email,
                                                      "phone_number": request.phoneNumber,
                                                      "professional_area": request.professionalArea,
                                                      "interest_cathegories": request.interestCathegories,
                                                      "connect_notifications": [],
                                                      "project_notifications": [],
                                                      "author_notifications": [],
                                                      "finished_project_invite_notifications": []]
                    
                    self.realtimeDB
                        .child(Paths.usersPath)
                        .child(request.userId)
                        .updateChildValues(dictionary) {
                            (error, ref) in
                            if error != nil {
                                completion(.error(WCError.createUser))
                            } else {
                                self.realtimeDB
                                    .child(Paths.allUsersCataloguePath)
                                    .observeSingleEvent(of: .value) { snapshot in
                                        var userIdsArray: [String]
                                        if let userIds = snapshot.value as? [String] {
                                            userIdsArray = userIds
                                        } else {
                                            userIdsArray = .empty
                                        }
                                        userIdsArray.append(request.userId)
                                        self.realtimeDB
                                            .updateChildValues([Paths.allUsersCataloguePath : userIdsArray]) { error, ref in
                                                if error != nil {
                                                    completion(.error(WCError.createUser))
                                                    return
                                                }
                                                self.realtimeDB.child(Paths.userEmailPath).updateChildValues([request.email.sha256() : request.userId]) {
                                                    error, ref in
                                                    if error != nil {
                                                        completion(.error(WCError.createUser))
                                                        return
                                                    }
                                                    self.registerEntity(withId: request.userId, type: .user) { response in
                                                        switch response {
                                                        case .error(let error):
                                                            completion(.error(WCError.createUser))
                                                        case .success:
                                                            completion(.success)
                                                        }
                                                    }
                                                }
                                            }
                                    }
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
            .child(Paths.usersPath)
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
                        completion(.error(WCError.parseError))
                        return
                    }
                    let response = Mapper<T>().mapArray(JSONArray: notificationsArray)
                    completion(.success(response))
                    return
                } else {
                    completion(.error(WCError.fetchConnectionsError))
                    return
                }
            }
    }
    
    func fetchSignInUser<T: Mappable>(request: [String : Any],
                                      completion: @escaping (BaseResponse<T>) -> Void) {
        if let email = request["email"] as? String,
           let password = request["password"] as? String {
            authReference.signIn(withEmail: email, password: password) { (credentials, error) in
                if error != nil {
                    completion(.error(WCError.signInError))
                    return
                } else {
                    let userId = self.authReference.currentUser?.uid ?? .empty
                    self.realtimeDB
                        .child(Paths.usersPath)
                        .child(userId)
                        .observeSingleEvent(of: .value) { snapshot in
                            guard var loggedUser = snapshot.value as? [String : Any] else {
                                completion(.error(WCError.genericError))
                                return
                            }
                            if let connections = loggedUser["connections"] as? Array<Any> {
                                loggedUser["connections_count"] = "\(connections.count)"
                            } else {
                                loggedUser["connections_count"] = "0"
                            }
                            loggedUser["id"] = userId
                            guard let signInResponse = Mapper<T>().map(JSON: loggedUser) else {
                                completion(.error(WCError.genericError))
                                return
                            }
                            completion(.success(signInResponse))
                        }
                }
            }
        } else {
            completion(.error(WCError.genericError))
        }
    }
    
    func fetchCurrentUser<T: Mappable>(request: [String : Any],
                                       completion: @escaping (BaseResponse<T>) -> Void) {
        guard let id = Auth.auth().currentUser?.uid else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.usersPath)
            .child(id)
            .observeSingleEvent(of: .value) { snapshot in
                if var value = snapshot.value as? [String : Any] {
                    value["id"] = id
                    guard let response = Mapper<T>().map(JSON: value) else {
                        completion(.error(WCError.parseError))
                        return
                    }
                    completion(.success(response))
                    return
                }
                completion(.error(WCError.genericError))
            }
    }
    
    func fetchUserData<T: Mappable>(request: [String : Any],
                                    completion: @escaping (BaseResponse<T>) -> Void) {
        if let userId = request["userId"] as? String {
            realtimeDB
                .child(Paths.usersPath)
                .child(userId)
                .observeSingleEvent(of: .value) { snapshot in
                    if var value = snapshot.value as? [String : Any] {
                        value["userId"] = userId
                        if let connections = value["connections"] as? [String] {
                            value["connections_count"] = connections.count
                        } else {
                            value["connections_count"] = 0
                        }
                        guard let response = Mapper<T>().map(JSON: value) else {
                            completion(.error(WCError.parseError))
                            return
                        }
                        completion(.success(response))
                        return
                    }
                    completion(.error(WCError.genericError))
                }
        }
    }
    
    //MARK: **** Mehod name: fetchConnectUsers
    //This method takes two user ids and connect each other in the database
    func fetchConnectUsers(request: [String : Any],
                           completion: @escaping (EmptyResponse) -> Void) {
        if let fromUserId = request["fromUserId"] as? String,
           let toUserId = request["toUserId"] as? String {
            let fromUserConnections = realtimeDB
                .child(Paths.usersPath)
                .child(fromUserId)
            let toUserConnections = realtimeDB
                .child(Paths.usersPath)
                .child(toUserId)
            
            fromUserConnections.child("connections").observeSingleEvent(of: .value) { snapshot in
                if snapshot.value is NSNull {
                    fromUserConnections.updateChildValues(["connections": [toUserId]]) { error, ref in
                        if error != nil {
                            completion(.error(WCError.removeConnection))
                            return
                        }
                    }
                    toUserConnections.child("connections").observeSingleEvent(of: .value) { snapshot in
                        if snapshot.value is NSNull {
                            toUserConnections.updateChildValues(["connections" : [fromUserId]]) { error, ref in
                                if error != nil {
                                    completion(.error(WCError.userConnectionError))
                                    return
                                }
                                completion(.success)
                                return
                            }
                        }
                        else if var connections = snapshot.value as? Array<Any> {
                            connections.append(fromUserId)
                            toUserConnections.updateChildValues(["connections": [fromUserId]]) { error, ref in
                                if error != nil {
                                    completion(.error(WCError.userConnectionError))
                                    return
                                }
                            }
                            completion(.success)
                            return
                        }
                    }
                }
                else if var connections = snapshot.value as? Array<Any> {
                    connections.append(toUserId)
                    fromUserConnections.updateChildValues(["connections": connections]) { error, ref in
                        if error != nil {
                            completion(.error(WCError.userConnectionError))
                            return
                        }
                    }
                    toUserConnections.child("connections").observeSingleEvent(of: .value) { snapshot in
                        if snapshot.value is NSNull {
                            toUserConnections.updateChildValues(["connections" : [fromUserId]]) { error, ref in
                                if error != nil {
                                    completion(.error(WCError.userConnectionError))
                                    return
                                }
                                completion(.success)
                                return
                            }
                        }
                        else if var connections = snapshot.value as? Array<Any> {
                            connections.append(fromUserId)
                            toUserConnections.updateChildValues(["connections": connections]) { error, ref in
                                if error != nil {
                                    completion(.error(WCError.userConnectionError))
                                    return
                                }
                            }
                            completion(.success)
                            return
                        }
                    }
                }
                else {
                    completion(.error(WCError.genericError))
                }
            }
        } else {
            completion(.error(WCError.genericError))
        }
    }
    
    func fetchUserRelation<T>(request: [String : Any],
                              completion: @escaping (BaseResponse<T>) -> Void) where T : Mappable {
        guard let currentUser = authReference.currentUser?.uid else {
            completion(.error(WCError.genericError))
            return
        }
        guard let userId = request["userId"] as? String else {
            completion(.error(WCError.genericError))
            return
        }
        if currentUser == userId {
            let response: [String : Any] = ["relation" : "LOGGED"]
            guard let mappedResponse = Mapper<T>().map(JSON: response) else {
                completion(.error(WCError.parseError))
                return
            }
            completion(.success(mappedResponse))
            return
        }
        let request = FetchUserRelationRequest(fromUserId: currentUser, toUserId: userId)
        checkConnected(request: request) { result in
            if result {
                let response: [String : Any] = ["relation" : "CONNECTED"]
                guard let mappedResponse = Mapper<T>().map(JSON: response) else {
                    completion(.error(WCError.parseError))
                    return
                }
                completion(.success(mappedResponse))
                return
            }
            self.checkPending(request: request) { result in
                if result {
                    let response: [String : Any] = ["relation" : "PENDING"]
                    guard let mappedResponse = Mapper<T>().map(JSON: response) else {
                        completion(.error(WCError.parseError))
                        return
                    }
                    completion(.success(mappedResponse))
                    return
                }
                self.checkSent(request: request) { result in
                    if result {
                        let response: [String : Any] = ["relation" : "SENT"]
                        guard let mappedResponse = Mapper<T>().map(JSON: response) else {
                            completion(.error(WCError.parseError))
                            return
                        }
                        completion(.success(mappedResponse))
                        return
                    }
                    let response: [String : Any] = ["relation" : "NOTHING"]
                    guard let mappedResponse = Mapper<T>().map(JSON: response) else {
                        completion(.error(WCError.parseError))
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
                .child(Paths.usersPath)
                .child(userId)
                .child("connections")
                .observeSingleEvent(of: .value) { snapshot in
                    guard var connections = snapshot.value as? Array<Any> else {
                        completion(.error(WCError.genericError))
                        self.mutex = true
                        return
                    }
                    connections.removeAll(where: { connection in
                        if let id = connection as? String {
                            return id == currentUserId
                        }
                        return false
                    })
                    self.realtimeDB
                        .child(Paths.usersPath)
                        .child(userId)
                        .updateChildValues(["connections": connections]) { error, ref in
                            if error != nil {
                                completion(.error(WCError.userConnectionError))
                                self.mutex = true
                                return
                            }
                            self.realtimeDB
                                .child(Paths.usersPath)
                                .child(currentUserId)
                                .child("connections")
                                .observeSingleEvent(of: .value) { snapshot in
                                    guard var connections = snapshot.value as? Array<Any> else {
                                        completion(.error(WCError.genericError))
                                        self.mutex = true
                                        return
                                    }
                                    connections.removeAll(where: { connection in
                                        if let id = connection as? String {
                                            return id == userId
                                        }
                                        return false
                                    })
                                    self.realtimeDB
                                        .child(Paths.usersPath)
                                        .child(currentUserId)
                                        .updateChildValues(["connections": connections]) { error, ref in
                                            if error != nil {
                                                completion(.error(WCError.removeConnection))
                                                self.mutex = true
                                                return
                                            }
                                            self.mutex = true
                                            completion(.success)
                                        }
                                }
                        }
                }
        }
    }
    
    func fetchRemovePendingConnection(request: [String : Any],
                                      completion: @escaping (EmptyResponse) -> Void) {
        guard mutex else {
            return
        }
        mutex = false
        if let userId = request["userId"] as? String,
           let currentUserId = authReference.currentUser?.uid {
            realtimeDB
                .child(Paths.usersPath)
                .child(currentUserId)
                .child("pending_connections")
                .observeSingleEvent(of: .value) { snapshot in
                    guard var pendingConnections = snapshot.value as? Array<Any> else {
                        completion(.error(WCError.genericError))
                        self.mutex = true
                        return
                    }
                    pendingConnections.removeAll(where: { pendingConnection in
                        if let id = pendingConnection as? String {
                            return id == userId
                        }
                        return false
                    })
                    self.realtimeDB
                        .child(Paths.usersPath)
                        .child(currentUserId)
                        .updateChildValues(["pending_connections": pendingConnections]) { error, ref in
                            if error != nil {
                                completion(.error(WCError.removePendingConnection))
                                self.mutex = true
                                return
                            }
                            self.realtimeDB
                                .child(Paths.usersPath)
                                .child(userId)
                                .child("connect_notifications")
                                .observeSingleEvent(of: .value) { snapshot in
                                    guard var notifications = snapshot.value as? Array<Any> else {
                                        completion(.error(WCError.genericError))
                                        self.mutex = true
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
                                        .child(Paths.usersPath)
                                        .child(userId)
                                        .updateChildValues(["connect_notifications": notifications]) { error, ref in
                                            if error != nil {
                                                completion(.error(WCError.removePendingConnection))
                                                self.mutex = true
                                                return
                                            }
                                            completion(.success)
                                            self.mutex = true
                                        }
                                }
                        }
                }
        } else {
            self.mutex = true
        }
    }
    
    func fetchSendConnectionRequest(request: [String : Any],
                                    completion: @escaping (EmptyResponse) -> Void) {
        guard mutex else {
            return
        }
        mutex = false
        if let userId = request["userId"] as? String,
           let currentUserId = authReference.currentUser?.uid {
            realtimeDB
                .child(Paths.usersPath)
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
                        .child(Paths.usersPath)
                        .child(currentUserId)
                        .updateChildValues(["pending_connections": pendingArray]) { error, ref in
                            if error != nil {
                                completion(.error(WCError.sendConnectionRequest))
                                self.mutex = true
                                return
                            }
                            self.realtimeDB
                                .child(Paths.usersPath)
                                .child(currentUserId)
                                .observeSingleEvent(of: .value) { snapshot in
                                    if let user = snapshot.value as? [String : Any],
                                       let email = user["email"] as? String,
                                       let image = user["profile_image_url"] as? String,
                                       let name = user["name"] as? String,
                                       let ocupation = user["professional_area"] as? String {
                                        self.realtimeDB
                                            .child(Paths.usersPath)
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
                                                    .child(Paths.usersPath)
                                                    .child(userId)
                                                    .updateChildValues(["connect_notifications": notificationsArray]) { error, ref in
                                                        if error != nil {
                                                            completion(.error(WCError.sendConnectionRequest))
                                                            self.mutex = true
                                                            return
                                                        }
                                                        completion(.success)
                                                        self.mutex = true
                                                        return
                                                    }
                                            }
                                    } else {
                                        completion(.error(WCError.parseError))
                                        self.mutex = true
                                    }
                                }
                        }
                }
        }
    }
    
    func fetchAcceptConnection(request: [String : Any],
                               completion: @escaping (EmptyResponse) -> Void) {
        guard mutex else {
            return
        }
        mutex = false
        if let userId = request["userId"] as? String,
           let currentUserId = authReference.currentUser?.uid {
            realtimeDB
                .child(Paths.usersPath)
                .child(currentUserId)
                .child("connect_notifications")
                .observeSingleEvent(of: .value) { snapshot in
                    guard var notifications = snapshot.value as? Array<Any> else {
                        completion(.error(WCError.genericError))
                        self.mutex = true
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
                        .child(Paths.usersPath)
                        .child(currentUserId)
                        .updateChildValues(["connect_notifications": notifications]) { error, ref in
                            if error != nil {
                                completion(.error(WCError.userConnectionError))
                                self.mutex = true
                                return
                            }
                            self.realtimeDB
                                .child(Paths.usersPath)
                                .child(userId)
                                .child("pending_connections")
                                .observeSingleEvent(of: .value) { snapshot in
                                    guard var pendingConnections = snapshot.value as? Array<Any> else {
                                        completion(.error(WCError.genericError))
                                        self.mutex = true
                                        return
                                    }
                                    pendingConnections.removeAll(where: { pendingConnection in
                                        if let id = pendingConnection as? String {
                                            return id == currentUserId
                                        }
                                        return false
                                    })
                                    self.realtimeDB
                                        .child(Paths.usersPath)
                                        .child(userId)
                                        .updateChildValues(["pending_connections": pendingConnections]) { error, ref in
                                            if error != nil {
                                                completion(.error(WCError.userConnectionError))
                                                self.mutex = true
                                                return
                                            }
                                            self.realtimeDB
                                                .child(Paths.usersPath)
                                                .child(currentUserId)
                                                .observeSingleEvent(of: .value) { snapshot in
                                                    guard let data = snapshot.value as? [String : Any], let name = data["name"] as? String, let image = data["profile_image_url"] as? String else {
                                                        completion(.error(WCError.genericError))
                                                        self.mutex = true
                                                        return
                                                    }
                                                    self.sendAcceptNotification(type: .connection(username: name, image: image), userId: userId) { response in
                                                        switch response {
                                                        case .success:
                                                            self.fetchConnectUsers(request: ["fromUserId": userId,
                                                                                             "toUserId": currentUserId]) { response in
                                                                switch response {
                                                                case .success:
                                                                    completion(.success)
                                                                    self.mutex = true
                                                                    break
                                                                case .error( _):
                                                                    completion(.error(WCError.userConnectionError))
                                                                    self.mutex = true
                                                                }
                                                            }
                                                        case .error( _):
                                                            completion(.error(WCError.userConnectionError))
                                                            self.mutex = true
                                                            return
                                                        }
                                                    }
                                            }
                                        }
                                }
                        }
                }
        } else {
            self.mutex = true
        }
    }
    
    func fetchCurrentUserConnections<T: Mappable>(completion: @escaping (BaseResponse<[T]>) -> Void) {
        var responseConnections = [[String : Any]]()
        if let currentUserId = authReference.currentUser?.uid {
            realtimeDB
                .child(Paths.usersPath)
                .child(currentUserId)
                .child("connections")
                .observeSingleEvent(of: .value) { snapshot in
                    guard let connections = snapshot.value as? Array<Any> else {
                        let response = Mapper<T>().mapArray(JSONArray: [])
                        completion(.success(response))
                        return
                    }
                    for i in 0..<connections.count {
                        guard let connectionId = connections[i] as? String else {
                            completion(.error(WCError.parseError))
                            return
                        }
                        self.realtimeDB
                            .child(Paths.usersPath)
                            .child(connectionId)
                            .observeSingleEvent(of: .value) { snapshot in
                                guard let response = snapshot.value as? [String : Any] else {
                                    completion(.error(WCError.genericError))
                                    return
                                }
                                if let name = response["name"] as? String,
                                   let ocupation = response["professional_area"] as? String,
                                   let image = response["profile_image_url"] as? String,
                                   let email = response["email"] as? String {
                                    let newJson: [String : Any] = ["name": name,
                                                                   "ocupation" : ocupation,
                                                                   "image": image,
                                                                   "userId": connectionId,
                                                                   "email": email]
                                    responseConnections.append(newJson)
                                    if i == connections.count-1 {
                                        let mappedResponse = Mapper<T>().mapArray(JSONArray: responseConnections)
                                        completion(.success(mappedResponse))
                                    }
                                }
                            }
                    }
                }
        } else {
            completion(.error(WCError.genericError))
        }
    }
    
    func fetchUserConnections<T>(request: [String : Any],
                                 completion: @escaping (BaseResponse<[T]>) -> Void) where T : Mappable {
        var responseConnections = [[String : Any]]()
        if let userId =  request["userId"] as? String {
            realtimeDB
                .child(Paths.usersPath)
                .child(userId)
                .child("connections")
                .observeSingleEvent(of: .value) { snapshot in
                    guard let connections = snapshot.value as? Array<Any> else {
                        let response = Mapper<T>().mapArray(JSONArray: [])
                        completion(.success(response))
                        return
                    }
                    for i in 0..<connections.count {
                        guard let connectionId = connections[i] as? String else {
                            completion(.error(WCError.parseError))
                            return
                        }
                        self.realtimeDB
                            .child(Paths.usersPath)
                            .child(connectionId)
                            .observeSingleEvent(of: .value) { snapshot in
                                guard let response = snapshot.value as? [String : Any] else {
                                    completion(.error(WCError.genericError))
                                    return
                                }
                                if let name = response["name"] as? String,
                                   let ocupation = response["professional_area"] as? String,
                                   let email = response["email"] as? String,
                                   let image = response["profile_image_url"] as? String {
                                    let newJson: [String : Any] = ["name": name,
                                                                   "ocupation" : ocupation,
                                                                   "email": email,
                                                                   "image": image,
                                                                   "userId": connectionId]
                                    responseConnections.append(newJson)
                                    if i == connections.count-1 {
                                        let mappedResponse = Mapper<T>().mapArray(JSONArray: responseConnections)
                                        completion(.success(mappedResponse))
                                    }
                                }
                            }
                    }
                }
        } else {
            completion(.error(WCError.genericError))
        }
    }
    
    func fetchRefusePendingConnection(request: [String : Any],
                                      completion: @escaping (EmptyResponse) -> Void) {
        if let userId = request["userId"] as? String,
           let currentUserId = authReference.currentUser?.uid {
            realtimeDB
                .child(Paths.usersPath)
                .child(userId)
                .child("pending_connections")
                .observeSingleEvent(of: .value) { snapshot in
                    guard var pendingConnections = snapshot.value as? Array<Any> else {
                        completion(.error(WCError.genericError))
                        return
                    }
                    pendingConnections.removeAll(where: { pendingConnection in
                        if let id = pendingConnection as? String {
                            return id == currentUserId
                        }
                        return false
                    })
                    self.realtimeDB
                        .child(Paths.usersPath)
                        .child(userId)
                        .updateChildValues(["pending_connections": pendingConnections]) { error, ref in
                            if error != nil {
                                completion(.error(WCError.refuseRequest))
                                return
                            }
                            self.realtimeDB
                                .child(Paths.usersPath)
                                .child(currentUserId)
                                .child("connect_notifications")
                                .observeSingleEvent(of: .value) { snapshot in
                                    guard var notifications = snapshot.value as? Array<Any> else {
                                        completion(.error(WCError.genericError))
                                        return
                                    }
                                    notifications.removeAll(where: { notification in
                                        if let notification = notification as? [String : Any] {
                                            if let id = notification["userId"] as? String {
                                                return id == userId
                                            }
                                        }
                                        return false
                                    })
                                    self.realtimeDB
                                        .child(Paths.usersPath)
                                        .child(currentUserId)
                                        .updateChildValues(["connect_notifications": notifications]) { error, ref in
                                            if error != nil {
                                                completion(.error(WCError.refuseRequest))
                                                return
                                            }
                                            completion(.success)
                                        }
                                }
                        }
                }
        }
    }
    
    func fetchSignOut(request: [String : Any],
                      completion: @escaping (EmptyResponse) -> Void) {
        do {
            try authReference.signOut()
            completion(.success)
        } catch {
            completion(.error(WCError.signOut))
        }
    }
    
    func fetchCreateProject<T: Mappable>(request: [String : Any],
                                         completion: @escaping (BaseResponse<T>) -> Void) {
        if let payload = request["payload"] as? [String : Any],
           let image = payload["image"] as? Data?,
           let title = payload["title"] as? String,
           let cathegories = payload["cathegories"] as? Array<Any>,
           let percentage = payload["percentage"] as? Int,
           let sinopsis = payload["sinopsis"] as? String,
           let needing = payload["needing"] as? String,
           let currentUser = authReference.currentUser?.uid {
            let projectReference = realtimeDB
                .child(Paths.projectsPath)
                .child(Paths.ongoingProjectsPath)
                .childByAutoId()
            guard let projectId = projectReference.key,
                  let image = image else {
                completion(.error(WCError.genericError))
                return
            }
            let projectImageReference =  storage.child(Paths.projectsPath).child(projectId)
            projectImageReference.putData(image, metadata: nil) { (metadata, error) in
                if error != nil {
                    completion(.error(WCError.createProject))
                    return
                }
                projectImageReference.downloadURL { (url, error) in
                    if error != nil {
                        completion(.error(WCError.createProject))
                        return
                    }
                    guard let url = url else {
                        completion(.error(WCError.genericError))
                        return
                    }
                    let urlString = url.absoluteString
                    let projectDict: [String : Any] = ["id": projectId,
                                                       "image": urlString,
                                                       "title": title,
                                                       "cathegories": cathegories,
                                                       "progress": percentage,
                                                       "author_id": currentUser,
                                                       "sinopsis": sinopsis,
                                                       "needing": needing,
                                                       "participants": [currentUser]]
                    projectReference.updateChildValues(projectDict) { (error, ref) in
                        if error != nil {
                            completion(.error(WCError.createProject))
                            return
                        }
                        self.realtimeDB
                            .child(Paths.usersPath)
                            .child(currentUser)
                            .child("authoring_project_ids")
                            .observeSingleEvent(of: .value) { snapshot in
                                var newArray: Array<Any>
                                if var projectIds = snapshot.value as? Array<Any> {
                                    projectIds.append(projectId)
                                    newArray = projectIds
                                } else {
                                    newArray = [projectId]
                                }
                                var newDict: [String : Any] = [:]
                                for i in 0..<newArray.count {
                                    newDict["\(i)"] = newArray[i]
                                }
                                self.realtimeDB
                                    .child(Paths.usersPath)
                                    .child(currentUser)
                                    .child("authoring_project_ids")
                                    .updateChildValues(newDict) { (error, ref) in
                                        if error != nil {
                                            completion(.error(WCError.createProject))
                                            return
                                        }
                                        self.realtimeDB
                                            .child(Paths.usersPath)
                                            .child(currentUser)
                                            .child("participating_projects")
                                            .observeSingleEvent(of: .value) { snapshot in
                                                var newArray: Array<Any>
                                                if var projectIds = snapshot.value as? Array<Any> {
                                                    projectIds.append(projectId)
                                                    newArray = projectIds
                                                } else {
                                                    newArray = [projectId]
                                                }
                                                var newDict: [String : Any] = [:]
                                                for i in 0..<newArray.count {
                                                    newDict["\(i)"] = newArray[i]
                                                }
                                                self.realtimeDB
                                                    .child(Paths.usersPath)
                                                    .child(currentUser)
                                                    .child("participating_projects")
                                                    .updateChildValues(newDict) { (error, ref) in
                                                        if error != nil {
                                                            completion(.error(WCError.createProject))
                                                            return
                                                        }
                                                        self.realtimeDB
                                                            .child(Paths.allProjectsCataloguePath)
                                                            .observeSingleEvent(of: .value) { snapshot in
                                                                var projectIdsArray: [String]
                                                                if let projectIds = snapshot.value as? [String] {
                                                                    projectIdsArray = projectIds
                                                                } else {
                                                                    projectIdsArray = .empty
                                                                }
                                                                projectIdsArray.append(projectId)
                                                                self.realtimeDB.updateChildValues([Paths.allProjectsCataloguePath : projectIdsArray]) { error, ref in
                                                                    if error != nil {
                                                                        completion(.error(WCError.createProject))
                                                                        return
                                                                    }
                                                                    guard let mappedResponse = Mapper<T>().map(JSON: projectDict) else {
                                                                        completion(.error(WCError.genericError))
                                                                        return
                                                                    }
                                                                    self.registerEntity(withId: projectId, type: .ongoingProject) {
                                                                        response in
                                                                        switch response {
                                                                        case .error( _):
                                                                            completion(.error(WCError.createProject))
                                                                        case .success:
                                                                            completion(.success(mappedResponse))
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                    }
                                            }
                                    }
                            }
                    }
                }
            }
        } else {
            completion(.error(WCError.genericError))
        }
    }
    
    func fetchProjectWorking<T: Mappable>(request: [String : Any],
                                          completion: @escaping (BaseResponse<T>) -> Void) {
        if let projectId = request["projectId"] as? String {
            realtimeDB
                .child(Paths.projectsPath)
                .child(Paths.ongoingProjectsPath)
                .child(projectId)
                .observeSingleEvent(of: .value) { snapshot in
                    guard var projectData = snapshot.value as? [String : Any] else {
                        completion(.error(WCError.genericError))
                        return
                    }
                    projectData["projectId"] = projectId
                    if let participants = projectData["participants"] as? Array<Any> {
                        projectData["participants"] = participants
                    } else {
                        projectData["participants"] = []
                    }
                    guard let mappedResponse = Mapper<T>().map(JSON: projectData) else {
                        completion(.error(WCError.parseError))
                        return
                    }
                    completion(.success(mappedResponse))
                }
        } else {
            completion(.error(WCError.genericError))
        }
    }
    
    func updateUserData(request: [String : Any],
                        completion: @escaping (EmptyResponse) -> Void) {
        guard var payload = request["payload"] as? [String : Any],
              let image = request["image"] as? Data else {
            completion(.error(WCError.parseError))
            return
        }
        guard let id = authReference.currentUser?.uid else {
            completion(.error(WCError.genericError))
            return
        }
        let userImageReference =  storage.child(Paths.usersPath).child(id)
        userImageReference.putData(image, metadata: nil) { (metadata, error) in
            if error != nil {
                completion(.error(WCError.updateUser))
                return
            }
            userImageReference.downloadURL { (url, error) in
                if error != nil {
                    completion(.error(WCError.saveImage))
                    return
                }
                guard let url = url else {
                    completion(.error(WCError.genericError))
                    return
                }
                let urlString = url.absoluteString
                payload["profile_image_url"] = urlString
                self.realtimeDB
                    .child(Paths.usersPath)
                    .child(id)
                    .updateChildValues(payload) { (error, ref) in
                        if error != nil {
                            completion(.error(WCError.updateUser))
                            return
                        }
                        completion(.success)
                    }
            }
        }
    }
    
    func inviteUserToProject(request: [String : Any],
                             completion: @escaping (EmptyResponse) -> Void) {
        guard let projectId = request["projectId"] as? String,
              let userId = request["userId"] as? String,
              let projectImage = request["image"] as? String,
              let title = request["project_title"] as? String,
              let authorId = request["author_id"] as? String else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.usersPath)
            .child(userId)
            .child("project_invite_notifications")
            .observeSingleEvent(of: .value) { snapshot in
                var newArray: Array<Any>
                let headers: [String : Any] = ["image": projectImage,
                                               "project_title": title,
                                               "projectId": projectId,
                                               "author_id": authorId]
                if var notifications = snapshot.value as? Array<Any> {
                    notifications.append(headers)
                    newArray = notifications
                } else {
                    newArray = [headers]
                }
                var newDict: [String : Any] = [:]
                for i in 0..<newArray.count {
                    newDict["\(i)"] = newArray[i]
                }
                self.realtimeDB
                    .child(Paths.usersPath)
                    .child(userId)
                    .child("project_invite_notifications")
                    .updateChildValues(newDict) {
                        (error, ref) in
                        if error != nil {
                            completion(.error(WCError.inviteUserToProject))
                            return
                        }
                        self.realtimeDB
                            .child(Paths.projectsPath)
                            .child(Paths.ongoingProjectsPath)
                            .child(projectId)
                            .child("pending_invites")
                            .observeSingleEvent(of: .value) { snapshot in
                                let newArray: Array<Any>
                                if var invites = snapshot.value as? Array<Any> {
                                    invites.append(userId)
                                    newArray = invites
                                } else {
                                    newArray = [userId]
                                }
                                self.realtimeDB
                                    .child(Paths.projectsPath)
                                    .child(Paths.ongoingProjectsPath)
                                    .child(projectId)
                                    .updateChildValues(["pending_invites": newArray]) { error, ref in
                                        if error != nil {
                                            completion(.error(WCError.inviteUserToProject))
                                            return
                                        }
                                        completion(.success)
                                    }
                            }
                    }
            }
    }
    
    func fetchProjectRelation<T: Mappable>(request: [String : Any],
                                           completion: @escaping (BaseResponse<T>) -> Void) {
        guard let projectId = request["projectId"] as? String else {
            completion(.error(WCError.genericError))
            return
        }
        guard let currentUser = authReference.currentUser?.uid else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.projectsPath)
            .child(Paths.ongoingProjectsPath)
            .child(projectId)
            .child("author_id")
            .observeSingleEvent(of: .value) { snapshot in
                guard let authorId = snapshot.value as? String else {
                    completion(.error(WCError.genericError))
                    return
                }
                if authorId == currentUser {
                    let response: [String : Any] = ["relation": "AUTHOR"]
                    guard let mappedResponse = Mapper<T>().map(JSON: response) else {
                        completion(.error(WCError.parseError))
                        return
                    }
                    completion(.success(mappedResponse))
                    return
                } else {
                    self.realtimeDB
                        .child(Paths.projectsPath)
                        .child(Paths.ongoingProjectsPath)
                        .child(projectId)
                        .child("participants")
                        .observeSingleEvent(of: .value) { snapshot in
                            guard let participants = snapshot.value as? Array<Any> else {
                                completion(.error(WCError.genericError))
                                return
                            }
                            let participantStringArray = participants.map({ "\($0)" })
                            
                            if participantStringArray.contains(currentUser) {
                                let response: [String : Any] = ["relation": "PARTICIPATING"]
                                guard let mappedResponse = Mapper<T>().map(JSON: response) else {
                                    completion(.error(WCError.parseError))
                                    return
                                }
                                completion(.success(mappedResponse))
                                return
                            } else {
                                self.realtimeDB
                                    .child(Paths.usersPath)
                                    .child(currentUser)
                                    .child("pending_projects")
                                    .observeSingleEvent(of: .value) { snapshot in
                                        if let pendingProjects = snapshot.value as? [String],
                                           pendingProjects.contains(projectId) {
                                            let response: [String : Any] = ["relation": "PENDING"]
                                            guard let mappedResponse = Mapper<T>().map(JSON: response) else {
                                                completion(.error(WCError.parseError))
                                                return
                                            }
                                            completion(.success(mappedResponse))
                                            return
                                        } else {
                                            self.realtimeDB
                                                .child(Paths.projectsPath)
                                                .child(Paths.ongoingProjectsPath)
                                                .child(projectId)
                                                .child("pending_invites")
                                                .observeSingleEvent(of: .value) { snapshot in
                                                    if let pendingInvites = snapshot.value as? [String],
                                                       pendingInvites.contains(currentUser) {
                                                        let response: [String : Any] = ["relation": "INVITED"]
                                                        guard let mappedResponse = Mapper<T>().map(JSON: response) else {
                                                            completion(.error(WCError.parseError))
                                                            return
                                                        }
                                                        completion(.success(mappedResponse))
                                                    } else {
                                                        let response: [String : Any] = ["relation": "NOTHING"]
                                                        guard let mappedResponse = Mapper<T>().map(JSON: response) else {
                                                            completion(.error(WCError.parseError))
                                                            return
                                                        }
                                                        completion(.success(mappedResponse))
                                                    }
                                                }
                                        }
                                    }
                            }
                        }
                }
            }
    }
    
    func updateProjectInfo(request: [String : Any],
                           completion: @escaping (EmptyResponse) -> Void) {
        guard let projectId = request["projectId"] as? String,
              let title = request["title"] as? String,
              let sinopsis = request["sinopsis"] as? String else {
            completion(.error(WCError.genericError))
            return
        }
        let dict: [String : Any] = ["title": title,
                                    "sinopsis": sinopsis]
        realtimeDB
            .child(Paths.projectsPath)
            .child(Paths.ongoingProjectsPath)
            .child(projectId)
            .updateChildValues(dict) { (error, ref) in
                if error != nil {
                    completion(.error(WCError.updateProject))
                    return
                }
                completion(.success)
            }
    }
    
    func updateProjectNeedingField(request: [String : Any],
                                   completion: @escaping (EmptyResponse) -> Void) {
        guard let needing = request["needing"] as? String,
              let projectId = request["projectId"] as? String else {
            completion(.error(WCError.genericError))
            return
        }
        let dict: [String : Any] = ["needing": needing]
        realtimeDB
            .child(Paths.projectsPath)
            .child(Paths.ongoingProjectsPath)
            .child(projectId)
            .updateChildValues(dict) { (error, ref) in
                if error != nil {
                    completion(.error(WCError.updateProject))
                }
                completion(.success)
            }
    }
    
    func updateProjectImage<T: Mappable>(request: [String : Any],
                                         completion: @escaping (BaseResponse<T>) -> Void) {
        guard let projectId = request["projectId"] as? String,
              let image = request["image"] as? Data else {
            completion(.error(WCError.genericError))
            return
        }
        let projectImageReference = storage.child(Paths.projectImagesPath).child(projectId)
        projectImageReference.putData(image, metadata: nil) { (metadata, error) in
            if error != nil {
                completion(.error(WCError.saveImage))
                return
            }
            projectImageReference.downloadURL { (url, error) in
                if error != nil {
                    completion(.error(WCError.saveImage))
                    return
                }
                guard let urlString = url?.absoluteString else {
                    completion(.error(WCError.genericError))
                    return
                }
                let dict: [String : Any] = ["image": urlString]
                self.realtimeDB
                    .child(Paths.projectsPath)
                    .child(Paths.ongoingProjectsPath)
                    .child(projectId)
                    .updateChildValues(dict) { (error, ref) in
                        if error != nil {
                            completion(.error(WCError.saveImage))
                            return
                        }
                        guard let mappedResponse = Mapper<T>().map(JSON: dict) else {
                            completion(.error(WCError.parseError))
                            return
                        }
                        completion(.success(mappedResponse))
                    }
            }
        }
    }
    
    func fetchUserParticipatingProjects<T: Mappable>(request: [String : Any],
                                                     completion: @escaping (BaseResponse<[T]>) -> Void) {
        var responseProjects = [[String : Any]]()
        guard let userId = request["userId"] as? String else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.usersPath)
            .child(userId)
            .child("participating_projects")
            .observeSingleEvent(of: .value) { snapshot in
                guard let projectIds = snapshot.value as? Array<Any> else {
                    completion(.success(.empty))
                    return
                }
                
                for i in 0..<projectIds.count {
                    guard let projectId = projectIds[i] as? String else {
                        completion(.error(WCError.genericError))
                        return
                    }
                    self.realtimeDB
                        .child(Paths.projectsPath)
                        .child(Paths.ongoingProjectsPath)
                        .child(projectId)
                        .observeSingleEvent(of: .value) { snapshot in
                            guard var projectData = snapshot.value as? [String : Any] else {
                                completion(.error(WCError.parseError))
                                return
                            }
                            projectData["projectId"] = projectId
                            responseProjects.append(projectData)
                            let mappedResponse = Mapper<T>().mapArray(JSONArray: responseProjects)
                            if i == projectIds.count-1 {
                                completion(.success(mappedResponse))
                            }
                        }
                }
            }
    }
    
    func fetchProjectInvites<T: Mappable>(request: [String : Any],
                                          completion: @escaping (BaseResponse<[T]>) -> Void) {
        var responseArray: [[String : Any]] = []
        guard let currentUser = authReference.currentUser?.uid else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.usersPath)
            .child(currentUser)
            .child("project_invite_notifications")
            .observeSingleEvent(of: .value) { snapshot in
                guard let notifications = snapshot.value as? Array<Any> else {
                    completion(.success(.empty))
                    return
                }
                for i in 0..<notifications.count {
                    guard let notification = notifications[i] as? [String : Any] else {
                        completion(.error(WCError.genericError))
                        return
                    }
                    responseArray.append(notification)
                    if i == notifications.count-1 {
                        let mappedResponse = Mapper<T>().mapArray(JSONArray: responseArray)
                        completion(.success(mappedResponse))
                    }
                }
            }
    }
    
    func acceptProjectInvite(request: [String : Any],
                             completion: @escaping (EmptyResponse) -> Void) {
        guard let projectId = request["projectId"] as? String,
              let currentUser = authReference.currentUser?.uid else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.usersPath)
            .child(currentUser)
            .child("project_invite_notifications")
            .observeSingleEvent(of: .value) { snapshot in
                guard var notifications = snapshot.value as? Array<Any> else {
                    completion(.error(WCError.genericError))
                    return
                }
                notifications.removeAll(where: {
                    guard let notification = $0 as? [String : Any] else {
                        return false
                    }
                    guard let id = notification["projectId"] as? String else {
                        return false
                    }
                    return id == projectId
                })
                var notificationsDict: [String : Any] = [:]
                for i in 0..<notifications.count {
                    if let notification = notifications[i] as? [String : Any] {
                        notificationsDict["\(i)"] = notification
                    }
                }
                self.realtimeDB
                    .child(Paths.usersPath)
                    .child(currentUser)
                    .updateChildValues(["project_invite_notifications" : notificationsDict]) { (error, ref) in
                        if error != nil {
                            completion(.error(WCError.acceptProjectInvite))
                            return
                        }
                        self.realtimeDB
                            .child(Paths.usersPath)
                            .child(currentUser)
                            .child("participating_projects")
                            .observeSingleEvent(of: .value) { snapshot in
                                var projectsArray: Array<Any>
                                if let projects = snapshot.value as? Array<Any> {
                                    projectsArray = projects
                                    projectsArray.append(projectId)
                                } else {
                                    projectsArray = [projectId]
                                }
                                var projectsDict: [String : Any] = [:]
                                for i in 0..<projectsArray.count {
                                    projectsDict["\(i)"] = projectsArray[i]
                                }
                                self.realtimeDB
                                    .child(Paths.usersPath)
                                    .child(currentUser)
                                    .child("participating_projects")
                                    .updateChildValues(projectsDict) { (error, ref) in
                                        if error != nil {
                                            completion(.error(WCError.acceptProjectInvite))
                                            return
                                        }
                                        self.realtimeDB
                                            .child(Paths.projectsPath)
                                            .child(Paths.ongoingProjectsPath)
                                            .child(projectId)
                                            .child("pending_invites")
                                            .observeSingleEvent(of: .value) { snapshot in
                                                guard var pendingInvites = snapshot.value as? [String] else {
                                                    completion(.error(WCError.genericError))
                                                    return
                                                }
                                                pendingInvites.removeAll(where: { $0 == currentUser })
                                                self.realtimeDB
                                                    .child(Paths.projectsPath)
                                                    .child(Paths.ongoingProjectsPath)
                                                    .child(projectId)
                                                    .updateChildValues(["pending_invites": pendingInvites]) { (error, ref) in
                                                        if error != nil {
                                                            completion(.error(WCError.acceptProjectInvite))
                                                            return
                                                        }
                                                        self.realtimeDB
                                                            .child(Paths.projectsPath)
                                                            .child(Paths.ongoingProjectsPath)
                                                            .child(projectId)
                                                            .child("participants")
                                                            .observeSingleEvent(of: .value) { snapshot in
                                                                guard var participants = snapshot.value as? [String] else {
                                                                    completion(.error(WCError.genericError))
                                                                    return
                                                                }
                                                                participants.append(currentUser)
                                                                self.realtimeDB
                                                                    .child(Paths.projectsPath)
                                                                    .child(Paths.ongoingProjectsPath)
                                                                    .child(projectId)
                                                                    .updateChildValues(["participants": participants]) { (error, ref) in
                                                                        if error != nil {
                                                                            completion(.error(WCError.acceptProjectInvite))
                                                                            return
                                                                        }
                                                                        self.realtimeDB.child(Paths.usersPath).child(currentUser).observeSingleEvent(of: .value) { snapshot in
                                                                            guard let data = snapshot.value as? [String : Any], let name = data["name"] as? String, let image = data["profile_image_url"] as? String else {
                                                                                completion(.error(WCError.genericError))
                                                                                return
                                                                            }
                                                                            self.realtimeDB
                                                                                .child(Paths.projectsPath)
                                                                                .child(Paths.ongoingProjectsPath)
                                                                                .child(projectId).child("title")
                                                                                .observeSingleEvent(of: .value) { snapshot in
                                                                                    guard let projectName = snapshot.value as? String else {
                                                                                        completion(.error(WCError.genericError))
                                                                                        return
                                                                                    }
                                                                                    self.realtimeDB
                                                                                        .child(Paths.projectsPath)
                                                                                        .child(Paths.ongoingProjectsPath)
                                                                                        .child(projectId).child("author_id")
                                                                                        .observeSingleEvent(of: .value) { snapshot in
                                                                                            guard let authorId = snapshot.value as? String else {
                                                                                                completion(.error(WCError.genericError))
                                                                return                            }
                                                                                            self.sendAcceptNotification(type: .projectInvite(username: name, projectName: projectName, image: image), userId: authorId, completion: completion)                     }

                                                                            }
                                                                        }
                                                                    }
                                                            }
                                                    }
                                            }
                                    }
                            }
                    }
            }
    }
    
    func fetchProjectParticipants<T: Mappable>(request: [String : Any],
                                               completion: @escaping (BaseResponse<[T]>) -> Void) {
        var responseArray: [[String : Any]] = .empty
        guard let projectId = request["projectId"] as? String else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.projectsPath)
            .child(Paths.ongoingProjectsPath)
            .child(projectId)
            .child("participants")
            .observeSingleEvent(of: .value) { snapshot in
                guard let participants = snapshot.value as? Array<Any> else {
                    completion(.success(.empty))
                    return
                }
                for i in 0..<participants.count {
                    guard let participant = participants[i] as? String else {
                        completion(.error(WCError.genericError))
                        return
                    }
                    self.realtimeDB
                        .child(Paths.usersPath)
                        .child(participant)
                        .observeSingleEvent(of: .value) { snapshot in
                            guard var user = snapshot.value as? [String : Any] else {
                                completion(.error(WCError.genericError))
                                return
                            }
                            user["id"] = participant
                            responseArray.append(user)
                            if i == participants.count-1 {
                                let mappedResponse = Mapper<T>().mapArray(JSONArray: responseArray)
                                completion(.success(mappedResponse))
                            }
                        }
                }
            }
    }
    
    func refuseProjectInvite(request: [String : Any],
                             completion: @escaping (EmptyResponse) -> Void) {
        guard let projectId = request["projectId"] as? String,
              let currentUser = authReference.currentUser?.uid else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.usersPath)
            .child(currentUser)
            .child("project_invite_notifications")
            .observeSingleEvent(of: .value) { snapshot in
                guard var notifications = snapshot.value as? [[String : Any]] else {
                    completion(.error(WCError.genericError))
                    return
                }
                notifications.removeAll(where: {
                    guard let project = $0["projectId"] as? String else {
                        return false
                    }
                    return project == projectId
                })
                self.realtimeDB
                    .child(Paths.usersPath)
                    .child(currentUser)
                    .updateChildValues(["project_invite_notifications": notifications]) { (error, ref) in
                        if error != nil {
                            completion(.error(WCError.refuseRequest))
                            return
                        }
                        self.realtimeDB
                            .child(Paths.projectsPath)
                            .child(Paths.ongoingProjectsPath)
                            .child(projectId)
                            .child("pending_invites")
                            .observeSingleEvent(of: .value) { snapshot in
                                guard var pendingInvites = snapshot.value as? [String] else {
                                    completion(.error(WCError.genericError))
                                    return
                                }
                                pendingInvites.removeAll(where: {
                                    $0 == currentUser
                                })
                                self.realtimeDB
                                    .child(Paths.projectsPath)
                                    .child(Paths.ongoingProjectsPath)
                                    .child(projectId)
                                    .updateChildValues(["pending_invites": pendingInvites]) { (error, ref) in
                                        if error != nil {
                                            completion(.error(WCError.refuseRequest))
                                            return
                                        }
                                        completion(.success)
                                    }
                            }
                    }
            }
    }
    
    func sendProjectParticipationRequest(request: [String : Any],
                                         completion: @escaping (EmptyResponse) -> Void) {
        guard let projectId = request["projectId"] as? String,
              let currentUser = authReference.currentUser?.uid else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.usersPath)
            .child(currentUser)
            .child("pending_projects")
            .observeSingleEvent(of: .value) { snapshot in
                var pendingArray: [String] = .empty
                if let pendingProjects = snapshot.value as? [String] {
                    pendingArray.append(contentsOf: pendingProjects)
                    pendingArray.append(projectId)
                } else {
                    pendingArray = [projectId]
                }
                self.realtimeDB
                    .child(Paths.usersPath)
                    .child(currentUser)
                    .updateChildValues(["pending_projects" : pendingArray]) { (error, ref) in
                        if error != nil {
                            completion(.error(WCError.sendConnectionRequest))
                            return
                        }
                        self.realtimeDB
                            .child(Paths.projectsPath)
                            .child(Paths.ongoingProjectsPath)
                            .child(projectId)
                            .child("author_id")
                            .observeSingleEvent(of: .value) { snapshot in
                                guard let authorId = snapshot.value as? String else {
                                    completion(.error(WCError.genericError))
                                    return
                                }
                                self.realtimeDB
                                    .child(Paths.usersPath)
                                    .child(currentUser)
                                    .observeSingleEvent(of: .value) { snapshot in
                                        guard let userData = snapshot.value as? [String : Any],
                                              let username = userData["name"] as? String,
                                              let userEmail = userData["email"] as? String,
                                              let image = userData["profile_image_url"] as? String,
                                              let ocupation = userData["professional_area"] as? String else {
                                            completion(.error(WCError.genericError))
                                            return
                                        }
                                        self.realtimeDB
                                            .child(Paths.usersPath)
                                            .child(authorId)
                                            .child("project_participation_notifications")
                                            .observeSingleEvent(of: .value) { snapshot in
                                                var notificationsArray: [[String : Any]] = .empty
                                                let notificationDict: [String : Any] =
                                                    ["userId": currentUser,
                                                     "userName": username,
                                                     "userOcupation": ocupation,
                                                     "image": image,
                                                     "projectId": projectId,
                                                     "userEmail": userEmail]
                                                if var notifications = snapshot.value as? [[String : Any]] {
                                                    notificationsArray.append(contentsOf: notifications)
                                                    notifications.append(notificationDict)
                                                } else {
                                                    notificationsArray = [notificationDict]
                                                }
                                                self.realtimeDB
                                                    .child(Paths.usersPath)
                                                    .child(authorId)
                                                    .updateChildValues(["project_participation_notifications" : notificationsArray]) { (error, ref) in
                                                        if error != nil {
                                                            completion(.error(WCError.sendProjectParticipationRequest))
                                                            return
                                                        }
                                                        completion(.success)
                                                    }
                                            }
                                    }
                            }
                    }
            }
    }
    
    func removeProjectParticipationRequest(request: [String : Any],
                                           completion: @escaping (EmptyResponse) -> Void) {
        guard let projectId = request["projectId"] as? String,
              let currentUser = authReference.currentUser?.uid else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.usersPath)
            .child(currentUser)
            .child("pending_projects")
            .observeSingleEvent(of: .value) { snapshot in
                guard var pendingProjects = snapshot.value as? [String] else {
                    completion(.error(WCError.genericError))
                    return
                }
                pendingProjects.removeAll(where: { $0 == projectId })
                self.realtimeDB
                    .child(Paths.usersPath)
                    .child(currentUser)
                    .updateChildValues(["pending_projects": pendingProjects]) { (error, ref) in
                        if error != nil {
                            completion(.error(WCError.removeProjectParticipationRequest))
                            return
                        }
                        self.realtimeDB
                            .child(Paths.projectsPath)
                            .child(Paths.ongoingProjectsPath)
                            .child(projectId)
                            .child("pending_invites")
                            .observeSingleEvent(of: .value) { snapshot in
                                guard var pendingInvites = snapshot.value as? [String] else {
                                    completion(.error(WCError.genericError))
                                    return
                                }
                                pendingInvites.removeAll(where: { $0 == currentUser})
                                self.realtimeDB
                                    .child(Paths.projectsPath)
                                    .child(Paths.ongoingProjectsPath)
                                    .child(projectId)
                                    .updateChildValues(["pending_invites": pendingInvites]) { (error, ref) in
                                        if error != nil {
                                            completion(.error(WCError.removeProjectParticipationRequest))
                                            return
                                        }
                                        self.realtimeDB
                                            .child(Paths.projectsPath)
                                            .child(Paths.ongoingProjectsPath)
                                            .child(projectId)
                                            .child("author_id")
                                            .observeSingleEvent(of: .value) { snapshot in
                                                guard let authorId = snapshot.value as? String else {
                                                    completion(.error(WCError.genericError))
                                                    return
                                                }
                                                self.realtimeDB
                                                    .child(Paths.usersPath)
                                                    .child(authorId)
                                                    .child("project_participation_notifications")
                                                    .observeSingleEvent(of: .value) { snapshot in
                                                        guard var notifications = snapshot.value as? [[String : Any]] else {
                                                            completion(.error(WCError.genericError))
                                                            return
                                                        }
                                                        notifications.removeAll(where: {
                                                            guard let userId = $0["userId"] as? String else {
                                                                return false
                                                            }
                                                            return userId == currentUser
                                                        })
                                                        self.realtimeDB
                                                            .child(Paths.usersPath)
                                                            .child(authorId)
                                                            .updateChildValues(["project_participation_notifications": notifications]) { (error, ref) in
                                                                if error != nil {
                                                                    completion(.error(WCError.removeProjectParticipationRequest))
                                                                    return
                                                                }
                                                                completion(.success)
                                                            }
                                                    }
                                            }
                                    }
                            }
                    }
            }
    }
    
    func exitProject(request: [String : Any],
                     completion: @escaping (EmptyResponse) -> Void) {
        guard let projectId = request["projectId"] as? String,
              let currentUser = authReference.currentUser?.uid else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.usersPath)
            .child(currentUser)
            .child("participating_projects")
            .observeSingleEvent(of: .value) { snapshot in
                guard var projects = snapshot.value as? [String] else {
                    completion(.error(WCError.genericError))
                    return
                }
                projects.removeAll(where: { $0 == projectId })
                self.realtimeDB
                    .child(Paths.usersPath)
                    .child(currentUser)
                    .updateChildValues(["participating_projects": projects]) { (error, ref) in
                        if error != nil {
                            completion(.error(WCError.genericError))
                            return
                        }
                        self.realtimeDB
                            .child(Paths.projectsPath)
                            .child(Paths.ongoingProjectsPath)
                            .child(projectId)
                            .child("participants")
                            .observeSingleEvent(of: .value) { snapshot in
                                guard var participants = snapshot.value as? [String] else {
                                    completion(.error(WCError.genericError))
                                    return
                                }
                                participants.removeAll(where: { $0 == currentUser })
                                self.realtimeDB
                                    .child(Paths.projectsPath)
                                    .child(Paths.ongoingProjectsPath)
                                    .child(projectId)
                                    .updateChildValues(["participants": participants]) { (error, ref) in
                                        if error != nil {
                                            completion(.error(WCError.genericError))
                                            return
                                        }
                                        completion(.success)
                                    }
                            }
                    }
            }
    }
    
    func fetchProjectParticipationRequestNotifications<T: Mappable>(request: [String : Any],
                                                                    completion: @escaping (BaseResponse<[T]>) -> Void)  {
        var responseArray: [[String : Any]] = .empty
        guard let currentUser = authReference.currentUser?.uid else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.usersPath)
            .child(currentUser)
            .child("project_participation_notifications")
            .observeSingleEvent(of: .value) { snapshot in
                guard var notifications = snapshot.value as? [[String : Any]] else {
                    completion(.success(.empty))
                    return
                }
                for i in 0..<notifications.count {
                    guard let projectId = notifications[i]["projectId"] as? String else {
                        completion(.error(WCError.genericError))
                        return
                    }
                    self.realtimeDB
                        .child(Paths.projectsPath)
                        .child(Paths.ongoingProjectsPath)
                        .child(projectId)
                        .child("title")
                        .observeSingleEvent(of: .value) { snapshot in
                            guard let title = snapshot.value as? String else {
                                completion(.error(WCError.genericError))
                                return
                            }
                            notifications[i]["projectName"] = title
                            guard let userId = notifications[i]["userId"] as? String else {
                                completion(.error(WCError.genericError))
                                return
                            }
                            self.realtimeDB
                                .child(Paths.usersPath)
                                .child(userId)
                                .observeSingleEvent(of: .value) { snapshot in
                                    guard let user = snapshot.value as? [String : Any],
                                          let email = user["email"] as? String,
                                          let ocupation = user["professional_area"] as? String else {
                                        completion(.error(WCError.genericError))
                                        return
                                    }
                                    notifications[i]["userEmail"] = email
                                    notifications[i]["userOcupation"] = ocupation
                                    if i == notifications.count-1 {
                                        responseArray = notifications
                                        let mappedResponse = Mapper<T>().mapArray(JSONArray: responseArray)
                                        completion(.success(mappedResponse))
                                    }
                                }
                        }
                }
            }
    }
    
    func acceptUserIntoProject(request: [String : Any],
                               completion: @escaping (EmptyResponse) -> Void) {
        guard let userId = request["userId"] as? String,
              let projectId = request["projectId"] as? String,
              let currentUser = authReference.currentUser?.uid else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.projectsPath)
            .child(Paths.ongoingProjectsPath)
            .child(projectId)
            .child("participants")
            .observeSingleEvent(of: .value) { snapshot in
                guard var participants = snapshot.value as? [String] else {
                    completion(.error(WCError.genericError))
                    return
                }
                participants.append(userId)
                self.realtimeDB
                    .child(Paths.projectsPath)
                    .child(Paths.ongoingProjectsPath)
                    .child(projectId)
                    .updateChildValues(["participants": participants]) { (error, ref) in
                        if error != nil {
                            completion(.error(WCError.acceptUserIntoProject))
                            return
                        }
                        self.realtimeDB
                            .child(Paths.usersPath)
                            .child(currentUser)
                            .child("project_participation_notifications")
                            .observeSingleEvent(of: .value) { snapshot in
                                guard var notifications = snapshot.value as? [[String : Any]] else {
                                    completion(.error(WCError.genericError))
                                    return
                                }
                                notifications.removeAll(where: {
                                    guard let id = $0["userId"] as? String else {
                                        return false
                                    }
                                    return id == userId
                                })
                                self.realtimeDB
                                    .child(Paths.usersPath)
                                    .child(currentUser)
                                    .updateChildValues(["project_participation_notifications": notifications]) { (error, ref) in
                                        if error != nil {
                                            completion(.error(WCError.acceptUserIntoProject))
                                            return
                                        }
                                        self.realtimeDB
                                            .child(Paths.usersPath)
                                            .child(userId)
                                            .child("pending_projects")
                                            .observeSingleEvent(of: .value) { snapshot in
                                                guard var pendingProjects = snapshot.value as? [String] else {
                                                    completion(.error(WCError.genericError))
                                                    return
                                                }
                                                pendingProjects.removeAll(where: { $0 == projectId})
                                                self.realtimeDB
                                                    .child(Paths.usersPath)
                                                    .child(userId)
                                                    .updateChildValues( ["pending_projects": pendingProjects]) { (error, ref) in
                                                        if error != nil {
                                                            completion(.error(WCError.acceptUserIntoProject))
                                                            return
                                                        }
                                                        self.realtimeDB
                                                            .child(Paths.usersPath)
                                                            .child(userId)
                                                            .child("participating_projects")
                                                            .observeSingleEvent(of: .value) {
                                                                snapshot in
                                                                var projects: [String] = .empty
                                                                if let participatingProjects = snapshot.value as? [String] {
                                                                    projects = participatingProjects
                                                                    projects.append(projectId)
                                                                } else {
                                                                    projects = [projectId]
                                                                }
                                                                self.realtimeDB
                                                                    .child(Paths.usersPath)
                                                                    .child(userId)
                                                                    .updateChildValues(
                                                                        ["participating_projects":
                                                                            projects]) { (error, ref) in
                                                                        if error != nil {
                                                                            completion(.error(WCError.acceptUserIntoProject))
                                                                        }
                                                                        self.realtimeDB
                                                                            .child(Paths.projectsPath)
                                                                            .child(Paths.ongoingProjectsPath)
                                                                            .child(projectId)
                                                                            .observeSingleEvent(of: .value) { snapshot in
                                                                                guard let data = snapshot.value as? [String : Any], let name = data["title"] as? String, let image = data["image"] as? String else {
                                                                                    completion(.error(WCError.genericError))
                                                                                    return
                                                                                }
                                                                                self.sendAcceptNotification(type: .projectParticipationRequest(projectName: name, image: image), userId: userId, completion: completion)
                                                                        }
                                                                    }
                                                            }
                                                    }
                                            }
                                    }
                            }
                    }
            }
    }
    
    func refuseUserIntoProject(request: [String : Any],
                               completion: @escaping (EmptyResponse) -> Void) {
        guard let userId = request["userId"] as? String,
              let projectId = request["projectId"] as? String,
              let currentUser = authReference.currentUser?.uid else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.usersPath)
            .child(userId)
            .child("pending_projects")
            .observeSingleEvent(of: .value) { snapshot in
                guard var pendingProjects = snapshot.value as? [String] else {
                    completion(.error(WCError.genericError))
                    return
                }
                pendingProjects.removeAll(where: { $0 == projectId })
                self.realtimeDB
                    .child(Paths.usersPath)
                    .child(userId)
                    .updateChildValues(["pending_projects": pendingProjects]) { (error, ref) in
                        if error != nil {
                            completion(.error(WCError.refuseRequest))
                            return
                        }
                        self.realtimeDB
                            .child(Paths.usersPath)
                            .child(currentUser)
                            .child("project_participation_notifications")
                            .observeSingleEvent(of: .value) { snapshot in
                                guard var notifications = snapshot.value as? [[String : Any]] else {
                                    completion(.error(WCError.genericError))
                                    return
                                }
                                notifications.removeAll(where: {
                                    guard let project = $0["projectId"] as? String,
                                          let user = $0["userId"] as? String else {
                                        return false
                                    }
                                    return projectId == project && userId == user
                                })
                                self.realtimeDB
                                    .child(Paths.usersPath)
                                    .child(currentUser)
                                    .updateChildValues(["project_participation_notifications": notifications]) { (error, ref) in
                                        if error != nil {
                                            completion(.error(WCError.refuseRequest))
                                            return
                                        }
                                        completion(.success)
                                    }
                            }
                    }
            }
    }
    
    func fetchUserRelationToOnGoingProject<T: Mappable>(request: [String : Any],
                                                 completion: @escaping (BaseResponse<T>) -> Void) {
        var responseDict: [String : Any] = .empty
        guard let userId = request["userId"] as? String,
              let projectId = request["projectId"] as? String else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.projectsPath)
            .child(Paths.ongoingProjectsPath)
            .child(projectId)
            .child("participants")
            .observeSingleEvent(of: .value) { snapshot in
                guard let participants = snapshot.value as? [String] else {
                    completion(.error(WCError.genericError))
                    return
                }
                if participants.contains(userId) {
                    responseDict["relation"] = "SIMPLE PARTICIPANT"
                    guard let mappedResponse = Mapper<T>().map(JSON: responseDict) else {
                        completion(.error(WCError.parseError))
                        return
                    }
                    completion(.success(mappedResponse))
                    return
                }
                self.realtimeDB
                    .child(Paths.usersPath)
                    .child(userId)
                    .child("pending_projects")
                    .observeSingleEvent(of: .value) { snapshot in
                        if let projects = snapshot.value as? [String], projects.contains(projectId) {
                            responseDict["relation"] = "SENT REQUEST"
                            guard let mappedResponse = Mapper<T>().map(JSON: responseDict) else {
                                completion(.error(WCError.parseError))
                                return
                            }
                            completion(.success(mappedResponse))
                            return
                        }
                        self.realtimeDB
                            .child(Paths.projectsPath)
                            .child(Paths.ongoingProjectsPath)
                            .child(projectId)
                            .child("pending_invites")
                            .observeSingleEvent(of: .value) { snapshot in
                                if let invites = snapshot.value as? [String],
                                   invites.contains(userId) {
                                    responseDict["relation"] = "RECEIVED REQUEST"
                                    guard let mappedResponse = Mapper<T>().map(JSON: responseDict) else {
                                        completion(.error(WCError.parseError))
                                        return
                                    }
                                    completion(.success(mappedResponse))
                                    return
                                }
                                responseDict["relation"] = "NOTHING"
                                guard let mappedResponse = Mapper<T>().map(JSON: responseDict) else {
                                    completion(.error(WCError.parseError))
                                    return
                                }
                                completion(.success(mappedResponse))
                            }
                    }
            }
    }
    
    func removeProjectInviteToUser(request: [String : Any],
                                   completion: @escaping (EmptyResponse) -> Void) {
        guard let userId = request["userId"] as? String,
              let projectId = request["projectId"] as? String else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.projectsPath)
            .child(Paths.ongoingProjectsPath)
            .child(projectId)
            .child("pending_invites")
            .observeSingleEvent(of: .value) { snapshot in
                guard var invites = snapshot.value as? [String] else {
                    completion(.error(WCError.genericError))
                    return
                }
                invites.removeAll(where: { $0 == userId })
                self.realtimeDB
                    .child(Paths.projectsPath)
                    .child(Paths.ongoingProjectsPath)
                    .child(projectId)
                    .updateChildValues(["pending_invites": invites]) { (error, ref) in
                        if error != nil {
                            completion(.error(WCError.removeProjectInviteToUser))
                            return
                        }
                        self.realtimeDB
                            .child(Paths.usersPath)
                            .child(userId)
                            .child("project_invite_notifications")
                            .observeSingleEvent(of: .value) { snapshot in
                                guard var notifications = snapshot.value as? [[String : Any]] else {
                                    completion(.error(WCError.genericError))
                                    return
                                }
                                notifications.removeAll(where: {
                                    guard let project = $0["projectId"] as? String else {
                                        return false
                                    }
                                    return project == projectId
                                })
                                self.realtimeDB
                                    .child(Paths.usersPath)
                                    .child(userId)
                                    .updateChildValues(["project_invite_notifications": notifications]) { (error, ref) in
                                        if error != nil {
                                            completion(.error(WCError.removeProjectInviteToUser))
                                            return
                                        }
                                        completion(.success)
                                    }
                            }
                    }
            }
    }
    
    func removeUserFromProject(request: [String : Any],
                               completion: @escaping (EmptyResponse) -> Void) {
        guard let userId = request["userId"] as? String,
              let projectId = request["projectId"] as? String else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.projectsPath)
            .child(Paths.ongoingProjectsPath)
            .child(projectId)
            .child("participants")
            .observeSingleEvent(of: .value) { snapshot in
                guard var users = snapshot.value as? [String] else {
                    completion(.error(WCError.genericError))
                    return
                }
                users.removeAll(where: { $0 == userId })
                self.realtimeDB
                    .child(Paths.projectsPath)
                    .child(Paths.ongoingProjectsPath)
                    .child(projectId)
                    .updateChildValues(["participants": users]) { (error, ref) in
                        if error != nil {
                            completion(.error(WCError.removeUserFromProject))
                            return
                        }
                        self.realtimeDB
                            .child(Paths.usersPath)
                            .child(userId)
                            .child("participating_projects")
                            .observeSingleEvent(of: .value) { snapshot in
                                guard var projects = snapshot.value as? [String] else {
                                    completion(.error(WCError.genericError))
                                    return
                                }
                                projects.removeAll(where: {
                                    $0 == projectId
                                })
                                self.realtimeDB
                                    .child(Paths.usersPath)
                                    .child(userId)
                                    .updateChildValues(["participating_projects": projects]) { (error, ref) in
                                        if error != nil {
                                            completion(.error(WCError.removeUserFromProject))
                                            return
                                        }
                                        completion(.success)
                                    }
                            }
                    }
            }
    }
    
    func fetchCurrentUserAuthoringProjects<T: Mappable>(request: [String : Any],
                                                        completion: @escaping (BaseResponse<[T]>) -> Void) {
        var responseArray: [[String : Any]] = .empty
        guard let currentUser = authReference.currentUser?.uid else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.usersPath)
            .child(currentUser)
            .child("authoring_project_ids")
            .observeSingleEvent(of: .value) { snapshot in
                var ids: [String] = .empty
                if let projectIds = snapshot.value as? [String] {
                    ids.append(contentsOf: projectIds)
                }
                for i in 0..<ids.count {
                    self.realtimeDB
                        .child(Paths.projectsPath)
                        .child(Paths.ongoingProjectsPath)
                        .child(ids[i])
                        .observeSingleEvent(of: .value) { snapshot in
                            guard var project = snapshot.value as? [String : Any] else {
                                completion(.error(WCError.genericError))
                                return
                            }
                            project["id"] = ids[i]
                            responseArray.append(project)
                            if i == ids.count-1 {
                                let mappedResponse = Mapper<T>().mapArray(JSONArray: responseArray)
                                completion(.success(mappedResponse))
                            }
                        }
                }
            }
    }
    
    func updateProjectProgress(request: [String : Any],
                               completion: @escaping (EmptyResponse) -> Void) {
        guard let projectId = request["projectId"] as? String,
              let progress = request["progress"] as? Int else {
            completion(.error(WCError.genericError))
            return
        }
        let dict: [String : Any] = ["progress": progress]
        realtimeDB
            .child(Paths.projectsPath)
            .child(Paths.ongoingProjectsPath)
            .child(projectId)
            .updateChildValues(dict) { (error, ref) in
                if error != nil {
                    completion(.error(WCError.updateProject))
                    return
                }
                completion(.success)
            }
    }
    
    func fetchSearchProfiles<T: Mappable>(request: [String : Any],
                                          completion: @escaping (BaseResponse<[T]>) -> Void) {
        var usersResponse: [[String : Any]] = .empty
        
        guard let preffix = request["preffix"] as? String else {
            completion(.error(WCError.genericError))
            return
        }
        guard let currentUser = authReference.currentUser?.uid else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.allUsersCataloguePath)
            .observeSingleEvent(of: .value) { snapshot in
                guard var userIds = snapshot.value as? [String] else {
                    completion(.error(WCError.genericError))
                    return
                }
                userIds.removeAll(where: { $0 == currentUser })
                guard userIds.count > 0 else {
                    completion(.success(.empty))
                    return
                }
                for i in 0..<userIds.count {
                    self.realtimeDB
                        .child(Paths.usersPath)
                        .child(userIds[i])
                        .observeSingleEvent(of: .value) { snapshot in
                            guard var user = snapshot.value as? [String : Any] else {
                                completion(.error(WCError.genericError))
                                return
                            }
                            guard let name = user["name"] as? String else {
                                completion(.error(WCError.genericError))
                                return
                            }
                            user["id"] = userIds[i]
                            if name.hasPrefix(preffix),
                               userIds[i] != currentUser {
                                usersResponse.append(user)
                            }
                            if i == userIds.count-1 {
                                let mappedResponse = Mapper<T>().mapArray(JSONArray: usersResponse)
                                completion(.success(mappedResponse))
                            }
                        }
                }
            }
    }
    
    func fetchSearchOngoingProjects<T: Mappable>(request: [String : Any],
                                          completion: @escaping (BaseResponse<[T]>) -> Void) {
        var projectsResponse: [[String : Any]] = .empty
        var allProjects = [String]()
        
        guard let preffix = request["preffix"] as? String else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.allProjectsCataloguePath)
            .observeSingleEvent(of: .value) { snapshot in
                if let projectIds = snapshot.value as? [String] {
                    allProjects = projectIds
                } else {
                    completion(.success(.empty))
                    return
                }
                for i in 0..<allProjects.count {
                    self.realtimeDB
                        .child(Paths.projectsPath)
                        .child(Paths.ongoingProjectsPath)
                        .child(allProjects[i])
                        .observeSingleEvent(of: .value) { snapshot in
                            guard var project = snapshot.value as? [String : Any] else {
                                completion(.error(WCError.genericError))
                                return
                            }
                            guard let title = project["title"] as? String else {
                                completion(.error(WCError.genericError))
                                return
                            }
                            project["id"] = allProjects[i]
                            if title.hasPrefix(preffix) {
                                projectsResponse.append(project)
                            }
                            if i == allProjects.count-1 {
                                let mappedResponse = Mapper<T>().mapArray(JSONArray: projectsResponse)
                                completion(.success(mappedResponse))
                            }
                        }
                }
            }
    }
    
    func fetchSearchFinishedProjects<T: Mappable>(request: [String : Any],
                                                  completion: @escaping (BaseResponse<[T]>) -> Void) {
        var projectsResponse: [[String : Any]] = .empty
        var allProjects = [String]()
        
        guard let preffix = request["preffix"] as? String else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.finishedProjectsCataloguePath)
            .observeSingleEvent(of: .value) { snapshot in
                if let projectIds = snapshot.value as? [String] {
                    allProjects = projectIds
                } else {
                    completion(.success(.empty))
                    return
                }
                for i in 0..<allProjects.count {
                    self.realtimeDB
                        .child(Paths.projectsPath)
                        .child(Paths.finishedProjectsPath)
                        .child(allProjects[i])
                        .observeSingleEvent(of: .value) { snapshot in
                            guard var project = snapshot.value as? [String : Any] else {
                                completion(.error(WCError.genericError))
                                return
                            }
                            guard let title = project["title"] as? String else {
                                completion(.error(WCError.genericError))
                                return
                            }
                            project["id"] = allProjects[i]
                            if title.hasPrefix(preffix) {
                                projectsResponse.append(project)
                            }
                            if i == allProjects.count-1 {
                                let mappedResponse = Mapper<T>().mapArray(JSONArray: projectsResponse)
                                completion(.success(mappedResponse))
                            }
                        }
                }
            }
    }
    
    func fetchDataFromId<T: Mappable>(request: [String : Any],
                                      completion: @escaping (BaseResponse<T>) -> Void) {
        guard let id = request["id"] as? String else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.usersPath)
            .child(id)
            .observeSingleEvent(of: .value) { snapshot in
                if let user = snapshot.value as? [String : Any] {
                    guard let title = user["name"] as? String,
                          let image = user["profile_image_url"] as? String else {
                        completion(.error(WCError.genericError))
                        return
                    }
                    let response: [String : Any] = ["image": image, "name": title]
                    guard let mappedResponse = Mapper<T>().map(JSON: response) else {
                        completion(.error(WCError.parseError))
                        return
                    }
                    completion(.success(mappedResponse))
                } else {
                    self.realtimeDB
                        .child(Paths.projectsPath)
                        .child(Paths.ongoingProjectsPath)
                        .child(id)
                        .observeSingleEvent(of: .value) { snpashot in
                            guard let project = snapshot.value as? [String : Any] else {
                                completion(.error(WCError.genericError))
                                return
                            }
                            guard let title = project["title"] as? String,
                                  let image = project["image"] as? String else {
                                completion(.error(WCError.genericError))
                                return
                            }
                            let response: [String : Any] = ["image": image, "title": title]
                            guard let mappedResponse = Mapper<T>().map(JSON: response) else {
                                completion(.error(WCError.parseError))
                                return
                            }
                            completion(.success(mappedResponse))
                        }
                }
            }
    }
    
    func fetchGeneralProfileSuggestions<T: Mappable>(request: [String : Any],
                                                     completion: @escaping ((BaseResponse<[T]>) -> Void)) {
        var userSuggestions = [String]()
        var queriedUsers = [[String : Any]]()
        var currentUserConnections = [String]()
        var currentUserProjects = [String]()
        var currentUserCathegories = [String]()
        var removedUserSuggestions = [String]()
        
        guard let limit = request["limit"] as? Int else {
            completion(.error(WCError.genericError))
            return
        }
        guard let currentUser = authReference.currentUser?.uid else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.usersPath)
            .child(currentUser)
            .child("removed_suggestions")
            .observeSingleEvent(of: .value) { snapshot in
                if let removedUsers = snapshot.value as? [String] {
                    removedUserSuggestions = removedUsers
                }
                self.realtimeDB
                    .child(Paths.usersPath)
                    .child(currentUser)
                    .child("interest_cathegories")
                    .observeSingleEvent(of: .value) { snapshot in
                        if let cathegories = snapshot.value as? [String] {
                            currentUserCathegories = cathegories
                        }
                        self.realtimeDB
                            .child(Paths.usersPath)
                            .child(currentUser)
                            .child("participating_projects")
                            .observeSingleEvent(of: .value) { snapshot in
                                if let projects = snapshot.value as? [String] {
                                    currentUserProjects = projects
                                }
                                self.realtimeDB
                                    .child(currentUser)
                                    .child("connections")
                                    .observeSingleEvent(of: .value) { snapshot in
                                        if let connections = snapshot.value as? [String] {
                                            currentUserConnections = connections
                                        }
                                        self.realtimeDB
                                            .child(Paths.allUsersCataloguePath)
                                            .observeSingleEvent(of: .value) { snapshot in
                                                guard let allUsers = snapshot.value as? [String] else {
                                                    completion(.error(WCError.genericError))
                                                    return
                                                }
                                                let noRelationUsersDispatchGroup = DispatchGroup()
                                                for user in allUsers {
                                                    noRelationUsersDispatchGroup.enter()
                                                    if user != currentUser,
                                                       !removedUserSuggestions.contains(user) {
                                                        self.checkConnected(request: FetchUserRelationRequest(fromUserId: currentUser, toUserId: user)) { response in
                                                            guard !response else {
                                                                noRelationUsersDispatchGroup.leave()
                                                                return
                                                            }
                                                            self.checkPending(request: FetchUserRelationRequest(fromUserId: currentUser, toUserId: user)) { response in
                                                                guard !response else {
                                                                    noRelationUsersDispatchGroup.leave()
                                                                    return
                                                                }
                                                                self.checkSent(request: FetchUserRelationRequest(fromUserId: currentUser, toUserId: user)) { response in
                                                                    if !response {
                                                                        userSuggestions.append(user)
                                                                    }
                                                                    noRelationUsersDispatchGroup.leave()
                                                                }
                                                            }
                                                        }
                                                    } else {
                                                        noRelationUsersDispatchGroup.leave()
                                                    }
                                                }
                                                //PHASE 2: FETCH ALL FILTERED USERS DATA
                                                noRelationUsersDispatchGroup.notify(queue: .main) {
                                                    let usersDataQueryDispatchGroup = DispatchGroup()
                                                    for user in userSuggestions {
                                                        usersDataQueryDispatchGroup.enter()
                                                        self.realtimeDB
                                                            .child(Paths.usersPath)
                                                            .child(user)
                                                            .observeSingleEvent(of: .value) { snapshot in
                                                                guard var userData = snapshot.value as? [String : Any] else {
                                                                    completion(.error(WCError.genericError))
                                                                    return
                                                                }
                                                                userData["id"] = user
                                                                queriedUsers.append(userData)
                                                                usersDataQueryDispatchGroup.leave()
                                                            }
                                                    }
                                                    usersDataQueryDispatchGroup.notify(queue: .main) {
                                                        for index in 0..<queriedUsers.count {
                                                            var userConnections = [String]()
                                                            if let connections = queriedUsers[index]["connections"] as? [String] {
                                                                userConnections = connections
                                                            }
                                                            let commonConnectionsCount = userConnections.filter({ currentUserConnections.contains($0) }).count
                                                            var userProjects = [String]()
                                                            if let projects = queriedUsers[index]["participating_projects"] as? [String] {
                                                                userProjects = projects
                                                            }
                                                            let commonProjectsCount = userProjects.filter({ currentUserProjects.contains($0) }).count
                                                            var userCathegories = [String]()
                                                            if let cathegories = queriedUsers[index]["interest_cathegories"] as? [String] {
                                                                userCathegories = cathegories
                                                            }
                                                            let commonInterestCathegoriesCount = userCathegories.filter({ currentUserCathegories.contains($0) }).count
                                                            let totalScore = commonConnectionsCount * self.commonConnectionsScore + commonProjectsCount * self.commonProjectsScore + commonInterestCathegoriesCount * self.commonCathegoriesScore
                                                            queriedUsers[index]["score"] = totalScore
                                                        }
                                                        queriedUsers.sort(by: {
                                                            guard let score0 = $0["score"] as? Int,
                                                                  let score1 = $1["score"] as? Int else {
                                                                return true
                                                            }
                                                            return score0 > score1
                                                        })
                                                        let responseSuggestions = queriedUsers.prefix(limit)
                                                        let mappedResponse = Mapper<T>().mapArray(JSONArray: Array(responseSuggestions))
                                                        completion(.success(mappedResponse))
                                                    }
                                                }
                                            }
                                    }
                            }
                    }
            }
    }
    
    func fetchCommonConnectionsProfileSuggestions<T: Mappable>(request: [String : Any],
                                                               completion: @escaping (BaseResponse<[T]>) -> Void) {
        var currentUserConnections = [String]()
        var noRelationUsers = [String]()
        var usersDataResults = [[String : Any]]()
        var removedSuggestedUsers = [String]()
        
        guard let limit = request["limit"] as? Int else {
            completion(.error(WCError.genericError))
            return
        }
        guard let currentUser = authReference.currentUser?.uid else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.usersPath)
            .child(currentUser)
            .child("removed_suggestions")
            .observeSingleEvent(of: .value) { snapshot in
                if let removedUsers = snapshot.value as? [String] {
                    removedSuggestedUsers = removedUsers
                }
                self.realtimeDB
                    .child(Paths.usersPath)
                    .child(currentUser)
                    .child("connections")
                    .observeSingleEvent(of: .value) { snapshot in
                        if let connections = snapshot.value as? [String] {
                            currentUserConnections = connections
                        } else {
                            currentUserConnections = .empty
                        }
                        self.realtimeDB
                            .child(Paths.allUsersCataloguePath)
                            .observeSingleEvent(of: .value) { snapshot in
                                guard let allUsers = snapshot.value as? [String] else {
                                    completion(.error(WCError.genericError))
                                    return
                                }
                                let dispatchGroup = DispatchGroup()
                                for user in allUsers {
                                    dispatchGroup.enter()
                                    if user != currentUser,
                                       !removedSuggestedUsers.contains(user) {
                                        self.checkConnected(request: FetchUserRelationRequest(fromUserId: currentUser, toUserId: user)) { result in
                                            guard !result else {
                                                dispatchGroup.leave()
                                                return
                                            }
                                            self.checkSent(request: FetchUserRelationRequest(fromUserId: currentUser, toUserId: user)) { result in
                                                guard !result else {
                                                    dispatchGroup.leave()
                                                    return
                                                }
                                                self.checkPending(request: FetchUserRelationRequest(fromUserId: currentUser, toUserId: user)) { result in
                                                    guard !result else {
                                                        dispatchGroup.leave()
                                                        return
                                                    }
                                                    noRelationUsers.append(user)
                                                    dispatchGroup.leave()
                                                }
                                            }
                                        }
                                    } else {
                                        dispatchGroup.leave()
                                    }
                                }
                                dispatchGroup.notify(queue: .main) {
                                    let userDataDispatchGroup = DispatchGroup()
                                    for user in noRelationUsers {
                                        userDataDispatchGroup.enter()
                                        self.realtimeDB
                                            .child(Paths.usersPath)
                                            .child(user)
                                            .observeSingleEvent(of: .value) { snapshot in
                                                guard var userData = snapshot.value as? [String
                                                        : Any] else {
                                                    completion(.error(WCError.genericError))
                                                    return
                                                }
                                                var userConnections: [String] = .empty
                                                if let connections = userData["connections"] as? [String] {
                                                    userConnections = connections
                                                }
                                                let score = userConnections.filter({ currentUserConnections.contains($0) }).count
                                                userData["score"] = score
                                                userData["id"] = user
                                                usersDataResults.append(userData)
                                                userDataDispatchGroup.leave()
                                            }
                                    }
                                    userDataDispatchGroup.notify(queue: .main) {
                                        let orderedScores = Array(usersDataResults.sorted(by: {
                                            guard let score0 = $0["score"] as? Int,
                                                  let score1 = $1["score"] as? Int else {
                                                return true
                                            }
                                            return score0 > score1
                                        }).prefix(limit))
                                        let mappedResponse = Mapper<T>().mapArray(JSONArray: orderedScores)
                                        completion(.success(mappedResponse))
                                    }
                                }
                            }
                    }
            }
    }
    
    func fetchCommonProjectsProfileSuggestions<T: Mappable>(request: [String : Any],
                                                            completion: @escaping (BaseResponse<[T]>) -> Void) {
        var currentUserProjects = [String]()
        var noRelationUsers = [String]()
        var usersDataResults = [[String : Any]]()
        var removedSuggestedUsers = [String]()
        
        guard let limit = request["limit"] as? Int else {
            completion(.error(WCError.genericError))
            return
        }
        guard let currentUser = authReference.currentUser?.uid else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.usersPath)
            .child(currentUser)
            .child("removed_suggestions")
            .observeSingleEvent(of: .value) { snapshot in
                if let removedUsers = snapshot.value as? [String] {
                    removedSuggestedUsers = removedUsers
                }
                self.realtimeDB
                    .child(Paths.usersPath)
                    .child(currentUser)
                    .child("participating_projects")
                    .observeSingleEvent(of: .value) { snapshot in
                        if let projects = snapshot.value as? [String] {
                            currentUserProjects = projects
                        } else {
                            currentUserProjects = .empty
                        }
                        self.realtimeDB
                            .child(Paths.allUsersCataloguePath)
                            .observeSingleEvent(of: .value) { snapshot in
                                guard let allUsers = snapshot.value as? [String] else {
                                    completion(.error(WCError.genericError))
                                    return
                                }
                                let dispatchGroup = DispatchGroup()
                                for user in allUsers {
                                    dispatchGroup.enter()
                                    if user != currentUser,
                                       !removedSuggestedUsers.contains(user) {
                                        self.checkConnected(request: FetchUserRelationRequest(fromUserId: currentUser, toUserId: user)) { result in
                                            guard !result else {
                                                dispatchGroup.leave()
                                                return
                                            }
                                            self.checkSent(request: FetchUserRelationRequest(fromUserId: currentUser, toUserId: user)) { result in
                                                guard !result else {
                                                    dispatchGroup.leave()
                                                    return
                                                }
                                                self.checkPending(request: FetchUserRelationRequest(fromUserId: currentUser, toUserId: user)) { result in
                                                    guard !result else {
                                                        dispatchGroup.leave()
                                                        return
                                                    }
                                                    noRelationUsers.append(user)
                                                    dispatchGroup.leave()
                                                }
                                            }
                                        }
                                    } else {
                                        dispatchGroup.leave()
                                    }
                                }
                                dispatchGroup.notify(queue: .main) {
                                    let userDataDispatchGroup = DispatchGroup()
                                    for user in noRelationUsers {
                                        userDataDispatchGroup.enter()
                                        self.realtimeDB
                                            .child(Paths.usersPath)
                                            .child(user)
                                            .observeSingleEvent(of: .value) { snapshot in
                                                guard var userData = snapshot.value as? [String
                                                        : Any] else {
                                                    completion(.error(WCError.genericError))
                                                    return
                                                }
                                                var userProjects: [String] = .empty
                                                if let projects = userData["participating_projects"] as? [String] {
                                                    userProjects = projects
                                                }
                                                let score = userProjects.filter({ currentUserProjects.contains($0) }).count
                                                userData["score"] = score
                                                userData["id"] = user
                                                usersDataResults.append(userData)
                                                userDataDispatchGroup.leave()
                                            }
                                    }
                                    userDataDispatchGroup.notify(queue: .main) {
                                        let orderedScores = Array(usersDataResults.sorted(by: {
                                            guard let score0 = $0["score"] as? Int,
                                                  let score1 = $1["score"] as? Int else {
                                                return true
                                            }
                                            return score0 > score1
                                        }).prefix(limit))
                                        let mappedResponse = Mapper<T>().mapArray(JSONArray: orderedScores)
                                        completion(.success(mappedResponse))
                                    }
                                }
                            }
                    }
            }
    }
    
    func fetchCommonCathegoriesProfileSuggestions<T: Mappable>(request: [String : Any],
                                                               completion: @escaping (BaseResponse<[T]>) -> Void) {
        var currentUserCathegories = [String]()
        var noRelationUsers = [String]()
        var usersDataResults = [[String : Any]]()
        var removedSuggestedUsers = [String]()
        
        guard let limit = request["limit"] as? Int else {
            completion(.error(WCError.genericError))
            return
        }
        guard let currentUser = authReference.currentUser?.uid else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.usersPath)
            .child(currentUser)
            .child("removed_suggestions")
            .observeSingleEvent(of: .value) { snapshot in
                if let removedUsers = snapshot.value as? [String] {
                    removedSuggestedUsers = removedUsers
                }
                self.realtimeDB
                    .child(Paths.usersPath)
                    .child(currentUser)
                    .child("interest_cathegories")
                    .observeSingleEvent(of: .value) { snapshot in
                        if let cathegories = snapshot.value as? [String] {
                            currentUserCathegories = cathegories
                        } else {
                            currentUserCathegories = .empty
                        }
                        self.realtimeDB
                            .child(Paths.allUsersCataloguePath)
                            .observeSingleEvent(of: .value) { snapshot in
                                guard let allUsers = snapshot.value as? [String] else {
                                    completion(.error(WCError.genericError))
                                    return
                                }
                                let dispatchGroup = DispatchGroup()
                                for user in allUsers {
                                    dispatchGroup.enter()
                                    if user != currentUser,
                                       !removedSuggestedUsers.contains(user) {
                                        self.checkConnected(request: FetchUserRelationRequest(fromUserId: currentUser, toUserId: user)) { result in
                                            guard !result else {
                                                dispatchGroup.leave()
                                                return
                                            }
                                            self.checkSent(request: FetchUserRelationRequest(fromUserId: currentUser, toUserId: user)) { result in
                                                guard !result else {
                                                    dispatchGroup.leave()
                                                    return
                                                }
                                                self.checkPending(request: FetchUserRelationRequest(fromUserId: currentUser, toUserId: user)) { result in
                                                    guard !result else {
                                                        dispatchGroup.leave()
                                                        return
                                                    }
                                                    noRelationUsers.append(user)
                                                    dispatchGroup.leave()
                                                }
                                            }
                                        }
                                    } else {
                                        dispatchGroup.leave()
                                    }
                                }
                                dispatchGroup.notify(queue: .main) {
                                    let userDataDispatchGroup = DispatchGroup()
                                    for user in noRelationUsers {
                                        userDataDispatchGroup.enter()
                                        self.realtimeDB
                                            .child(Paths.usersPath)
                                            .child(user)
                                            .observeSingleEvent(of: .value) { snapshot in
                                                guard var userData = snapshot.value as? [String
                                                        : Any] else {
                                                    completion(.error(WCError.genericError))
                                                    return
                                                }
                                                var userCathegories: [String] = .empty
                                                if let cathegories = userData["interest_cathegories"] as? [String] {
                                                    userCathegories = cathegories
                                                }
                                                let score = userCathegories.filter({ currentUserCathegories.contains($0) }).count
                                                userData["score"] = score
                                                userData["id"] = user
                                                usersDataResults.append(userData)
                                                userDataDispatchGroup.leave()
                                            }
                                    }
                                    userDataDispatchGroup.notify(queue: .main) {
                                        let orderedScores = Array(usersDataResults.sorted(by: {
                                            guard let score0 = $0["score"] as? Int,
                                                  let score1 = $1["score"] as? Int else {
                                                return true
                                            }
                                            return score0 > score1
                                        }).prefix(limit))
                                        let mappedResponse = Mapper<T>().mapArray(JSONArray: orderedScores)
                                        completion(.success(mappedResponse))
                                    }
                                }
                            }
                    }
            }
    }
    
    func removeProfileSuggestion(request: [String : Any],
                                 completion: @escaping (EmptyResponse) -> Void) {
        guard let userId = request["userId"] as? String else {
            completion(.error(WCError.genericError))
            return
        }
        guard let currentUser = authReference.currentUser?.uid else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.allUsersCataloguePath)
            .observeSingleEvent(of: .value) { snapshot in
                guard let allUsers = snapshot.value as? [String] else {
                    completion(.error(WCError.genericError))
                    return
                }
                guard allUsers.contains(userId) else {
                    completion(.error(WCError.genericError))
                    return
                }
                self.realtimeDB
                    .child(Paths.usersPath)
                    .child(currentUser)
                    .child("removed_suggestions")
                    .observeSingleEvent(of: .value) { snapshot in
                        var removedUsers = [String]()
                        if let removedSuggestions = snapshot.value as? [String] {
                            removedUsers = removedSuggestions
                        }
                        removedUsers.append(userId)
                        self.realtimeDB
                            .child(Paths.usersPath)
                            .child(currentUser)
                            .updateChildValues(["removed_suggestions": removedUsers]) { (error, ref) in
                                if error != nil {
                                    completion(.error(WCError.removeSuggestion))
                                    return
                                }
                                completion(.success)
                            }
                    }
            }
    }
    
    func fetchOnGoingProjectsFeed<T: Mappable>(request: [String : Any],
                                               completion: @escaping (BaseResponse<[T]>) -> Void) {
        var allProjects = [String]()
        var allProjectsData = [[String : Any]]()
        var currentUserconnections = [String]()
        var currentUserInterestCathegories = [String]()
        
        guard let limits = request["limits"] as? Int,
              let fromConnections = request["fromConnections"] as? Bool,
              let cathegory = request["cathegory"] as? String else {
            completion(.error(WCError.genericError))
            return
        }
        guard let currentUser = authReference.currentUser?.uid else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.usersPath)
            .child(currentUser)
            .child("interest_cathegories")
            .observeSingleEvent(of: .value) { snapshot in
                guard let cathegories = snapshot.value as? [String] else {
                    completion(.error(WCError.genericError))
                    return
                }
                currentUserInterestCathegories = cathegories
                self.realtimeDB
                    .child(Paths.usersPath)
                    .child(currentUser)
                    .child("connections")
                    .observeSingleEvent(of: .value) { snapshot in
                        if let connections = snapshot.value as? [String] {
                            currentUserconnections = connections
                        } else {
                            currentUserconnections = .empty
                        }
                        self.realtimeDB
                            .child(Paths.allProjectsCataloguePath)
                            .observeSingleEvent(of: .value) { snapshot in
                                if let projects = snapshot.value as? [String] {
                                    allProjects = projects
                                } else {
                                    allProjects = .empty
                                }
                                let projectsDetailsDispatchGroup = DispatchGroup()
                                for project in allProjects {
                                    projectsDetailsDispatchGroup.enter()
                                    self.realtimeDB
                                        .child(Paths.projectsPath)
                                        .child(Paths.ongoingProjectsPath)
                                        .child(project)
                                        .observeSingleEvent(of: .value) { snapshot in
                                            guard var projectData = snapshot.value as? [String : Any] else {
                                                completion(.error(WCError.genericError))
                                                return
                                            }
                                            guard let participants = projectData["participants"] as? [String],
                                                  let cathegories = projectData["cathegories"] as? [String] else {
                                                completion(.error(WCError.genericError))
                                                return
                                            }
                                            let connectionsCount = participants.filter({currentUserconnections.contains($0)}).count
                                            let commonCathegoriesCount = cathegories.filter({currentUserInterestCathegories.contains($0)}).count
                                            projectData["score"] = self.connectionInProjectScore * connectionsCount + self.projectCathegoriesScore *  commonCathegoriesCount
                                            allProjectsData.append(projectData)
                                            projectsDetailsDispatchGroup.leave()
                                        }
                                }
                                projectsDetailsDispatchGroup.notify(queue: .main) {
                                    var projectsWithoutCurrentUser = allProjectsData.filter({
                                        guard let participants = $0["participants"] as? [String] else {
                                            return false
                                        }
                                        return !participants.contains(currentUser)
                                    })
                                    if fromConnections {
                                        projectsWithoutCurrentUser = projectsWithoutCurrentUser.filter({
                                            guard let participants = $0["participants"] as? [String] else {
                                                return false
                                            }
                                            return participants
                                                .filter({currentUserconnections.contains($0)}).count > 0
                                        })
                                    }
                                    projectsWithoutCurrentUser = projectsWithoutCurrentUser.filter({
                                        guard let cathegories = $0["cathegories"] as? [String] else {
                                            return false
                                        }
                                        return currentUserInterestCathegories
                                            .filter({cathegories.contains($0)}).count > 0
                                    })
                                    if cathegory != "Todos", cathegory != "Conexões" {
                                        projectsWithoutCurrentUser = projectsWithoutCurrentUser.filter({
                                            guard let cathegories = $0["cathegories"] as? [String] else {
                                                return false
                                            }
                                            return cathegories.contains(cathegory)
                                        })
                                    }
                                    projectsWithoutCurrentUser = projectsWithoutCurrentUser.sorted(by: {
                                        guard let score0 = $0["score"] as? Int,
                                              let score1 = $1["score"] as? Int else {
                                            return false
                                        }
                                        return score0 > score1
                                    })
                                    projectsWithoutCurrentUser = Array(projectsWithoutCurrentUser.prefix(limits))
                                    let mappedResponse = Mapper<T>().mapArray(JSONArray: projectsWithoutCurrentUser)
                                    completion(.success(mappedResponse))
                                }
                            }
                    }
            }
    }
    
    func publishProject(request: [String : Any],
                        completion: @escaping (EmptyResponse) -> Void) {
        var finishedProjects = [String]()
        var allUsers = [String]()
        
        guard let projectId = request["projectId"] as? String,
              let youtubeURL = request["youtube_url"] as? String,
              let title = request["title"] as? String,
              let sinopsis = request["sinopsis"] as? String,
              let cathegories = request["cathegories"] as? [String],
              let participants = request["participants"] as? [String],
              let image = request["image"] as? String,
              let finishDate = request["finish_date"] as? Int else {
            completion(.error(WCError.genericError))
            return
        }
        guard let authorId = authReference.currentUser?.uid else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.allProjectsCataloguePath)
            .observeSingleEvent(of: .value) { snapshot in
                guard var allProjects = snapshot.value as? [String] else {
                    completion(.error(WCError.genericError))
                    return
                }
                allProjects.removeAll(where: { $0 == projectId})
                self.realtimeDB
                    .updateChildValues([Paths.allProjectsCataloguePath : allProjects]) { (error, ref) in
                        if error != nil {
                            completion(.error(WCError.genericError))
                            return
                        }
                        self.realtimeDB
                            .child(Paths.finishedProjectsCataloguePath)
                            .observeSingleEvent(of: .value) { snapshot in
                                if let projects = snapshot.value as? [String] {
                                    finishedProjects = projects
                                }
                                finishedProjects.append(projectId)
                                self.realtimeDB
                                    .updateChildValues([Paths.finishedProjectsCataloguePath : finishedProjects]) { (error, ref) in
                                        if error != nil {
                                            completion(.error(WCError.genericError))
                                            return
                                        }
                                        self.realtimeDB
                                            .child(Paths.projectsPath)
                                            .child(Paths.ongoingProjectsPath)
                                            .child(projectId)
                                            .removeValue { (error, ref) in
                                                if error != nil {
                                                    completion(.error(WCError.genericError))
                                                    return
                                                }
                                                let dict: [String : Any] = ["youtube_url": youtubeURL, "title": title, "sinopsis": sinopsis, "cathegories": cathegories, "participants": participants, "author_id": authorId, "image": image, "finish_date": finishDate, "views": 0]
                                                self.realtimeDB
                                                    .child(Paths.projectsPath)
                                                    .child(Paths.finishedProjectsPath)
                                                    .child(projectId)
                                                    .updateChildValues(dict) { (error, ref) in
                                                        if error != nil {
                                                            completion(.error(WCError.genericError))
                                                            return
                                                        }
                                                        let dispatchGroup = DispatchGroup()
                                                        self.realtimeDB
                                                            .child(Paths.allUsersCataloguePath)
                                                            .observeSingleEvent(of: .value) { snapshot in
                                                                guard let users = snapshot.value as? [String] else {
                                                                    completion(.error(WCError.genericError))
                                                                    return
                                                                }
                                                                allUsers = users
                                                                for user in allUsers {
                                                                    dispatchGroup.enter()
                                                                    self.realtimeDB.child(Paths.usersPath).child(user)
                                                                        .child("participating_projects").observeSingleEvent(of: .value) { snapshot in
                                                                            if var projects = snapshot.value as? [String] {
                                                                                if projects.contains(projectId) {
                                                                                    projects.removeAll(where: { $0 == projectId})
                                                                                    self.realtimeDB.child(Paths.usersPath).child(user).updateChildValues(["participating_projects" : projects]) { (error, ref) in
                                                                                        if error != nil {
                                                                                            completion(.error(WCError.genericError))
                                                                                            return
                                                                                        }
                                                                                        self.realtimeDB.child(Paths.usersPath).child(user).child("finished_projects").observeSingleEvent(of: .value) { snapshot in
                                                                                            var projects = [String]()
                                                                                            if let finishedProjects = snapshot.value as? [String] {
                                                                                                projects = finishedProjects
                                                                                            }
                                                                                            projects.append(projectId)
                                                                                            self.realtimeDB.child(Paths.usersPath).child(user).updateChildValues(["finished_projects" : projects]) { (error, ref) in
                                                                                                if error != nil {
                                                                                                    completion(.error(WCError.genericError))
                                                                                                    return
                                                                                                }
                                                                                                dispatchGroup.leave()
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                } else {
                                                                                    dispatchGroup.leave()
                                                                                }
                                                                            } else {
                                                                                dispatchGroup.leave()
                                                                            }
                                                                        }
                                                                }
                                                                dispatchGroup.notify(queue: .main) {
                                                                    self.removeEntity(withId: projectId) { response in
                                                                        switch response {
                                                                        case .error(let _):
                                                                            completion(.error(WCError.genericError))
                                                                        case.success:
                                                                            self.registerEntity(withId: projectId, type: .finishedProject) {
                                                                                response in
                                                                                switch response {
                                                                                case .error(let error):
                                                                                    completion(.error(WCError.genericError))
                                                                                case.success:
                                                                                    completion(.success)
                                                                                }
                                                                                }
                                                                        }
                                                                        
                                                                    }
                                                                }
                                                            }
                                                    }
                                            }
                                    }
                            }
                    }
            }
    }
    
    func fetchFinishedProjectData<T: Mappable>(request: [String : Any],
                                               completion: @escaping (BaseResponse<T>) -> Void) {
        guard let projectId = request["projectId"] as? String else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.projectsPath)
            .child(Paths.finishedProjectsPath)
            .child(projectId)
            .observeSingleEvent(of: .value) { snapshot in
                guard var project = snapshot.value as? [String : Any] else {
                    completion(.error(WCError.parseError))
                    return
                }
                project["projectId"] = projectId
                guard let mappedResponse = Mapper<T>().map(JSON: project) else {
                    completion(.error(WCError.parseError))
                    return
                }
                completion(.success(mappedResponse))
            }
    }
    
    func fetchFinishedProjectRelation<T: Mappable>(request: [String : Any],
                                                   completion: @escaping (BaseResponse<T>) -> Void) {
        guard let projectId = request["projectId"] as? String else {
            completion(.error(WCError.genericError))
            return
        }
        guard let currentUser = authReference.currentUser?.uid else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.projectsPath)
            .child(Paths.finishedProjectsPath)
            .child(projectId)
            .child("author_id")
            .observeSingleEvent(of: .value) { snapshot in
                guard let authorId = snapshot.value as? String else {
                    completion(.error(WCError.genericError))
                    return
                }
                if authorId == currentUser {
                    let dict: [String : Any] = ["relation": "AUTHOR"]
                    guard let mappedResponse = Mapper<T>().map(JSON: dict) else {
                        completion(.error(WCError.parseError))
                        return
                    }
                    completion(.success(mappedResponse))
                    return
                }
                self.realtimeDB
                    .child(Paths.projectsPath)
                    .child(Paths.finishedProjectsPath)
                    .child(projectId)
                    .child("participants")
                    .observeSingleEvent(of: .value) { snapshot in
                        guard let participants = snapshot.value as? [String] else {
                            completion(.error(WCError.genericError))
                            return
                        }
                        if participants.contains(currentUser) {
                            let dict: [String : Any] = ["relation": "SIMPLE_PARTICIPANT"]
                            guard let mappedResponse = Mapper<T>().map(JSON: dict) else {
                                completion(.error(WCError.parseError))
                                return
                            }
                            completion(.success(mappedResponse))
                            return
                        }
                        self.realtimeDB
                            .child(Paths.projectsPath)
                            .child(Paths.finishedProjectsPath)
                            .child(projectId)
                            .child("pending_invites")
                            .observeSingleEvent(of: .value) { snapshot in
                                var invitedUsers = [String]()
                                if let pendingInvites = snapshot.value as? [String] {
                                    invitedUsers = pendingInvites
                                } else {
                                    invitedUsers = .empty
                                }
                                if invitedUsers.contains(currentUser) {
                                    let dict: [String : Any] = ["relation": "PENDING"]
                                    guard let mappedResponse = Mapper<T>().map(JSON: dict) else {
                                        completion(.error(WCError.parseError))
                                        return
                                    }
                                    completion(.success(mappedResponse))
                                    return
                                }
                                let dict: [String : Any] = ["relation": "NOTHING"]
                                guard let mappedResponse = Mapper<T>().map(JSON: dict) else {
                                    completion(.error(WCError.parseError))
                                    return
                                }
                                completion(.success(mappedResponse))
                                return
                            }
                    }
            }
    }
    
    func fetchUserFinishedProjects<T: Mappable>(request: [String : Any],
                                                completion: @escaping (BaseResponse<[T]>) -> Void) {
        var finishedProjects = [String]()
        var finishedProjectsData = [[String : Any]]()
        guard let userId = request["userId"] as? String else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.usersPath)
            .child(userId)
            .child("finished_projects")
            .observeSingleEvent(of: .value) { snapshot in
                if let projects = snapshot.value as? [String] {
                    finishedProjects = projects
                } else {
                    let mappedResponse = Mapper<T>().mapArray(JSONArray: .empty)
                    completion(.success(mappedResponse))
                    return
                }
                let dispatchGroup = DispatchGroup()
                for project in finishedProjects {
                    dispatchGroup.enter()
                    self.realtimeDB
                        .child(Paths.projectsPath)
                        .child(Paths.finishedProjectsPath)
                        .child(project)
                        .observeSingleEvent(of: .value) { snapshot in
                            guard var projectData = snapshot.value as? [String : Any] else {
                                completion(.error(WCError.genericError))
                                return
                            }
                            projectData["projectId"] = project
                            finishedProjectsData.append(projectData)
                            dispatchGroup.leave()
                        }
                }
                dispatchGroup.notify(queue: .main) {
                    let mappedResponse = Mapper<T>().mapArray(JSONArray: finishedProjectsData)
                    completion(.success(mappedResponse))
                }
            }
    }
    
    func publishNewProject<T: Mappable>(request: [String : Any],
                                        completion: @escaping (BaseResponse<T>) -> Void) {
        var allFinishedProjects = [String]()
        var userProjects = [String]()
        
        guard let title = request["title"] as? String,
              let sinopsis = request["sinopsis"] as? String,
              let cathegories = request["cathegories"] as? [String],
              let video = request["youtube_url"] as? String,
              let image = request["image"] as? Data else {
            completion(.error(WCError.genericError))
            return
        }
        guard let currentUser = authReference.currentUser?.uid else {
            completion(.error(WCError.genericError))
            return
        }
        let projectReference = realtimeDB
            .child(Paths.projectsPath)
            .child(Paths.finishedProjectsPath)
            .childByAutoId()
        guard let projectId = projectReference.key else {
            completion(.error(WCError.genericError))
            return
        }
        let projectImageReference =  storage.child(Paths.projectsPath).child(projectId)
        projectImageReference.putData(image, metadata: nil) { (metadata, error) in
            if error != nil {
                completion(.error(WCError.genericError))
                return
            }
            projectImageReference.downloadURL { (url, error) in
                if error != nil {
                    completion(.error(WCError.genericError))
                    return
                }
                guard let url = url else {
                    completion(.error(WCError.genericError))
                    return
                }
                let dict: [String : Any] = ["title": title, "sinopsis": sinopsis, "cathegories": cathegories, "youtube_url": video, "image": url.absoluteString, "views": 0, "finish_date": Date().timeIntervalSince1970, "participants": [currentUser], "author_id": currentUser]
                self.realtimeDB
                    .child(Paths.projectsPath)
                    .child(Paths.finishedProjectsPath)
                    .updateChildValues([projectId : dict]) { (error, metadata) in
                        if error != nil {
                            completion(.error(WCError.genericError))
                            return
                        }
                        self.realtimeDB
                            .child(Paths.finishedProjectsCataloguePath)
                            .observeSingleEvent(of: .value) { snapshot in
                                if let projects = snapshot.value as? [String] {
                                    allFinishedProjects = projects
                                }
                                allFinishedProjects.append(projectId)
                                self.realtimeDB.updateChildValues([Paths.finishedProjectsCataloguePath: allFinishedProjects]) { (error, metadata) in
                                    if error != nil {
                                        completion(.error(WCError.genericError))
                                        return
                                    }
                                    self.realtimeDB
                                        .child(Paths.usersPath)
                                        .child(currentUser)
                                        .child("finished_projects")
                                        .observeSingleEvent(of: .value) { snapshot in
                                            if let projects = snapshot.value as? [String] {
                                                userProjects = projects
                                            }
                                            userProjects.append(projectId)
                                            self.realtimeDB.child(Paths.usersPath).child(currentUser).updateChildValues(["finished_projects": userProjects]) { (error, metadata) in
                                                if error != nil {
                                                    completion(.error(WCError.genericError))
                                                    return
                                                }
                                                let dict: [String : Any] = ["id": projectId]
                                                guard let mappedResponse = Mapper<T>().map(JSON: dict) else {
                                                    completion(.error(WCError.parseError))
                                                    return
                                                }
                                                self.registerEntity(withId: projectId, type: .finishedProject) {
                                                    response in
                                                    switch response {
                                                    case .error(let error):
                                                        completion(.error(WCError.genericError))
                                                    case .success:
                                                        completion(.success(mappedResponse))
                                                    }
                                                }
                                            }
                                        }
                                }
                            }
                    }
            }
        }
    }
    
    func addViewToProject(request: [String : Any],
                          completion: @escaping (EmptyResponse) -> Void) {
        guard let projectId = request["projectId"] as? String else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.projectsPath)
            .child(Paths.finishedProjectsPath)
            .child(projectId)
            .child("views")
            .observeSingleEvent(of: .value) { snapshot in
                guard var views = snapshot.value as? Int else {
                    completion(.error(WCError.genericError))
                    return
                }
                views+=1
                let lastSeenTimestamp = Date().timeIntervalSince1970
                self.realtimeDB
                    .child(Paths.projectsPath)
                    .child(Paths.finishedProjectsPath)
                    .child(projectId)
                    .updateChildValues(["views": views, "last_view": lastSeenTimestamp]) { (error, ref) in
                        if error != nil {
                            completion(.error(WCError.genericError))
                            return
                        }
                    }
            }
    }
    
    func fetchFinishedProjectsLogicFeed<T: Mappable>(request: [String : Any],
                                                     completion: @escaping (BaseResponse<[T]>) -> Void) {
        guard let criteria = request["criteria"] as? String else {
            completion(.error(WCError.genericError))
            return
        }
        guard let currentUser = authReference.currentUser?.uid else {
            completion(.error(WCError.genericError))
            return
        }
        let newCriteria = FinishedProjectsLogicCriteria(rawValue: criteria)
        switch newCriteria {
        case .connections:
            fetchFinishedConnectionsFeed(currentUser: currentUser, completion: completion)
        case .popular:
            fetchFinishedPopularFeed(currentUser: currentUser, completion: completion)
        case .recent:
            fetchFinishedRecentFeed(currentUser: currentUser, completion: completion)
        case .none:
            completion(.error(WCError.genericError))
        }
    }
    
    func fetchFinishedProjectCathegoryFeed<T: Mappable>(request: [String : Any],
                                                        completion: @escaping (BaseResponse<[T]>) -> Void) {
        var finishedProjects = [String]()
        var userProjects = [String]()
        var finishedProjectsData = [[String: Any]]()
        
        guard let cathegory = request["cathegory"] as? String else {
            completion(.error(WCError.genericError))
            return
        }
        guard let currentUser = authReference.currentUser?.uid else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.finishedProjectsCataloguePath)
            .observeSingleEvent(of: .value) { snapshot in
                guard let projects = snapshot.value as? [String] else {
                    completion(.success(.empty))
                    return
                }
                finishedProjects = projects
                self.realtimeDB
                    .child(Paths.usersPath)
                    .child(currentUser)
                    .child("finished_projects")
                    .observeSingleEvent(of: .value) { snapshot in
                        if let projects = snapshot.value as? [String] {
                            userProjects = projects
                        }
                        finishedProjects = finishedProjects.filter({ !userProjects.contains($0)})
                        let dispatchGroup = DispatchGroup()
                        for project in finishedProjects {
                            dispatchGroup.enter()
                            self.realtimeDB
                                .child(Paths.projectsPath)
                                .child(Paths.finishedProjectsPath)
                                .child(project)
                                .child("cathegories")
                                .observeSingleEvent(of: .value) { snapshot in
                                    guard let cathegories = snapshot.value as? [String] else {
                                        completion(.error(WCError.genericError))
                                        return
                                    }
                                    if !cathegories.contains(cathegory) {
                                        finishedProjects.removeAll(where: { $0 == project})
                                    }
                                    dispatchGroup.leave()
                                }
                        }
                        dispatchGroup.notify(queue: .main) {
                            let newDispatchGroup = DispatchGroup()
                            for projectId in finishedProjects {
                                newDispatchGroup.enter()
                                self.realtimeDB
                                    .child(Paths.projectsPath)
                                    .child(Paths.finishedProjectsPath)
                                    .child(projectId)
                                    .observeSingleEvent(of: .value) { snapshot in
                                        guard var project = snapshot.value as? [String: Any] else {
                                            completion(.error(WCError.genericError))
                                            return
                                        }
                                        project["id"] = projectId
                                        finishedProjectsData.append(project)
                                        newDispatchGroup.leave()
                                    }
                            }
                            newDispatchGroup.notify(queue: .main) {
                                let mappedResponse = Mapper<T>().mapArray(JSONArray: finishedProjectsData)
                                completion(.success(mappedResponse))
                            }
                        }
                    }
            }
    }
    
    func fetchFinishedProjectsNewFeed<T: Mappable>(request: [String : Any],
                                                   completion: @escaping (BaseResponse<[T]>) -> Void) {
        var finishedProjects = [String]()
        var userProjects = [String]()
        var finishedProjectsData = [[String: Any]]()
        
        guard let currentUser = authReference.currentUser?.uid else {
            completion(.error(WCError.genericError))
            return
        }
        
        realtimeDB
            .child(Paths.finishedProjectsCataloguePath)
            .observeSingleEvent(of: .value) { snapshot in
                guard let projects = snapshot.value as? [String] else {
                    completion(.success(.empty))
                    return
                }
                finishedProjects = projects
                self.realtimeDB
                    .child(Paths.usersPath)
                    .child(currentUser)
                    .child("finished_projects")
                    .observeSingleEvent(of: .value) { snapshot in
                        if let projects = snapshot.value as? [String] {
                            userProjects = projects
                        }
                        finishedProjects = finishedProjects.filter({ !userProjects.contains($0)})
                        let dispatchGroup = DispatchGroup()
                        for project in finishedProjects {
                            dispatchGroup.enter()
                            self.realtimeDB
                                .child(Paths.projectsPath)
                                .child(Paths.finishedProjectsPath)
                                .child(project)
                                .observeSingleEvent(of: .value) { snapshot in
                                    guard var projectData = snapshot.value as? [String : Any] else {
                                        completion(.error(WCError.genericError))
                                        return
                                    }
                                    projectData["id"] = project
                                    finishedProjectsData.append(projectData)
                                    dispatchGroup.leave()
                                }
                        }
                        dispatchGroup.notify(queue: .main) {
                            finishedProjectsData.sort(by: { project1, project2 in
                                guard let date1 = project1["finish_date"] as? Double,
                                      let date2 = project2["finish_date"] as? Double else {
                                    return false
                                }
                                return date1 > date2
                            })
                            let mappedResponse = Mapper<T>().mapArray(JSONArray: finishedProjectsData)
                            completion(.success(mappedResponse))
                        }
                    }
            }
    }
    
    func inviteUserToFinishedProject(request: [String : Any],
                                     completion: @escaping (EmptyResponse) -> Void) {
        var pendingInvites = [String]()
        var inviteNotifications = [[String : Any]]()
        
        guard let projectId = request["projectId"] as? String,
              let userId = request["userId"] as? String,
              let currentUser = authReference.currentUser?.uid else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.projectsPath)
            .child(Paths.finishedProjectsPath)
            .child(projectId)
            .child("pending_invites")
            .observeSingleEvent(of: .value) { snapshot in
                if let pendingUsers = snapshot.value as? [String] {
                    pendingInvites = pendingUsers
                }
                pendingInvites.append(userId)
                self.realtimeDB.child(Paths.projectsPath).child(Paths.finishedProjectsPath).child(projectId).updateChildValues(["pending_invites": pendingInvites]) { (error, ref) in
                    if error != nil {
                        completion(.error(WCError.inviteUserToProject))
                        return
                    }
                    self.realtimeDB
                        .child(Paths.projectsPath)
                        .child(Paths.finishedProjectsPath)
                        .child(projectId)
                        .observeSingleEvent(of: .value) { snapshot in
                            guard let projectData = snapshot.value as? [String : Any] else {
                                completion(.error(WCError.genericError))
                                return
                            }
                            self.realtimeDB
                                .child(Paths.usersPath)
                                .child(userId)
                                .child("finished_project_invite_notifications")
                                .observeSingleEvent(of: .value) { snapshot in
                                    if let notifications = snapshot.value as? [[String : Any]] {
                                        inviteNotifications = notifications
                                    }
                                    guard
                                        let image = projectData["image"],
                                        let projectTitle = projectData["title"] as? String else {
                                        completion(.error(WCError.genericError))
                                        return
                                    }
                                    self.realtimeDB
                                        .child(Paths.usersPath)
                                        .child(currentUser)
                                        .observeSingleEvent(of: .value) { snapshot in
                                            guard let data = snapshot.value as? [String : Any], let authorName = data["name"] as? String else {
                                                completion(.error(WCError.genericError))
                                                return
                                            }
                                            inviteNotifications.append(["projectId": projectId,
                                                                        "userId" : userId,
                                                                        "authorId": currentUser,
                                                                        "authorName": authorName,
                                                                        "image": image,
                                                                        "projectTitle": projectTitle])
                                            self.realtimeDB
                                                .child(Paths.usersPath)
                                                .child(userId)
                                                .updateChildValues(["finished_project_invite_notifications" : inviteNotifications]) { (error, ref) in
                                                    if error != nil {
                                                        completion(.error(WCError.inviteUserToProject))
                                                        return
                                                    }
                                                    completion(.success)
                                                }
                                        }
                                }
                        }
                }
            }
    }
    
    func fetchFinishedProjectInviteNotifications<T: Mappable>(request: [String : Any],
                                                              completion: @escaping (BaseResponse<[T]>) -> Void) {
        guard let currentUser = authReference.currentUser?.uid else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.usersPath)
            .child(currentUser)
            .child("finished_project_invite_notifications")
            .observeSingleEvent(of: .value) { snapshot in
                guard let allNotifications = snapshot.value as? [[String : Any]] else {
                    completion(.success(.empty))
                    return
                }
                let mappedResponse = Mapper<T>().mapArray(JSONArray: allNotifications)
                completion(.success(mappedResponse))
            }
    }
    
    func acceptFinishedProjectInvite(request: [String : Any],
                                     completion: @escaping (EmptyResponse) -> Void) {
        var finishedProjects = [String]()
        var allParticipants = [String]()
        guard let currentUser = authReference.currentUser?.uid else {
            completion(.error(WCError.genericError))
            return
        }
        guard let projectId = request["projectId"] as? String else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.usersPath)
            .child(currentUser)
            .child("finished_project_invite_notifications")
            .observeSingleEvent(of: .value) { snapshot in
                guard var notifications = snapshot.value as? [[String : Any]] else {
                    completion(.error(WCError.genericError))
                    return
                }
                notifications.removeAll(where: {
                    guard let id = $0["projectId"] as? String else {
                        return false
                    }
                    return id == projectId
                })
                self.realtimeDB
                    .child(Paths.usersPath)
                    .child(currentUser)
                    .updateChildValues(["finished_project_invite_notifications": notifications]) { (error, ref) in
                        if error != nil {
                            completion(.error(WCError.acceptProjectInvite))
                            return
                        }
                        self.realtimeDB
                            .child(Paths.usersPath)
                            .child(currentUser)
                            .child("finished_projects")
                            .observeSingleEvent(of: .value) { snapshot in
                                if let projects = snapshot.value as? [String] {
                                    finishedProjects = projects
                                }
                                finishedProjects.append(projectId)
                                self.realtimeDB
                                    .child(Paths.usersPath)
                                    .child(currentUser)
                                    .updateChildValues(["finished_projects": finishedProjects]) { (error, ref) in
                                        if error != nil {
                                            completion(.error(WCError.acceptProjectInvite))
                                            return
                                        }
                                        self.realtimeDB
                                            .child(Paths.projectsPath)
                                            .child(Paths.finishedProjectsPath)
                                            .child(projectId).child("participants")
                                            .observeSingleEvent(of: .value) { snapshot in
                                                guard let participants = snapshot.value as? [String] else {
                                                    completion(.error(WCError.genericError))
                                                    return
                                                }
                                                allParticipants = participants
                                                allParticipants.append(currentUser)
                                                self.realtimeDB
                                                    .child(Paths.projectsPath)
                                                    .child(Paths.finishedProjectsPath)
                                                    .child(projectId)
                                                    .updateChildValues(["participants": allParticipants]) { (error, ref) in
                                                        if error != nil {
                                                            completion(.error(WCError.acceptProjectInvite))
                                                            return
                                                        }
                                                        self.realtimeDB
                                                            .child(Paths.projectsPath)
                                                            .child(Paths.finishedProjectsPath)
                                                            .child(projectId)
                                                            .child("pending_invites")
                                                            .observeSingleEvent(of: .value) { snapshot in
                                                                guard var pendingInvites = snapshot.value as? [String] else {
                                                                    completion(.error(WCError.genericError))
                                                                    return
                                                                }
                                                                pendingInvites.removeAll(where: { $0 == currentUser})
                                                                self.realtimeDB.child(Paths.projectsPath).child(Paths.finishedProjectsPath)
                                                                    .child(projectId).updateChildValues(["pending_invites": pendingInvites]) { (error, ref) in
                                                                        if error != nil {
                                                                            completion(.error(WCError.acceptProjectInvite))
                                                                            return
                                                                        }
                                                                        self.realtimeDB
                                                                            .child(Paths.usersPath)
                                                                            .child(currentUser)
                                                                            .observeSingleEvent(of: .value) { snapshot in
                                                                                guard let data = snapshot.value as? [String : Any], let name = data["name"] as? String, let image = data["profile_image_url"] as? String else {
                                                                                    completion(.error(WCError.genericError))
                                                                                    return
                                                                                }
                                                                                self.realtimeDB.child(Paths.projectsPath).child(Paths.finishedProjectsPath).child(projectId).child("title").observeSingleEvent(of: .value) {
                                                                                    snapshot in
                                                                                    guard let title = snapshot.value as? String else {
                                                                                        completion(.error(WCError.genericError))
                                                                                        return
                                                                                    }
                                                                                    self.realtimeDB
                                                                                        .child(Paths.projectsPath)
                                                                                        .child(Paths.finishedProjectsPath)
                                                                                        .child(projectId).child("author_id")
                                                                                        .observeSingleEvent(of: .value) { snapshot in
                                                                                            guard let authorId = snapshot.value as? String else {
                                                                                                completion(.error(WCError.genericError))
                                                                   return                         }
                                                                                            self.sendAcceptNotification(type: .projectInvite(username: name, projectName: title, image: image), userId: authorId, completion: completion)                      }
                                                                                }
                                                                        }
                                                                    }
                                                            }
                                                    }
                                            }
                                    }
                            }
                    }
            }
    }
    
    func refuseFinishedProjectInvite(request: [String : Any],
                                     completion: @escaping (EmptyResponse) -> Void) {
        guard let currentUser = authReference.currentUser?.uid else {
            completion(.error(WCError.genericError))
            return
        }
        guard let projectId = request["projectId"] as? String else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.usersPath)
            .child(currentUser)
            .child("finished_project_invite_notifications")
            .observeSingleEvent(of: .value) { snapshot in
                guard var notifications = snapshot.value as? [[String : Any]] else {
                    completion(.error(WCError.genericError))
                    return
                }
                notifications.removeAll(where: {
                    guard let id = $0["projectId"] as? String else {
                        return false
                    }
                    return id == projectId
                })
                self.realtimeDB
                    .child(Paths.usersPath)
                    .child(currentUser)
                    .updateChildValues(["finished_project_invite_notifications": notifications]) { (error, ref) in
                        if error != nil {
                            completion(.error(WCError.refuseRequest))
                            return
                        }
                        self.realtimeDB
                            .child(Paths.projectsPath)
                            .child(Paths.finishedProjectsPath)
                            .child(projectId)
                            .child("pending_invites")
                            .observeSingleEvent(of: .value) { snapshot in
                                guard var pendingInvites = snapshot.value as? [String] else {
                                    completion(.error(WCError.genericError))
                                    return
                                }
                                pendingInvites.removeAll(where: { $0 == currentUser})
                                self.realtimeDB.child(Paths.projectsPath).child(Paths.finishedProjectsPath)
                                    .child(projectId).updateChildValues(["pending_invites": pendingInvites]) { (error, ref) in
                                        if error != nil {
                                            completion(.error(WCError.refuseRequest))
                                            return
                                        }
                                        completion(.success)
                                    }
                            }
                    }
            }
    }
    
    func fetchUserRelationToFinishedProject<T: Mappable>(request: [String : Any],
                                                         completion: @escaping (BaseResponse<T>) -> Void) {
        var responseDict: [String : Any] = .empty
        guard let userId = request["userId"] as? String,
              let projectId = request["projectId"] as? String else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.projectsPath)
            .child(Paths.finishedProjectsPath)
            .child(projectId)
            .child("participants")
            .observeSingleEvent(of: .value) { snapshot in
                guard let participants = snapshot.value as? [String] else {
                    completion(.error(WCError.genericError))
                    return
                }
                if participants.contains(userId) {
                    responseDict["relation"] = "SIMPLE PARTICIPANT"
                    guard let mappedResponse = Mapper<T>().map(JSON: responseDict) else {
                        completion(.error(WCError.parseError))
                        return
                    }
                    completion(.success(mappedResponse))
                    return
                }
                self.realtimeDB
                    .child(Paths.projectsPath)
                    .child(Paths.finishedProjectsPath)
                    .child(projectId)
                    .child("pending_invites")
                    .observeSingleEvent(of: .value) { snapshot in
                        if let invites = snapshot.value as? [String],
                           invites.contains(userId) {
                            responseDict["relation"] = "RECEIVED REQUEST"
                            guard let mappedResponse = Mapper<T>().map(JSON: responseDict) else {
                                completion(.error(WCError.parseError))
                                return
                            }
                            completion(.success(mappedResponse))
                            return
                        }
                        responseDict["relation"] = "NOTHING"
                        guard let mappedResponse = Mapper<T>().map(JSON: responseDict) else {
                            completion(.error(WCError.parseError))
                            return
                        }
                        completion(.success(mappedResponse))
                    }
            }
    }
    
    func removeInviteToFinishedProjectFromUser(request: [String : Any],
                                               completion: @escaping (EmptyResponse) -> Void) {
        guard let projectId = request["projectId"] as? String,
              let userId = request["userId"] as? String else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.usersPath)
            .child(userId)
            .child("finished_project_invite_notifications")
            .observeSingleEvent(of: .value) { snapshot in
                guard var notifications = snapshot.value as? [[String : Any]] else {
                    completion(.error(WCError.genericError))
                    return
                }
                notifications.removeAll(where: {
                    guard let id = $0["projectId"] as? String else {
                        return false
                    }
                    return id == projectId
                })
                self.realtimeDB
                    .child(Paths.usersPath)
                    .child(userId)
                    .updateChildValues(["finished_project_invite_notifications": notifications]) { (error, ref) in
                        if error != nil {
                            completion(.error(WCError.removeProjectInviteToUser))
                            return
                        }
                        self.realtimeDB
                            .child(Paths.projectsPath)
                            .child(Paths.finishedProjectsPath)
                            .child(projectId)
                            .child("pending_invites")
                            .observeSingleEvent(of: .value) { snapshot in
                                guard var pendingInvites = snapshot.value as? [String] else {
                                    completion(.error(WCError.genericError))
                                    return
                                }
                                pendingInvites.removeAll(where: { $0 == userId})
                                self.realtimeDB.child(Paths.projectsPath).child(Paths.finishedProjectsPath)
                                    .child(projectId).updateChildValues(["pending_invites": pendingInvites]) { (error, ref) in
                                        if error != nil {
                                            completion(.error(WCError.removeProjectInviteToUser))
                                            return
                                        }
                                        completion(.success)
                                    }
                            }
                    }
            }
    }
    
    func fetchConnectionAcceptNotifications<T: Mappable>(request: [String : Any],
                                                         completion: @escaping (BaseResponse<[T]>) -> Void) {
        fetchAcceptNotifications(type: .connection(), completion: completion)
    }
    
    func fetchProjectInviteAcceptNotifications<T: Mappable>(request: [String : Any],
                                                            completion: @escaping (BaseResponse<[T]>) -> Void) {
        fetchAcceptNotifications(type: .projectInvite(), completion: completion)
    }
    
    func fetchProjectParticipationAcceptNotifications<T: Mappable>(request: [String : Any],
                                                                   completion: @escaping (BaseResponse<[T]>) -> Void) {
        fetchAcceptNotifications(type: .projectParticipationRequest(), completion: completion)
    }
    
    func sendPasswordRecoveryEmail(request: [String : Any],
                                   completion: @escaping (EmptyResponse) -> Void) {
        guard let email = request["email"] as? String else {
            completion(.error(WCError.genericError))
            return
        }
        authReference.sendPasswordReset(withEmail: email) { error in
            if error != nil {
                completion(.error(WCError.sendEmail))
                return
            }
            completion(.success)
        }
    }
    
    func fetchUserDataByEmail<T: Mappable>(request: [String : Any],
                                           completion: @escaping (BaseResponse<T>) -> Void) {
        guard let email = request["email"] as? String else {
            completion(.error(WCError.genericError))
            return
        }
        let hashedEmail = email.sha256()
        realtimeDB.child(Paths.userEmailPath).child(hashedEmail).observeSingleEvent(of: .value) { snapshot in
            guard let userId = snapshot.value as? String else {
                completion(.error(WCError.genericError))
                return
            }
            self.realtimeDB.child(Paths.usersPath).child(userId).observeSingleEvent(of: .value) { snapshot in
                guard var userData = snapshot.value as? [String : Any] else {
                    completion(.error(WCError.genericError))
                    return
                }
                userData["userId"] = userId
                guard let mappedResponse = Mapper<T>().map(JSON: userData) else {
                    completion(.error(WCError.genericError))
                    return
                }
                completion(.success(mappedResponse))
            }
        }
    }
    
    func fetchRecentSearches<T: Mappable>(request: [String : Any],
                                          completion: @escaping (BaseResponse<[T]>) -> Void) {
        var searchIds = [String]()
        var allSearches = [[String : Any]]()
        
        guard let currentUser = authReference.currentUser?.uid else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.usersPath)
            .child(currentUser)
            .child(Paths.recentSearchesPath)
            .observeSingleEvent(of: .value) { snapshot in
                if let searches = snapshot.value as? [String] {
                    searchIds = searches
                }
                searchIds = searchIds.reversed()
                let dispatchGroup = DispatchGroup()
                for searchId in searchIds {
                    dispatchGroup.enter()
                    self.fetchEntityType(forId: searchId) { response in
                        switch response {
                        case .sucess(let type):
                            allSearches.append(["id" : searchId, "type": type.rawValue])
                        case .error:
                            completion(.error(WCError.genericError))
                        }
                        dispatchGroup.leave()
                    }
                }
                dispatchGroup.notify(queue: .main) {
                    let mappedResponse = Mapper<T>().mapArray(JSONArray: allSearches)
                    completion(.success(mappedResponse))
                }
        }
    }
    
    func registerRecentSearch(request: [String : Any],
                                   completion: @escaping (EmptyResponse) -> Void) {
        var allSearches = [String]()
        
        guard let searchId = request["id"] as? String else {
            completion(.error(WCError.genericError))
            return
        }
        guard let currentUser = authReference.currentUser?.uid else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.usersPath)
            .child(currentUser)
            .child(Paths.recentSearchesPath)
            .observeSingleEvent(of: .value) { snapshot in
                if let searches = snapshot.value as? [String] {
                    allSearches = searches
                }
                if let index = allSearches.firstIndex(where: { $0 == searchId }) {
                    allSearches.remove(at: index)
                    allSearches.append(searchId)
                } else {
                    if allSearches.count >= self.maxRecentSearches {
                        allSearches.removeFirst()
                    }
                    allSearches.append(searchId)
                }
                self.realtimeDB
                    .child(Paths.usersPath)
                    .child(currentUser)
                    .updateChildValues([Paths.recentSearchesPath : allSearches]) { error, ref in
                        if error != nil {
                            completion(.error(WCError.genericError))
                            return
                        }
                        completion(.success)
                }
        }
    }
    
    func fetchEntityType<T: Mappable>(request: [String : Any],
                                      completion: @escaping (BaseResponse<T>) -> Void) {
        guard let id = request["id"] as? String else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.entitiesPath)
            .child(id)
            .observeSingleEvent(of: .value) { snapshot in
                guard let type = snapshot.value as? String else {
                    completion(.error(WCError.genericError))
                    return
                }
                let response: [String : Any] = ["type" : type]
                guard let mappedResponse = Mapper<T>().map(JSON: response) else {
                    completion(.error(WCError.parseError))
                    return
                }
                completion(.success(mappedResponse))
        }
    }
}

//MARK: Entities verifier
extension FirebaseManager {
    
    private func registerEntity(withId id: String, type: EntityType, completion: @escaping (EmptyResponse) -> Void) {
        realtimeDB.child(Paths.entitiesPath).updateChildValues([id : type.rawValue]) { error, ref in
            if error != nil {
                completion(.error(WCError.genericError))
                return
            }
            completion(.success)
        }
    }
    
    private func fetchEntityType(forId id: String, completion: @escaping (CheckEntityResponse) -> Void) {
        realtimeDB.child(Paths.entitiesPath).observeSingleEvent(of: .value) { snaphot in
            guard let entities = snaphot.value as? [String : Any], let type = entities[id] as? String, let entityResponse = EntityType(rawValue: type) else {
                completion(.error)
                return
            }
            completion(.sucess(type: entityResponse))
        }
    }
    
    private func removeEntity(withId id: String, completion: @escaping (EmptyResponse) -> Void) {
        realtimeDB.child(Paths.entitiesPath).child(id).removeValue { error, ref in
            if error != nil {
                completion(.error(WCError.genericError))
                return
            }
            completion(.success)
        }
    }
}

//MARK: Finished Project Logic feeds
extension FirebaseManager {
    
    private func fetchFinishedConnectionsFeed<T: Mappable>(currentUser: String,
                                                           completion: @escaping (BaseResponse<[T]>) -> Void) {
        var finishedProjects = [String]()
        var userConnections = [String]()
        var userProjects = [String]()
        var responseProjects = [[String : Any]]()
        
        realtimeDB
            .child(Paths.finishedProjectsCataloguePath)
            .observeSingleEvent(of: .value) { snapshot in
                guard let projects = snapshot.value as? [String] else {
                    completion(.success(.empty))
                    return
                }
                finishedProjects = projects
                self.realtimeDB
                    .child(Paths.usersPath)
                    .child(currentUser)
                    .child("connections")
                    .observeSingleEvent(of: .value) { snapshot in
                        if let connections = snapshot.value as? [String] {
                            userConnections = connections
                        }
                        self.realtimeDB
                            .child(Paths.usersPath)
                            .child(currentUser)
                            .child("finished_projects")
                            .observeSingleEvent(of: .value) { snapshot in
                                if let projects = snapshot.value as? [String] {
                                    userProjects = projects
                                }
                                finishedProjects = finishedProjects.filter({ !userProjects.contains($0) })
                                guard finishedProjects.count > 0 else {
                                    completion(.success(.empty))
                                    return
                                }
                                let dispatchGroup = DispatchGroup()
                                for project in finishedProjects {
                                    dispatchGroup.enter()
                                    self.realtimeDB
                                        .child(Paths.projectsPath)
                                        .child(Paths.finishedProjectsPath)
                                        .child(project)
                                        .observeSingleEvent(of: .value) { snapshot in
                                            guard let projectData = snapshot.value as? [String : Any] else {
                                                completion(.error(WCError.genericError))
                                                return
                                            }
                                            guard let participants = projectData["participants"] as? [String],
                                                  let image = projectData["image"] as? String else {
                                                completion(.error(WCError.genericError))
                                                return
                                            }
                                            let score = userConnections.filter({ participants.contains($0)}).count
                                            let dict: [String : Any] = ["id": project, "image": image, "score": score]
                                            if score > 0 {
                                                responseProjects.append(dict)
                                            }
                                            dispatchGroup.leave()
                                        }
                                }
                                dispatchGroup.notify(queue: .main) {
                                    responseProjects.sort { project1, project2 in
                                        guard let score1 = project1["score"] as? Int,
                                              let score2 = project2["score"] as? Int else {
                                            return false
                                        }
                                        return score1 > score2
                                    }
                                    let response = Array(responseProjects.prefix(50))
                                    let mappedResponse = Mapper<T>().mapArray(JSONArray: response)
                                    completion(.success(mappedResponse))
                                }
                            }
                    }
            }
    }
    
    private func fetchFinishedPopularFeed<T: Mappable>(currentUser: String,
                                                       completion: @escaping (BaseResponse<[T]>) -> Void) {
        var finishedProjects = [String]()
        var responseProjects = [[String : Any]]()
        
        realtimeDB
            .child(Paths.finishedProjectsCataloguePath)
            .observeSingleEvent(of: .value) { snapshot in
                guard let projects = snapshot.value as? [String] else {
                    completion(.success(.empty))
                    return
                }
                finishedProjects = projects
                let dispatchGroup = DispatchGroup()
                for project in finishedProjects {
                    dispatchGroup.enter()
                    self.realtimeDB
                        .child(Paths.projectsPath)
                        .child(Paths.finishedProjectsPath)
                        .child(project)
                        .child("participants")
                        .observeSingleEvent(of: .value) { snapshot in
                            guard let participants = snapshot.value as? [String] else {
                                completion(.error(WCError.genericError))
                                return
                            }
                            if participants.contains(currentUser) {
                                finishedProjects.removeAll(where: { $0 == project })
                            }
                            dispatchGroup.leave()
                        }
                }
                dispatchGroup.notify(queue: .main) {
                    let newDispatchGroup = DispatchGroup()
                    for project in finishedProjects {
                        newDispatchGroup.enter()
                        self.realtimeDB
                            .child(Paths.projectsPath)
                            .child(Paths.finishedProjectsPath)
                            .child(project)
                            .observeSingleEvent(of: .value) { snapshot in
                                guard var projectData = snapshot.value as? [String : Any] else {
                                    completion(.error(WCError.genericError))
                                    return
                                }
                                projectData["id"] = project
                                responseProjects.append(projectData)
                                newDispatchGroup.leave()
                            }
                    }
                    newDispatchGroup.notify(queue: .main) {
                        responseProjects.sort { project1, project2 in
                            guard let views1 = project1["views"] as? Int,
                                  let views2 = project2["views"] as? Int else {
                                return false
                            }
                            return views1 > views2
                        }
                        let mappedResponse = Mapper<T>().mapArray(JSONArray: responseProjects)
                        completion(.success(mappedResponse))
                    }
                }
            }
    }
    
    private func fetchFinishedRecentFeed<T: Mappable>(currentUser: String,
                                                      completion: @escaping (BaseResponse<[T]>) -> Void) {
        var finishedProjects = [String]()
        var responseProjects = [[String : Any]]()
        
        realtimeDB
            .child(Paths.finishedProjectsCataloguePath)
            .observeSingleEvent(of: .value) { snapshot in
                guard let projects = snapshot.value as? [String] else {
                    completion(.success(.empty))
                    return
                }
                finishedProjects = projects
                let dispatchGroup = DispatchGroup()
                for project in finishedProjects {
                    dispatchGroup.enter()
                    self.realtimeDB
                        .child(Paths.projectsPath)
                        .child(Paths.finishedProjectsPath)
                        .child(project)
                        .child("participants")
                        .observeSingleEvent(of: .value) { snapshot in
                            guard let participants = snapshot.value as? [String] else {
                                completion(.error(WCError.genericError))
                                return
                            }
                            if participants.contains(currentUser) {
                                finishedProjects.removeAll(where: { $0 == project })
                            }
                            dispatchGroup.leave()
                        }
                }
                dispatchGroup.notify(queue: .main) {
                    let dispatchGroup = DispatchGroup()
                    for project in finishedProjects {
                        dispatchGroup.enter()
                        self.realtimeDB
                            .child(Paths.projectsPath)
                            .child(Paths.finishedProjectsPath)
                            .child(project)
                            .observeSingleEvent(of: .value) { snapshot in
                                guard var projectData = snapshot.value as? [String : Any] else {
                                    completion(.error(WCError.genericError))
                                    return
                                }
                                projectData["id"] = project
                                responseProjects.append(projectData)
                                dispatchGroup.leave()
                            }
                    }
                    dispatchGroup.notify(queue: .main) {
                        responseProjects.sort { project1, project2 in
                            guard let lastView1 = project1["last_view"] as? Int,
                                  let lastView2 = project2["last_view"] as? Int else {
                                return false
                            }
                            return lastView1 > lastView2
                        }
                        let mappedResponse = Mapper<T>().mapArray(JSONArray: responseProjects)
                        completion(.success(mappedResponse))
                    }
                }
            }
    }

    private func sendAcceptNotification(type: AcceptNotificationType,
                                        userId: String,
                                        completion: @escaping (EmptyResponse) -> Void) {
        var allNotifications = [[String : Any]]()
        realtimeDB
            .child(Paths.usersPath)
            .child(userId)
            .child(type.path)
            .observeSingleEvent(of: .value) { snapshot in
                if let notifications = snapshot.value as? [[String : Any]] {
                    allNotifications = notifications
                }
                allNotifications.append(["image": type.image, "text": type.notificationText])
                self.realtimeDB
                    .child(Paths.usersPath)
                    .child(userId)
                    .updateChildValues([type.path : allNotifications]) { (error, ref) in
                        if error != nil {
                            completion(.error(WCError.genericError))
                            return
                        }
                        completion(.success)
                }
        }
    }
    
    private func fetchAcceptNotifications<T: Mappable>(type: AcceptNotificationType,
                                                       completion: @escaping (BaseResponse<[T]>) -> Void) {
        guard let currentUser = authReference.currentUser?.uid else {
            completion(.error(WCError.genericError))
            return
        }
        realtimeDB
            .child(Paths.usersPath)
            .child(currentUser)
            .child(type.path)
            .observeSingleEvent(of: .value) { snapshot in
                guard let notifications = snapshot.value as? [[String : Any]] else {
                    completion(.success(.empty))
                    return
                }
                let mappedResponse = Mapper<T>().mapArray(JSONArray: notifications)
                completion(.success(mappedResponse))
        }
    }
}

//MARK: User Relationships
extension FirebaseManager {
    
    private func checkConnected(request: FetchUserRelationRequest,
                                completion: @escaping (Bool) -> Void) {
        realtimeDB
            .child(Paths.usersPath)
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
            .child(Paths.usersPath)
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
            .child(Paths.usersPath)
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
