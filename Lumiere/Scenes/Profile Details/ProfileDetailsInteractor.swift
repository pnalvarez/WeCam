//
//  ProfileDetailsInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import ObjectMapper

protocol ProfileDetailsBusinessLogic {
    func fetchUserInfo(_ request: ProfileDetails.Request.UserData) //NEW
    func fetchInteract(_ request: ProfileDetails.Request.AddConnection)
    func fetchConfirmInteraction(_ request: ProfileDetails.Request.ConfirmInteraction)
    func didSelectOnGoingProject(_ request: ProfileDetails.Request.SelectProjectWithIndex)
    func didSelectFinishedProject(_ request: ProfileDetails.Request.SelectProjectWithIndex)
}

protocol ProfileDetailsDataStore {
    var receivedUserData: ProfileDetails.Info.Received.User? { get set }
    var userDataModel: ProfileDetails.Info.Model.User? { get set }
    var selectedProject: ProfileDetails.Info.Model.Project? { get set }
}

class ProfileDetailsInteractor: ProfileDetailsDataStore {
    
    private let presenter: ProfileDetailsPresentationLogic
    private let worker: ProfileDetailsWorkerProtocol
    
    var receivedUserData: ProfileDetails.Info.Received.User?
    var userDataModel: ProfileDetails.Info.Model.User?
    var selectedProject: ProfileDetails.Info.Model.Project?
    
    init(presenter: ProfileDetailsPresentationLogic,
         worker: ProfileDetailsWorkerProtocol = ProfileDetailsWorker()) {
        self.presenter = presenter
        self.worker = worker
    }
}

extension ProfileDetailsInteractor {
    
    private func fetchSendConnectionRequest() {
        guard let id = userDataModel?.id else {
            return
        }
        worker.fetchSendConnectionRequest(ProfileDetails.Request.SendConnectionRequest(id: id)) { response in
            switch response {
            case .success:
                self.userDataModel?.connectionType = .pending
                break
            case .error(let error):
                self.presenter.presentNewInteractionIcon(ProfileDetails
                    .Info
                    .Model
                    .NewConnectionType(connectionType: .nothing))
                self.presenter.presentError(ProfileDetails
                    .Errors
                    .ProfileDetailsError(description: error.description))
            }
        }
    }
    
    private func fetchAcceptConnection() {
        guard let id = userDataModel?.id else { return }
        worker.fetchAcceptConnection(ProfileDetails.Request.AcceptConnectionRequest(id: id)) { response in
            switch response {
            case .success:
                self.userDataModel?.connectionType = .contact
            case .error(let error):
                self.presenter.presentNewInteractionIcon(ProfileDetails
                .Info
                .Model
                .NewConnectionType(connectionType: .sent))
                self.presenter.presentError(ProfileDetails
                .Errors
                .ProfileDetailsError(description: error.description))
            }
        }
    }
    
    private func fetchRemoveConnection() {
        guard let id = userDataModel?.id else { return }
        worker.fetchRemoveConnection(ProfileDetails.Request.RemoveConnection(id: id)) { response in
            switch response {
            case .success:
                self.userDataModel?.connectionType = .nothing
            case .error(let error):
                self.presenter.presentNewInteractionIcon(ProfileDetails
                .Info
                .Model
                .NewConnectionType(connectionType: .contact))
                self.presenter.presentError(ProfileDetails
                    .Errors
                    .ProfileDetailsError(description: error.description))
            }
        }
    }
    
    private func fetchRemovePendingConnection() {
        guard let id = userDataModel?.id else { return }
        worker.fetchRemovePendingConnection(ProfileDetails.Request.RemovePendingConnection(id: id)) { response in
            switch response {
            case .success:
                self.userDataModel?.connectionType = .nothing
                break
            case .error(let error):
                self.presenter.presentNewInteractionIcon(ProfileDetails
                .Info
                .Model
                .NewConnectionType(connectionType: .pending))
                self.presenter.presentError(ProfileDetails
                    .Errors
                    .ProfileDetailsError(description: error.description))
            }
        }
    }
    
    private func fetchSignOut() {
        presenter.presentLoading(true)
        worker.fetchSignOut(ProfileDetails.Request.SignOut()) { response in
            switch response {
            case .success:
                self.presenter.presentLoading(false)
                self.presenter.didSignOut()
                break
            case .error(let error):
                self.presenter.presentLoading(false)
                self.presenter.presentError(ProfileDetails.Errors.ProfileDetailsError(description: error.description))
            }
        }
    }
    
