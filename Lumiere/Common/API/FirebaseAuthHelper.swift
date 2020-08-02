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
import Kingfisher
import RxSwift

protocol FirebaseAuthHelperProtocol {
    func createUser(request: CreateUserRequest,
                    completion: @escaping (SignUp.Response.RegisterUser) -> Void)
    func registerUserData(request: SaveUserInfoRequest,
                          completion: @escaping (SignUp.Response.SaveUserInfo) -> Void)
    func fetchUserConnectNotifications(request: GetConnectNotificationRequest,
                                       completion: @escaping (GetUserConnectNotificationsResponse) -> Void)
    func addConnectNotifications(request: SaveNotificationsRequest,
                                 completion: @escaping (AddConnectNotificationResponse) -> Void)
    func signInUser(request: SignInRequest,
                    completion: @escaping (SignIn.Response.SignInResponse) -> Void)
    func fetchCurrentUser(request: FetchCurrentUserIdRequest,
                          completion: @escaping (CurrentUserIdResponse) -> Void)
    func fetchUserData(request: FetchUserDataRequest,
                       completion: @escaping (UserDataResponse) -> Void)
}

class FirebaseAuthHelper: FirebaseAuthHelperProtocol {
    
    func createUser(request: CreateUserRequest,
                    completion: @escaping (SignUp.Response.RegisterUser) -> Void) {
        Auth.auth().createUser(withEmail: request.email,
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
            let profileImageReference = Storage.storage().reference().child(Constants.profileImagesPath).child(request.userId)
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
                                                      "connect_notifications": ["1"],
                                                      "project_notifications": [],
                                                      "author_notifications": []]
                    
                    Database.database().reference().child(Constants.usersPath).child(request.userId).updateChildValues(dictionary) {
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
    
    func fetchUserConnectNotifications(request: GetConnectNotificationRequest,
                                       completion: @escaping (GetUserConnectNotificationsResponse) -> Void) {
        var notifications: Array<Any> = .empty
        Database
        .database()
        .reference()
        .child(Constants.usersPath)
        .child(request.userId)
        .child("connect_notifications")
            .observe(.value) { snapshot in
                if snapshot.value is NSNull {
                    let notificationsResponse = GetUserConnectNotificationsResponse.success(.empty)
                    completion(notificationsResponse)
                } else if let values = snapshot.value as? Array<Any> {
                    notifications = values
                    let notificationsResponse = GetUserConnectNotificationsResponse.success(notifications)
                    completion(notificationsResponse)
                } else {
                    completion(.error)
                }
        }
    }
    
    func addConnectNotifications(request: SaveNotificationsRequest,
                                 completion: @escaping (AddConnectNotificationResponse) -> Void) {
        var integerDict = [String : Any]()
        for index in 0..<request.notifications.count {
            integerDict["\(index)"] = request.notifications[index]
        }
        Database
            .database()
            .reference()
            .child(Constants.usersPath)
            .child(request.userId)
            .child("connect_notifications")
            .updateChildValues(integerDict) { error, ref in
                if let error = error {
                    completion(.error(error))
                }
                completion(.success)
        }
    }
    
    func signInUser(request: SignInRequest,
                    completion: @escaping (SignIn.Response.SignInResponse) -> Void) {
        Auth.auth().signIn(withEmail: request.email, password: request.password) { (credentials, error) in
            if let error = error {
                completion(.error(SignIn.Errors.ServerError(error: error)))
                return
            } else {
                completion(.success)
            }
        }
    }
//
//    func fetchUserConnectNotifications(request: GetConnectNotificationRequest,
//                                       completion: @escaping (ProfileDetails.Response.AllNotifications) -> Void) {
//        var notifications: Array<Any> = .empty
//        Database
//        .database()
//        .reference()
//        .child(Constants.usersPath)
//        .child(request.userId)
//        .child("connect_notifications")
//            .observe(.value) { snapshot in
//                if snapshot.value is NSNull {
//                    completion(.success(ProfileDetails
//                        .Response
//                        .NotificationsResponseData(notifications: .empty)))
//                } else if let values = snapshot.value as? Array<Any> {
//                    notifications = values
//                    completion(.success(ProfileDetails
//                        .Response
//                        .NotificationsResponseData(notifications: notifications)))
//                } else {
//                    completion(.error(ProfileDetails
//                        .Errors
//                        .ProfileDetailsError
//                        .genericError))
//                }
//        }
//    }
    
    func fetchCurrentUser(request: FetchCurrentUserIdRequest,
                          completion: @escaping (CurrentUserIdResponse) -> Void) {
        guard let id = Auth.auth().currentUser?.uid else {
            completion(.error)
            return
        }
        completion(.success(id))
    }
    
    func fetchUserData(request: FetchUserDataRequest,
                       completion: @escaping (UserDataResponse) -> Void) {
        Database
            .database()
            .reference()
            .child(Constants.usersPath)
            .child(request.userId)
            .observe(.value) { snapshot in
                if let value = snapshot.value as? [String : Any] {
                    completion(.success(value))
                }
                completion(.error)
        }
    }
}

