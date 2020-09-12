//
//  OnGoingProjectInvitesInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 12/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol OnGoingProjectInvitesBusinessLogic {
    func fetchUsers(_ request: OnGoingProjectInvites.Request.FetchUsers)
    func fetchProject(_ request: OnGoingProjectInvites.Request.FetchProject)
    func fetchInteract(_ request: OnGoingProjectInvites.Request.Interaction)
    func fetchConfirmInteraction(_ request: OnGoingProjectInvites.Request.ConfirmInteraction)
    func fetchRefuseInteraction(_ request: OnGoingProjectInvites.Request.RefuseInteraction)
    func fetchSearchUser(_ request: OnGoingProjectInvites.Request.Search)
    func didSelectUser(_ request: OnGoingProjectInvites.Request.SelectUser)
}

protocol OnGoingProjectInvitesDataStore {
    var projectModel: OnGoingProjectInvites.Info.Received.Project? { get set }
    var users: OnGoingProjectInvites.Info.Model.UpcomingUsers? { get set }
    var selectedUser: OnGoingProjectInvites.Info.Model.User? { get set }
    var interactingUser: OnGoingProjectInvites.Info.Model.User? { get set }
}

class OnGoingProjectInvitesInteractor: OnGoingProjectInvitesDataStore {
    
    private let worker: OnGoingProjectInvitesWorkerProtocol
    private let presenter: OnGoingProjectInvitesPresentationLogic
    
    var projectModel: OnGoingProjectInvites.Info.Received.Project?
    var users: OnGoingProjectInvites.Info.Model.UpcomingUsers?
    var selectedUser: OnGoingProjectInvites.Info.Model.User?
    var interactingUser: OnGoingProjectInvites.Info.Model.User?
    
    init(worker: OnGoingProjectInvitesWorkerProtocol = OnGoingProjectInvitesWorker(),
         presenter: OnGoingProjectInvitesPresenter) {
        self.worker = worker
        self.presenter = presenter
    }
}

extension OnGoingProjectInvitesInteractor {
    
    private func fetchUserRelationToProject(request: OnGoingProjectInvites.Request.FetchRelation) {
        worker.fetchUserRelationToProject(request) { response in
            switch response {
            case .success(let data):
                self.presenter.presentLoading(false)
                guard let relation = data.relation else { return }
                var newRelation: OnGoingProjectInvites.Info.Model.Relation
                if relation == "PARTICIPANT" {
                    newRelation = .simpleParticipant
                } else if relation == "SENT REQUEST" {
                    newRelation = .sentRequest
                } else if relation == "RECEIVED REQUEST" {
                    newRelation = .receivedRequest
                } else {
                    newRelation = .nothing
                }
                guard let index = self.users?.users.firstIndex(where: { $0.userId == request.userId }) else { return }
                self.users?.users[index].relation = newRelation
            case .error(let error):
                break
            }
        }
    }
}

extension OnGoingProjectInvitesInteractor: OnGoingProjectInvitesBusinessLogic {
    
    func fetchUsers(_ request: OnGoingProjectInvites.Request.FetchUsers) {
        presenter.presentLoading(true)
        worker.fetchConnections(request) { response in
            switch response {
            case .success(let data):
                for i in 0..<data.count {
                    self.fetchUserRelationToProject(request: OnGoingProjectInvites.Request.FetchRelation(userId: data[i].id ?? .empty, projectId: self.projectModel?.projectId ?? .empty))
                    if i == data.count-1 {
                        guard let usersResponse = self.users else { return }
                        self.presenter.presentUsers(usersResponse)
                    }
                }
            case .error(let error):
                break
            }
        }
    }
    
    func fetchProject(_ request: OnGoingProjectInvites.Request.FetchProject) {
        self.presenter.presentLoading(true)
        worker.fetchProjectInfo(OnGoingProjectInvites.Request.FetchProjectWithId(id: projectModel?.projectId ?? .empty)) { response in
            switch response {
            case .success(let data):
                let project = OnGoingProjectInvites
                    .Info
                    .Model
                    .Project(projectId: self.projectModel?.projectId ?? .empty,
                             title: data.title ?? .empty)
                self.presenter.presentProject(project)
            case .error(let error):
                break
            }
        }
    }
    
    func fetchInteract(_ request: OnGoingProjectInvites.Request.Interaction) {
        
    }
    
    func fetchConfirmInteraction(_ request: OnGoingProjectInvites.Request.ConfirmInteraction) {
        
    }
    
    func fetchRefuseInteraction(_ request: OnGoingProjectInvites.Request.RefuseInteraction) {
        
    }
    
    func fetchSearchUser(_ request: OnGoingProjectInvites.Request.Search) {
        
    }
    
    func didSelectUser(_ request: OnGoingProjectInvites.Request.SelectUser) {
        
    }
}
