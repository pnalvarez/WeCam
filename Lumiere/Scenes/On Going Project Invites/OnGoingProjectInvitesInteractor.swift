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
    var projectReceivedModel: OnGoingProjectInvites.Info.Received.Project? { get set }
    var projectModel: OnGoingProjectInvites.Info.Model.Project? { get set }
    var users: OnGoingProjectInvites.Info.Model.UpcomingUsers? { get set }
    var selectedUser: OnGoingProjectInvites.Info.Model.User? { get set }
    var interactingUser: OnGoingProjectInvites.Info.Model.User? { get set }
    var filteredUsers: OnGoingProjectInvites.Info.Model.UpcomingUsers? { get set }
}

class OnGoingProjectInvitesInteractor: OnGoingProjectInvitesDataStore {
    
    private let worker: OnGoingProjectInvitesWorkerProtocol
    private let presenter: OnGoingProjectInvitesPresentationLogic
    
    var projectReceivedModel: OnGoingProjectInvites.Info.Received.Project?
    var projectModel: OnGoingProjectInvites.Info.Model.Project?
    var users: OnGoingProjectInvites.Info.Model.UpcomingUsers?
    var selectedUser: OnGoingProjectInvites.Info.Model.User?
    var interactingUser: OnGoingProjectInvites.Info.Model.User?
    var filteredUsers: OnGoingProjectInvites.Info.Model.UpcomingUsers?
    
    init(worker: OnGoingProjectInvitesWorkerProtocol = OnGoingProjectInvitesWorker(),
         presenter: OnGoingProjectInvitesPresenter) {
        self.worker = worker
        self.presenter = presenter
    }
}

extension OnGoingProjectInvitesInteractor {
    
    private func fetchUserRelationToProject(request: OnGoingProjectInvites.Request.FetchRelation,
                                            count: Int) {
        worker.fetchUserRelationToProject(request) { response in
            switch response {
            case .success(let data):
                self.presenter.presentLoading(false)
                guard let relation = data.relation else { return }
                var newRelation: OnGoingProjectInvites.Info.Model.Relation
                if relation == "SIMPLE PARTICIPANT" {
                    newRelation = .simpleParticipant
                } else if relation == "SENT REQUEST" {
                    newRelation = .sentRequest
                } else if relation == "RECEIVED REQUEST" {
                    newRelation = .receivedRequest
                } else {
                    newRelation = .nothing
                }
                guard let index = self.users?.users.firstIndex(where:
                    { $0.userId == request.userId }) else { return }
                self.users?.users[index].relation = newRelation
                if self.allRelationsFetched() {
                    guard let usersResponse = self.users else { return }
                    self.filteredUsers = usersResponse
                    self.presenter.presentUsers(usersResponse)
                }
            case .error(let error):
                self.presenter.presentLoading(false)
                self.presenter.presentError(error)
            }
        }
    }
    
    private func acceptUserIntoProject(request: OnGoingProjectInvites.Request.AcceptUser) {
        
    }
    
    private func refuseUserIntoProject(request: OnGoingProjectInvites.Request.RefuseUser) {
        
    }
    
    private func removeUserFromProject(request: OnGoingProjectInvites.Request.RemoveUserFromProject) {
        
    }
    
    private func inviteUserToProject(request: OnGoingProjectInvites.Request.InviteUser) {
        
    }
    
    private func allRelationsFetched() -> Bool {
        return !(users?.users.contains(where: { $0.relation == nil }) ?? false)
    }
}

extension OnGoingProjectInvitesInteractor: OnGoingProjectInvitesBusinessLogic {
    
