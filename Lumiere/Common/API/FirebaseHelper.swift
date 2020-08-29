//
//  FirebaseHelper.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 28/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import FirebaseAuth
import FirebaseAnalytics
import FirebaseFirestore
import FirebaseDatabase
import FirebaseStorage
import ObjectMapper

protocol FirebaseHelperProtocol {
    func registerUser(request: [String : Any],
                      completion: @escaping (EmptyResponse) -> Void)
    func signInUser(request: [String : Any],
                    completion: @escaping (EmptyResponse) -> Void)
    func signOut(request: [String : Any],
                 completion: @escaping (EmptyResponse) -> Void)
    func fetchCurrentUserInfo<T: Mappable>(request: [String : Any],
                                           completion: @escaping (BaseResponse<T>) -> Void)
    func fetchUserInfo<T: Mappable>(request: [String : Any],
                                    completion: @escaping (BaseResponse<T>) -> Void)
    func fetchProjectInfo<T: Mappable>(request: [String: Any],
                                       completion: @escaping (BaseResponse<T>) -> Void)
    func updateUserInfo(request: [String: Any],
                        completion: @escaping (EmptyResponse) -> Void)
    func acceptConnectionRequest(request: [String : Any],
                                 completion: @escaping (EmptyResponse) -> Void)
    func refuseConnectionRequest(request: [String : Any],
                                 completion: @escaping (EmptyResponse) -> Void)
    func acceptProjectInviteRequest(request: [String : Any],
                                    completion: @escaping (EmptyResponse) -> Void)
    func refuseProjectInviteRequest(request: [String : Any],
                                    completion: @escaping (EmptyResponse) -> Void)
    func acceptProjectParticipationRequest(request: [String : Any],
                                           completion: @escaping (EmptyResponse) -> Void)
    func sendConnectionRequest(request: [String : Any],
                               completion: @escaping (EmptyResponse) -> Void)
    func removeConnection(request: [String : Any],
                          completion: @escaping (EmptyResponse) -> Void)
    func undoConnectionRequest(request: [String : Any],
                               completion: @escaping (EmptyResponse) -> Void)
    func fetchUserConnections<T: Mappable>(request: [String : Any],
                              completion: @escaping (BaseResponse<[T]>) -> Void)
    func fetchUserRelation<T: Mappable>(request: [String : Any],
                                        completion: @escaping (BaseResponse<T>) -> Void)
    func fetchNotifications<T: Mappable>(request: [String : Any],
                                         completion: @escaping (BaseResponse<T>) -> Void)
    func createProject(request: [String : Any],
                       completion: @escaping (EmptyResponse) -> Void)
    func sendProjectParticipationRequest(request: [String : Any],
                                         completion: @escaping (EmptyResponse) -> Void)
    func fetchProjectRelation<T: Mappable>(request: [String : Any],
                                           completion: @escaping (BaseResponse<T>) -> Void)
    func fetchProjectParticipatingRequests<T: Mappable>(request: [String : Any],
                                                        completion: (BaseResponse<[T]>) -> Void)
    func fetchUserOnGoingProjects<T: Mappable>(request: [String : Any],
                                               completion: (BaseResponse<[T]>) -> Void)
    func fetchUserFinishedProjects<T: Mappable>(request: [String : Any],
                                                completion: @escaping (BaseResponse<[T]>) -> Void)
    func publishProject(request: [String : Any],
                        completion: @escaping (EmptyResponse) -> Void)
    func removeUserFromProject(request: [String : Any],
                               completion: @escaping (EmptyResponse) -> Void)
    func sendProjectParticipationInvite(request: [String : Any],
                                         completion: @escaping (EmptyResponse) -> Void)
    func exitProject(request: [String : Any],
                     completion: @escaping (EmptyResponse) -> Void)
    func fetchProjectParticipants<T: Mappable>(request: [String : Any],
                                               completion: @escaping (BaseResponse<[T]>) -> Void)
    func fetchFriendSuggestions<T: Mappable>(request: [String : Any],
                                             completion: @escaping (BaseResponse<[T]>) -> Void)
    func fetchFeedProjects<T: Mappable>(request: [String : Any],
                                        completion: @escaping (BaseResponse<[T]>) -> Void)
    func fetchSearchResults<T: Mappable>(request: [String : Any],
                                         completion: @escaping (BaseResponse<[T]>) -> Void)
}

