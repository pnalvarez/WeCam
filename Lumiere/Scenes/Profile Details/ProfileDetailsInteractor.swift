//
//  ProfileDetailsInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import ObjectMapper

protocol ProfileDetailsBusinessLogic {
    func fetchCurrentUserId(_ request: ProfileDetails.Request.FetchCurrentUserId)
    func fetchCurrentUserData(_ request: ProfileDetails.Request.FetchCurrentUserData)
    func fetchAllNotifications(_ request: ProfileDetails.Request.FetchNotifications)
    func fetchUserData(_ request: ProfileDetails.Request.UserData)
    func fetchAddConnection(_ request: ProfileDetails.Request.NewConnectNotification)
    func fetchAddConnection(_ request: ProfileDetails.Request.AddConnection)
    func fetchAllConnections(_ reques: ProfileDetails.Request.AllConnections)
}

protocol ProfileDetailsDataStore {
    var userData: ProfileDetails.Info.Received.User? { get set }
    var currentUserId: String? { get set }
    var currentUser: ProfileDetails.Info.Model.CurrentUser? { get set }
}

class ProfileDetailsInteractor: ProfileDetailsDataStore {
    
    var presenter: ProfileDetailsPresentationLogic
    var worker: ProfileDetailsWorkerProtocol
    
    var userData: ProfileDetails.Info.Received.User?
    var currentUserId: String?
    var currentUser: ProfileDetails.Info.Model.CurrentUser?
    
    init(viewController: ProfileDetailsDisplayLogic,
         worker: ProfileDetailsWorkerProtocol = ProfileDetailsWorker()) {
        self.presenter = ProfileDetailsPresenter(viewController: viewController)
        self.worker = worker
    }
}

extension ProfileDetailsInteractor: ProfileDetailsBusinessLogic {
    
    func fetchCurrentUserId(_ request: ProfileDetails.Request.FetchCurrentUserId) {
        worker.fetchCurrentUserId(request) { response in
            switch response {
            case .success(let data):
                self.currentUserId = data
                self.fetchCurrentUserData(ProfileDetails.Request.FetchCurrentUserData(userId: data))
                break
            case .error:
                break
            }
        }
    }
    
    func fetchCurrentUserData(_ request: ProfileDetails.Request.FetchCurrentUserData) {
        worker.fetchCurrentUserData(request) { response in
            switch response {
            case .success(let data):
                let userData = data.userData
                if let currentUserId = self.currentUserId,
                    let name = userData["name"] as? String,
                    let email = userData["email"] as? String,
                    let image = userData["profile_image_url"] as? String,
                    let ocupation = userData["professional_area"] as? String {
                    self.currentUser = ProfileDetails.Info.Model.CurrentUser(id: currentUserId,
                                                                             name: name,
                                                                             image: image,
                                                                             email: email,
                                                                             ocupation: ocupation)
                }
                break
            case .error:
                break
            }
        }
    }
    
    func fetchAllNotifications(_ request: ProfileDetails.Request.FetchNotifications) {
        worker.fetchUserConnectNotifications(request) { response in
            switch response{
            case .success(let data):
                guard let currentUser = self.currentUser,
                    let toUserId = self.userData?.id else { return }
                let newConnectNotificationRequest = ProfileDetails
                    .Request
                    .NewConnectNotification(fromUserId: currentUser.id,
                                            toUserId: toUserId,
                                            name: currentUser.name,
                                            ocupation: currentUser.ocupation,
                                            email: currentUser.email,
                                            image: currentUser.image,
                                            oldNotifications: data.notifications)
                self.fetchAddConnection(newConnectNotificationRequest)
                 break
            case .error:
                break
            }
        }
    }
    
    func fetchUserData(_ request: ProfileDetails.Request.UserData) {
        let response = ProfileDetails.Info.Model.User(id: userData?.id ?? .empty,
                                                      image: userData?.image,
                                                      name: userData?.name ?? .empty,
                                                      occupation: userData?.occupation ?? .empty,
                                                      email: userData?.email ?? .empty,
                                                      phoneNumber: userData?.phoneNumber ?? .empty,
                                                      connectionsCount: userData?.connectionsCount ?? 0,
                                                      progressingProjects: [],
                                                      finishedProjects: [])
        presenter.presentUserInfo(response)
    }
    
    func fetchAddConnection(_ request: ProfileDetails.Request.NewConnectNotification) {
        
    }
    
    func fetchAddConnection(_ request: ProfileDetails.Request.AddConnection) {
        
    }
    
    func fetchAllConnections(_ reques: ProfileDetails.Request.AllConnections) {
        //TO DO
    }
}
