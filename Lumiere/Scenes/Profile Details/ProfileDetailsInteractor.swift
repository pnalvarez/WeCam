//
//  ProfileDetailsInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import ObjectMapper

protocol ProfileDetailsBusinessLogic {
    func fetchUserData(_ request: ProfileDetails.Request.UserData)
    func fetchInteract(_ request: ProfileDetails.Request.AddConnection)
    func fetchAllConnections(_ reques: ProfileDetails.Request.AllConnections)
}

protocol ProfileDetailsDataStore {
    var userData: ProfileDetails.Info.Received.User? { get set }
}

class ProfileDetailsInteractor: ProfileDetailsDataStore {
    
    var presenter: ProfileDetailsPresentationLogic
    var worker: ProfileDetailsWorkerProtocol
    
    var userData: ProfileDetails.Info.Received.User?
    
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
                self.userData?.connectionType = .pending
                break
            case .error(let error):
                self.presenter.presentNewInteractionIcon(ProfileDetails
                    .Info
                    .Model
                    .NewConnectionType(connectionType: .nothing))
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
                self.userData?.connectionType = .contact
                break
            case .error(let error):
                self.presenter.presentNewInteractionIcon(ProfileDetails
                .Info
                .Model
                .NewConnectionType(connectionType: .sent))
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
                self.userData?.connectionType = .nothing
                break
            case .error(let error):
                self.presenter.presentNewInteractionIcon(ProfileDetails
                .Info
                .Model
                .NewConnectionType(connectionType: .contact))
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
                self.userData?.connectionType = .nothing
                break
            case .error(let error):
                self.presenter.presentNewInteractionIcon(ProfileDetails
                .Info
                .Model
                .NewConnectionType(connectionType: .pending))
                self.presenter.presentError(ProfileDetails
                    .Errors
                    .ProfileDetailsError(description: error.localizedDescription))
            }
        }
    }
    
    private func checkUserTypeModifications() {
        if let type = userData?.connectionType, type == .logged {
            presenter.presentInterfaceForLogged()
        }
    }
}

extension ProfileDetailsInteractor: ProfileDetailsBusinessLogic {
    
    func fetchUserData(_ request: ProfileDetails.Request.UserData) {
        let response = ProfileDetails.Info.Model.User(connectionType: userData?.connectionType ?? .nothing,
                                                      id: userData?.id ?? .empty,
                                                      image: userData?.image,
                                                      name: userData?.name ?? .empty,
                                                      occupation: userData?.ocupation ?? .empty,
                                                      email: userData?.email ?? .empty,
                                                      phoneNumber: userData?.phoneNumber ?? .empty,
                                                      connectionsCount: userData?.connectionsCount ?? .empty,
                                                      progressingProjects: [],
                                                      finishedProjects: [])
        presenter.presentUserInfo(response)
        presenter.presentInterfaceForLogged()
    }
    
    func fetchInteract(_ request: ProfileDetails.Request.AddConnection) {
        guard let connectionType = userData?.connectionType else {
            return
        }
        switch connectionType {
        case .contact:
            presenter.presentNewInteractionIcon(ProfileDetails
                .Info
                .Model
                .NewConnectionType(connectionType: .nothing))
            fetchRemoveConnection()
            break
        case .pending:
            presenter.presentNewInteractionIcon(ProfileDetails
                .Info
                .Model
                .NewConnectionType(connectionType: .nothing))
            fetchRemovePendingConnection()
            break
        case .sent:
            presenter.presentNewInteractionIcon(ProfileDetails
                .Info
                .Model
                .NewConnectionType(connectionType: .contact))
            fetchAcceptConnection()
            break
        case .logged:
            presenter.presentNewInteractionIcon(ProfileDetails
                .Info
                .Model
                .NewConnectionType(connectionType: .logged))
        case .nothing:
            presenter.presentNewInteractionIcon(ProfileDetails
                .Info
                .Model
                .NewConnectionType(connectionType: .pending))
            fetchSendConnectionRequest()
            break
        }
    }
    
    func fetchAllConnections(_ reques: ProfileDetails.Request.AllConnections) {
        presenter.presentAllConnections()
    }
}