class FirebaseHelper: FirebaseHelperProtocol {

    enum FirebaseErrors: String, Error {
        case parseError = "Ocorreu um erro"
        case genericError = "Ocorreu um erro genérico"
        case fetchConnectionsError = "Ocorreu um erro ao buscar as notificações"
        case connectUsersError = "Ocorreu um erro ao aceitar a solicitação"
        case signInError = "Ocorreu um erro ao tentar logar"
        case userNotLogged = "Nenhum usuário logado encontrado"
    }
    
    private let realtimeDB = Database.database().reference()
    private let authReference = Auth.auth()
    private let storage = Storage.storage().reference()
    
    private var mutex: Bool = true //Profile details mutex

    func registerUser(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        guard let name = request["name"] as? String,
            let email = request["email"] as? String,
            let phoneNumber = request["phone_number"] as? String,
            let password = request["password"] as? String,
            let ocupation = request["ocupation"] as? String,
            let interestCathegories = request["interest_cathegories"] as? [String],
            let image = request["profile_image"] as? Data else {
                completion(.error(FirebaseErrors.genericError))
                return
        }
        authReference.createUser(withEmail: email,
                                 password: password) { (response, error) in
                                    if let error = error {
                                        completion(.error(error))
                                        return
                                    }
                                    guard let userId = response?.user.uid else {
                                        completion(.error(FirebaseErrors.genericError))
                                        return
                                    }
                                    let profileImageReference = self.storage.child(Constants.profileImagesPath).child(userId)
                                    profileImageReference.putData(image,
                                                                  metadata: nil) { (metadata, error) in
                                                                    if let error = error {
                                                                        completion(.error(error))
                                                                        return
                                                                    }
                                                                    profileImageReference.downloadURL { (url, error) in
                                                                        if let error = error {
                                                                            completion(.error(error))
                                                                            return
                                                                        }
                                                                        guard let url = url else {
                                                                            completion(.error(FirebaseErrors.genericError))
                                                                            return
                                                                        }
                                                                        let urlString = url.absoluteString
                                                                        let dictionary: [String: Any] = ["name": name,
                                                                                                         "email": email,
                                                                                                         "phone_number": phoneNumber,
                                                                                                         "profile_image_url": urlString,
                                                                                                         "ocupation": ocupation]
                                                                        self.realtimeDB
                                                                            .child(Constants.usersInfoPath)
                                                                            .child(userId)
                                                                            .updateChildValues(dictionary) { (error, ref) in
                                                                                if let error = error {
                                                                                    completion(.error(error))
                                                                                    return
                                                                                }
                                                                                var cathegoryDict: [String : Any] = [:]
                                                                                for cathegory in interestCathegories {
                                                                                    cathegoryDict[cathegory] = true
                                                                                }
                                                                                self.realtimeDB
                                                                                    .child(Constants.userInterestCathegoriesPath)
                                                                                    .child(userId).updateChildValues(cathegoryDict) {
                                                                                        (error, ref) in
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
    
    func signInUser(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        guard let email = request["email"] as? String,
            let password = request["password"] as? String else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        authReference.signIn(withEmail: email,
                             password: password) { (credentials, error) in
                                if let error = error {
                                    completion(.error(error))
                                    return
                                }
                                guard self.authReference.currentUser != nil else {
                                    completion(.error(FirebaseErrors.signInError))
                                    return
                                }
                                completion(.success)
        }
    }
    
    func signOut(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        do {
            try authReference.signOut()
            completion(.success)
        } catch {
            completion(.error(error))
        }
    }
    
    func fetchCurrentUserInfo<T : Mappable>(request: [String : Any], completion: @escaping (BaseResponse<T>) -> Void) {
        guard let userId = authReference.currentUser?.uid else {
            completion(.error(FirebaseErrors.userNotLogged))
            return
        }
        realtimeDB
            .child(Constants.usersInfoPath)
            .child(userId)
            .observeSingleEvent(of: .value) { snapshot in
                guard let user = snapshot.value as? [String : Any] else {
                    completion(.error(FirebaseErrors.genericError))
                    return
                }
                guard let mappedResponse = Mapper<T>().map(JSON: user) else {
                    completion(.error(FirebaseErrors.parseError))
                    return
                }
                completion(.success(mappedResponse))
        }
    }
    
    func fetchUserInfo<T : Mappable>(request: [String : Any], completion: @escaping (BaseResponse<T>) -> Void) {
        guard let userId = request["userId"] as? String else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        realtimeDB
            .child(Constants.usersInfoPath)
            .child(userId)
            .observeSingleEvent(of: .value) { snapshot in
                guard let user = snapshot.value as? [String : Any] else {
                    completion(.error(FirebaseErrors.genericError))
                    return
                }
                guard let mappedResponse = Mapper<T>().map(JSON: user) else {
                    completion(.error(FirebaseErrors.parseError))
                    return
                }
                completion(.success(mappedResponse))
        }
    }
    
    func fetchProjectInfo<T : Mappable>(request: [String : Any], completion: @escaping (BaseResponse<T>) -> Void) {
        
    }
    
    func updateUserInfo(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        guard let name = request["name"] as? String,
            let phoneNumber = request["phone_number"] as? String,
            let image = request["profile_image"] as? Data,
            let ocupation = request["ocupation"] as? String,
            let interestCathegories = request["interest_cathegories"] as? [String] else {
                completion(.error(FirebaseErrors.genericError))
                return
        }
        guard let userId = authReference.currentUser?.uid else {
            completion(.error(FirebaseErrors.userNotLogged))
            return
        }
        let profileImageReference = storage.child(Constants.profileImagesPath).child(userId)
        profileImageReference.putData(image,
                                      metadata: nil) { (metadata, error) in
                                        if let error = error {
                                            completion(.error(error))
                                            return
                                        }
                                        profileImageReference.downloadURL { (url, error) in
                                            if let error = error {
                                                completion(.error(error))
                                                return
                                            }
                                            guard let urlString = url?.absoluteString else {
                                                completion(.error(FirebaseErrors.genericError))
                                                return
                                            }
                                            let dict: [String : Any] = ["name": name,
                                                                        "phone_number": phoneNumber,
                                                                        "profile_image_url": urlString,
                                                                        "ocupation": ocupation]
                                            self.realtimeDB.child(Constants.usersInfoPath).child(userId).updateChildValues(dict) {
                                                (error, ref) in
                                                if let error = error {
                                                    completion(.error(error))
                                                    return
                                                }
                                                var cathegoriesDict: [String : Any] = [:]
                                                for cathegory in interestCathegories {
                                                    cathegoriesDict[cathegory] = true
                                                }
                                                self.realtimeDB
                                                    .child(Constants.userInterestCathegoriesPath)
                                                    .updateChildValues([userId: cathegoriesDict]) { (error, ref) in
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
    
    func acceptConnectionRequest(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        
    }
    
    func refuseConnectionRequest(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        
    }
    
    func acceptProjectInviteRequest(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        
    }
    
    func refuseProjectInviteRequest(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        
    }
    
    func acceptProjectParticipationRequest(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        
    }
    
    func sendConnectionRequest(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        
    }
    
    func removeConnection(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        
    }
    
    func undoConnectionRequest(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        
    }
    
    func fetchUserConnections<T : Mappable>(request: [String : Any], completion: @escaping (BaseResponse<[T]>) -> Void) {
        
    }
    
    func fetchUserRelation<T : Mappable>(request: [String : Any], completion: @escaping (BaseResponse<T>) -> Void) {
        
    }
    
    func fetchNotifications<T : Mappable>(request: [String : Any], completion: @escaping (BaseResponse<T>) -> Void) {
        
    }
    
    func createProject(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        guard let image = request["image"] as? Data,
            let title = request["title"] as? String,
            let sinopsis = request["sinopsis"] as? String,
            let progress = request["progress"] as? Float,
            let cathegories = request["cathegories"] as? [String],
            let needing = request["needing"] as? String else {
                completion(.error(FirebaseErrors.genericError))
                return
        }
        guard let currentUser = authReference.currentUser?.uid else {
            completion(.error(FirebaseErrors.userNotLogged))
            return
        }
        let projectReference = realtimeDB
            .child(Constants.projectsInfoPath)
            .child(Constants.ongoingProjectsPath)
            .childByAutoId()
        guard let id = projectReference.key else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        let projectImageReference = storage.child(Constants.projectImagesPath).child(id)
        projectImageReference.putData(image, metadata: nil) { (metadata, error) in
            if let error = error {
                completion(.error(error))
                return
            }
            projectImageReference.downloadURL { (url, error) in
                if let error = error {
                    completion(.error(error))
                    return
                }
                guard let urlString = url?.absoluteString else {
                    completion(.error(FirebaseErrors.genericError))
                    return
                }
                var dict: [String : Any] = ["id": id,
                                            "title": title,
                                            "sinopsis": sinopsis,
                                            "project_image_url": urlString,
                                            "progress": progress,
                                            "first_cathegory": cathegories[0],
                                            "needing": needing,
                                            "author_id": currentUser]
                if cathegories.count > 1 {
                    dict["second_cathegory"] = cathegories[1]
                }
                self.realtimeDB
                    .child(Constants.projectsInfoPath)
                    .child(Constants.ongoingProjectsPath)
                    .child(cathegories[0])
                    .child(id)
                    .updateChildValues(dict) { (error, ref) in
                        if let error = error {
                            completion(.error(error))
                            return
                        }
                        self.realtimeDB
                            .child(Constants.usersAuthoringPath)
                            .child(currentUser)
                            .updateChildValues([id : true]) { (error, ref) in
                                if let error = error {
                                    completion(.error(error))
                                    return
                                }
                                self.realtimeDB
                                    .child(Constants.usersParticipatingPath)
                                    .child(currentUser)
                                    .updateChildValues([id : true]) { (error, ref) in
                                        if let error = error {
                                            completion(.error(error))
                                            return
                                        }//CONTINUE
//                                        self.realtimeDB.child(Constants.projectsInfoPath)
                                }
                        }
                }
            }
        }
    }
    
    func sendProjectParticipationRequest(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        
    }
    
    func fetchProjectRelation<T : Mappable>(request: [String : Any], completion: @escaping (BaseResponse<T>) -> Void) {
        
    }
    
    func fetchProjectParticipatingRequests<T : Mappable>(request: [String : Any], completion: (BaseResponse<[T]>) -> Void) {
        
    }
    
    func fetchUserOnGoingProjects<T : Mappable>(request: [String : Any], completion: (BaseResponse<[T]>) -> Void) {
        
    }
    
    func fetchUserFinishedProjects<T : Mappable>(request: [String : Any], completion: @escaping (BaseResponse<[T]>) -> Void) {
        
    }
    
    func publishProject(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        
    }
    
    func removeUserFromProject(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        
    }
    
    func sendProjectParticipationInvite(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        
    }
    
    func exitProject(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        
    }
    
    func fetchProjectParticipants<T : Mappable>(request: [String : Any], completion: @escaping (BaseResponse<[T]>) -> Void) {
        
    }
    
    func fetchFriendSuggestions<T : Mappable>(request: [String : Any], completion: @escaping (BaseResponse<[T]>) -> Void) {
        
    }
    
    func fetchFeedProjects<T : Mappable>(request: [String : Any], completion: @escaping (BaseResponse<[T]>) -> Void) {
        
    }
    
    func fetchSearchResults<T : Mappable>(request: [String : Any], completion: @escaping (BaseResponse<[T]>) -> Void) {
        
    }
}