    func fetchUsers(_ request: OnGoingProjectInvites.Request.FetchUsers) {
        presenter.presentLoading(true)
        users = OnGoingProjectInvites.Info.Model.UpcomingUsers(users: .empty)
        worker.fetchConnections(request) { response in
            switch response {
            case .success(let data):
                for i in 0..<data.count {
                    self.users?.users.append(OnGoingProjectInvites
                        .Info
                        .Model
                        .User(userId: data[i].id ?? .empty,
                              image: data[i].image ?? .empty,
                              name: data[i].name ?? .empty,
                              ocupation: data[i].ocupation ?? .empty,
                              email: data[i].email ?? .empty,
                              relation: nil))
                    self.fetchUserRelationToProject(request: OnGoingProjectInvites.Request.FetchRelation(userId: data[i].id ?? .empty, projectId: self.projectReceivedModel?.projectId ?? .empty, index: i), count: data.count)
                }
            case .error(let error):
                self.presenter.presentLoading(false)
                self.presenter.presentError(error)
            }
        }
    }
    
    func fetchProject(_ request: OnGoingProjectInvites.Request.FetchProject) {
        self.presenter.presentLoading(true)
        worker.fetchProjectInfo(OnGoingProjectInvites.Request.FetchProjectWithId(id: projectReceivedModel?.projectId ?? .empty)) { response in
            switch response {
            case .success(let data):
                self.projectModel = OnGoingProjectInvites
                    .Info
                    .Model
                    .Project(projectId: self.projectReceivedModel?.projectId ?? .empty,
                             title: data.title ?? .empty,
                             image: data.image ?? .empty,
                             authorId: data.authorId ?? .empty)
                guard let project = self.projectModel else { return }
                self.presenter.presentProject(project)
            case .error(let error):
                self.presenter.presentLoading(false)
                self.presenter.presentError(error)
            }
        }
    }
    
    func fetchInteract(_ request: OnGoingProjectInvites.Request.Interaction) {
        let index = request.index
        interactingUser = users?.users[index]
        let relation = interactingUser?.relation ?? .nothing
        switch relation {
        case .simpleParticipant:
            presenter.presentModalAlert(OnGoingProjectInvites.Info.Model.Alert(text: OnGoingProjectInvites.Constants.Texts.removeUserAlert))
        case .sentRequest:
            presenter.presentModalAlert(OnGoingProjectInvites.Info.Model.Alert(text: OnGoingProjectInvites.Constants.Texts.acceptUserAlert))
        case .receivedRequest:
            presenter.presentModalAlert(OnGoingProjectInvites.Info.Model.Alert(text: OnGoingProjectInvites.Constants.Texts.removeInvite))
        case .nothing:
            presenter.presentRelationUpdate(OnGoingProjectInvites.Info.Model.RelationUpdate(index: index, relation: .receivedRequest))
            let request = OnGoingProjectInvites
                .Request
                .InviteUser(userId: interactingUser?.userId ?? .empty,
                            projectId: projectModel?.projectId ?? .empty,
                            projectImage: projectModel?.image ?? .empty,
                            projectTitle: projectModel?.title ?? .empty,
                            authorId: projectModel?.authorId ?? .empty)
            worker.fetchInviteUser(request) { response in
                switch response {
                case .success:
                    self.users?.users[index].relation = .receivedRequest
                case .error(let error):
                    self.presenter.presentError(error)
                    self.presenter.presentRelationUpdate(OnGoingProjectInvites.Info.Model.RelationUpdate(index: index, relation: .nothing))
                }
            }
        }
    }
    
    func fetchConfirmInteraction(_ request: OnGoingProjectInvites.Request.ConfirmInteraction) {
        
    }
    
    func fetchRefuseInteraction(_ request: OnGoingProjectInvites.Request.RefuseInteraction) {
        
    }
    
    func fetchSearchUser(_ request: OnGoingProjectInvites.Request.Search) {
        guard let filtered = filteredUsers?.users.filter({ $0.name.hasPrefix(request.preffix) }),
            var filteredUsers = filteredUsers else { return }
        filteredUsers.users = filtered
        presenter.presentUsers(filteredUsers)
    }
    
    func didSelectUser(_ request: OnGoingProjectInvites.Request.SelectUser) {
        selectedUser = users?.users[request.index]
        presenter.presentProfileDetails()
    }
}