    private func fetchUserRelation() {
        worker.fetchUserRelation(ProfileDetails
            .Request
            .FetchUserRelation(userId: receivedUserData?.userId ?? .empty)) { response in
            switch response {
            case .success(let data):
                guard let relation = data.relation else {
                    return
                }
                if relation == "LOGGED" {
                    self.userDataModel?.connectionType = .logged
                } else if relation == "CONNECTED" {
                    self.userDataModel?.connectionType = .contact
                } else if relation == "PENDING" {
                    self.userDataModel?.connectionType = .pending
                } else if relation == "SENT" {
                    self.userDataModel?.connectionType = .sent
                } else {
                    self.userDataModel?.connectionType = .nothing
                }
                self.fetchUserOnGoingProjects()
            case .error(let error):
                break
            }
        }
    }
    
    private func fetchUserOnGoingProjects() {
        worker.fetchCurrentProjectsData(ProfileDetails.Request.FetchUserProjects(userId: receivedUserData?.userId ?? .empty)) { response in
            switch response {
            case .success(let data):
                self.userDataModel?.progressingProjects = data.map({ ProfileDetails.Info.Model.Project(id: $0.projectId ?? .empty, image: $0.image ?? .empty)})
                self.fetchUserFinishedProjects()
            case .error(let error):
                break
            }
        }
    }
    
    private func fetchUserFinishedProjects() {
        worker.fetchFinishedProjectsData(ProfileDetails.Request.FetchUserProjects(userId: receivedUserData?.userId ?? .empty)) { response in
            switch response {
            case .success(let data):
                self.userDataModel?.finishedProjects = data.map({ ProfileDetails.Info.Model.Project(id: $0.projectId ?? .empty, image: $0.image ?? .empty)})
                self.presenter.presentLoading(false)
                guard let userModel = self.userDataModel else { return }
                self.presenter.presentUserInfo(userModel)
            case .error(let error):
                break
            }
        }
    }
}

extension ProfileDetailsInteractor: ProfileDetailsBusinessLogic {
    
    func fetchUserInfo(_ request: ProfileDetails.Request.UserData) {
        presenter.presentLoading(true)
        worker.fetchUserData(ProfileDetails
            .Request
            .FetchUserDataWithId(userId: receivedUserData?.userId ?? .empty)) { response in
            switch response {
            case .success(let data):
                self.userDataModel = ProfileDetails.Info.Model.User(connectionType: nil,
                                                                    id: data.id ?? .empty,
                                                                    image: data.image,
                                                                    name: data.name ?? .empty,
                                                                    occupation: data.ocupation ?? .empty,
                                                                    email: data.email ?? .empty,
                                                                    phoneNumber: data.phoneNumber ?? .empty, connectionsCount: data.connectionsCount ?? 0, progressingProjects: .empty, finishedProjects: .empty)
                self.fetchUserRelation()
            case .error(let error):
                self.presenter.presentLoading(false)
                self.presenter.presentError(ProfileDetails.Errors.ProfileDetailsError(description: error.description))
            }
        }
    }
    
    func fetchInteract(_ request: ProfileDetails.Request.AddConnection) {
        guard let connectionType = userDataModel?.connectionType else {
            return
        }
        guard connectionType != .nothing else {
            presenter.presentNewInteractionIcon(ProfileDetails
                .Info
                .Model
                .NewConnectionType(connectionType: .pending))
            fetchSendConnectionRequest()
            return
        }
        presenter.presentConfirmationAlert(ProfileDetails.Info.Model.IneractionConfirmation(connectionType: connectionType))
    }
    
    func fetchConfirmInteraction(_ request: ProfileDetails.Request.ConfirmInteraction) {
        guard let connectionType = userDataModel?.connectionType else {
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
            fetchSignOut()
            break
        case .nothing:
            break
        }
    }
    
    func didSelectOnGoingProject(_ request: ProfileDetails.Request.SelectProjectWithIndex) {
        selectedProject = userDataModel?.progressingProjects[request.index]
        presenter.presentOngoingProjectDetails()
    }
    
    func didSelectFinishedProject(_ request: ProfileDetails.Request.SelectProjectWithIndex) {
        selectedProject = userDataModel?.finishedProjects[request.index]
        presenter.presentFinishedProjectDetails()
    }
}
