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
    func fetchInteract(_ request: ProfileDetails.Request.AddConnection)
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

extension ProfileDetailsInteractor {
    
    private func fetchSendConnectionRequest() {
        guard let id = userData?.id else { return }
        worker.fetchSendConnectionRequest(ProfileDetails.Request.SendConnectionRequest(id: id)) { response in
            switch response {
            case .success:
                self.presenter.didFetchInteraction()
                break
            case .error(let error):
                self.presenter.presentError(ProfileDetails
                    .Errors
                    .ProfileDetailsError(description: error.localizedDescription))
            }
        }
    }
    
    private func fetchAcceptConnection() {
        guard let id = userData?.id else { return }
        worker.fetchAcceptConnection(ProfileDetails.Request.AcceptConnectionRequest(id: id)) { response in
            switch response {
            case .success:
                self.presenter.didFetchInteraction()
                break
            case .error(let error):
                self.presenter.presentError(ProfileDetails
                .Errors
                .ProfileDetailsError(description: error.localizedDescription))
            }
        }
    }
    
    private func fetchRemoveConnection() {
        guard let id = userData?.id else { return }
        worker.fetchRemoveConnection(ProfileDetails.Request.RemoveConnection(id: id)) { response in
            switch response {
            case .success:
                self.presenter.didFetchInteraction()
                break
            case .error(let error):
                self.presenter.presentError(ProfileDetails
                    .Errors
                    .ProfileDetailsError(description: error.localizedDescription))
                break
            }
        }
    }
    
    private func fetchRemovePendingConnection() {
        guard let id = userData?.id else { return }
        worker.fetchRemovePendingConnection(ProfileDetails.Request.RemovePendingConnection(id: id)) { response in
            switch response {
            case .success:
                self.presenter.didFetchInteraction()
                break
            case .error(let error):
                self.presenter.presentError(ProfileDetails
                    .Errors
                    .ProfileDetailsError(description: error.localizedDescription))
            }
        }
    }
}

extension ProfileDetailsInteractor: ProfileDetailsBusinessLogic {
    
    func fetchCurrentUserId(_ request: ProfileDetails.Request.FetchCurrentUserId) {
        worker.fetchCurrentUserId(request) { response in
            switch response {
            case .success(let data):
                self.currentUserId = data.id
                self.currentUser = ProfileDetails.Info.Model.CurrentUser(id: data.id ?? .empty,
                                                                         name: data.name ?? .empty,
                                                                         image: data.image ?? .empty,
                                                                         email: data.email ?? .empty,
                                                                         ocupation: data.ocupation ?? .empty)
                guard let id = self.userData?.id else { return }
                self.fetchAllNotifications(ProfileDetails.Request.FetchNotifications(userId: id))
                break
            case .error:
                self.presenter.presentError(ProfileDetails
                    .Errors
                    .ProfileDetailsError(description: ProfileDetails
                        .Constants
                        .Texts
                        .genericError))
                break
            }
        }
    }
    
    func fetchCurrentUserData(_ request: ProfileDetails.Request.FetchCurrentUserData) {
        worker.fetchCurrentUserData(request) { response in
            switch response {
            case .success(let data):
                self.currentUser = ProfileDetails.Info.Model.CurrentUser(id: self.currentUserId ?? .empty,
                                                                         name: data.name ?? .empty,
                                                                         image: data.image ?? .empty,
                                                                         email: data.email ?? .empty,
                                                                         ocupation: data.ocupation ?? .empty)
                guard let id = self.currentUserId else { return }
                self.fetchAllNotifications(ProfileDetails.Request.FetchNotifications(userId: id))
                break
            case .error:
                self.presenter.presentError(ProfileDetails
                    .Errors
                    .ProfileDetailsError(description: ProfileDetails.Constants.Texts.genericError))
                break
            }
        }
    }
    
    func fetchAllNotifications(_ request: ProfileDetails.Request.FetchNotifications) {
        worker.fetchUserConnectNotifications(request) { response in
            switch response {
            case .success(let data):
                guard let currentUser = self.currentUser,
                    let toUserId = self.userData?.id else { return }
                let newConnectNotificationRequest = ProfileDetails.Request.NewConnectNotification(
                    fromUserId: currentUser.id,
                    toUserId: toUserId,
                    name: currentUser.name,
                    ocupation: currentUser.ocupation,
                    email: currentUser.email,
                    image: currentUser.image,
                    oldNotifications: data)
                self.fetchAddConnection(newConnectNotificationRequest)
                break
            case .error(let error):
                self.presenter.presentError(ProfileDetails
                .Errors
                .ProfileDetailsError(description: error.localizedDescription))
                break
            }
        }
    }
    
    func fetchUserData(_ request: ProfileDetails.Request.UserData) {
        let response = ProfileDetails.Info.Model.User(connectionType: userData?.connectionType ?? .nothing,
                                                      id: userData?.id ?? .empty,
                                                      image: userData?.image,
                                                      name: userData?.name ?? .empty,
                                                      occupation: userData?.occupation ?? .empty,
                                                      email: userData?.email ?? .empty,
                                                      phoneNumber: userData?.phoneNumber ?? .empty,
                                                      connectionsCount: userData?.connectionsCount ?? .empty,
                                                      progressingProjects: [],
                                                      finishedProjects: [])
        presenter.presentUserInfo(response)
    }
    
    func fetchAddConnection(_ request: ProfileDetails.Request.NewConnectNotification) {
        worker.fetchAddConnection(request) { response in
            switch response {
            case .success:
                self.presenter.didFetchInteraction()
                break
            case .error(let error):
                self.presenter.presentError(ProfileDetails
                    .Errors
                    .ProfileDetailsError(description: error.localizedDescription))
            }
        }
    }
    
    func fetchInteract(_ request: ProfileDetails.Request.AddConnection) {
        guard let connectionType = userData?.connectionType else { return }
        switch connectionType {
        case .contact:
            fetchRemoveConnection()
            break
        case .pending:
            fetchRemovePendingConnection()
            break
        case .sent:
            fetchAcceptConnection()
            break
        case .nothing:
            fetchSendConnectionRequest()
            break
        }
//        fetchCurrentUserId(ProfileDetails.Request.FetchCurrentUserId())
    }
    
    func fetchAllConnections(_ reques: ProfileDetails.Request.AllConnections) {
        //TO DO
    }
}

