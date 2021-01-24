//
//  OnGoingProjectInvitesInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 12/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol ProjectInvitesBusinessLogic {
    func fetchUsers(_ request: ProjectInvites.Request.FetchUsers)
    func fetchProject(_ request: ProjectInvites.Request.FetchProject)
    func fetchInteract(_ request: ProjectInvites.Request.Interaction)
    func fetchConfirmInteraction(_ request: ProjectInvites.Request.ConfirmInteraction)
    func fetchRefuseInteraction(_ request: ProjectInvites.Request.RefuseInteraction)
    func fetchSearchUser(_ request: ProjectInvites.Request.Search)
    func didSelectUser(_ request: ProjectInvites.Request.SelectUser)
}

protocol ProjectInvitesDataStore {
    var projectReceivedModel: ProjectInvites.Info.Received.Project? { get set }
    var projectModel: ProjectInvites.Info.Model.Project? { get set }
    var users: ProjectInvites.Info.Model.UpcomingUsers? { get set }
    var selectedUser: ProjectInvites.Info.Model.User? { get set }
    var interactingUser: ProjectInvites.Info.Model.User? { get set }
    var filteredUsers: ProjectInvites.Info.Model.UpcomingUsers? { get set }
    var receivedContext: ProjectInvites.Info.Received.Context? { get set }
}

class ProjectInvitesInteractor: ProjectInvitesDataStore {
    
    private let worker: ProjectInvitesWorkerProtocol
    private let presenter: ProjectInvitesPresentationLogic
    
    var projectReceivedModel: ProjectInvites.Info.Received.Project?
    var projectModel: ProjectInvites.Info.Model.Project?
    var users: ProjectInvites.Info.Model.UpcomingUsers?
    var selectedUser: ProjectInvites.Info.Model.User?
    var interactingUser: ProjectInvites.Info.Model.User?
    var filteredUsers: ProjectInvites.Info.Model.UpcomingUsers?
    var receivedContext: ProjectInvites.Info.Received.Context?
    
    init(worker: ProjectInvitesWorkerProtocol = ProjectInvitesWorker(),
         presenter: ProjectInvitesPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
}

extension ProjectInvitesInteractor {
    
    private func fetchUserRelationToOnGoingProject(request: ProjectInvites.Request.FetchRelation) {
        worker.fetchUserRelationToOnGoingProject(request) { response in
            switch response {
            case .success(let data):
                self.presenter.presentLoading(false)
                self.parseRelations(data: data, userId: request.userId)
            case .error(let error):
                self.presenter.presentLoading(false)
                self.presenter.presentError(error)
            }
        }
    }
    
    private func fetchUserRelationToFinishedProject(request: ProjectInvites.Request.FetchRelation) {
        worker.fetchUserRelationToFinishedProject(request) { response in
            switch response {
            case .success(let data):
                self.presenter.presentLoading(false)
                self.parseRelations(data: data, userId: request.userId)
            case .error(let error):
                self.presenter.presentLoading(false)
                self.presenter.presentError(error)
            }
        }
    }
    
    private func parseRelations(data: ProjectInvites.Info.Response.UserRelation,
                                userId: String) {
        guard let relation = data.relation else { return }
        var newRelation: ProjectInvites.Info.Model.Relation
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
            { $0.userId == userId }) else { return }
        self.users?.users[index].relation = newRelation
        if self.allRelationsFetched() {
            guard let usersResponse = self.users else { return }
            self.filteredUsers = usersResponse
            self.presenter.presentUsers(usersResponse)
        }
    }
    
    private func acceptUserIntoProject(request: ProjectInvites.Request.AcceptUser) {
        guard let index = self.users?.users.firstIndex(where: { $0.userId == self.interactingUser?.userId }) else { return }
        worker.fetchAcceptUserIntoProject(request) { response in
            switch response {
            case .success:
                self.users?.users[index].relation = .simpleParticipant
            case .error(let error):
                self.presenter.presentError(error)
                self.presenter.presentRelationUpdate(ProjectInvites.Info.Model.RelationUpdate(index: index, relation: .sentRequest))
            }
        }
    }
    
    private func refuseUserIntoProject(request: ProjectInvites.Request.RefuseUser) {
        guard let index = self.users?.users.firstIndex(where: { $0.userId == self.interactingUser?.userId }) else { return }
        worker.fetchRefuseUserIntoProject(request) { response in
            switch response {
            case .success:
                self.users?.users[index].relation = .nothing
            case .error(let error):
                self.presenter.presentError(error)
                self.presenter.presentRelationUpdate(ProjectInvites.Info.Model.RelationUpdate(index: index, relation: .sentRequest))
            }
        }
    }
    
    private func removeUserFromProject(request: ProjectInvites.Request.RemoveUserFromProject) {
        guard let index = self.users?.users.firstIndex(where: { $0.userId == self.interactingUser?.userId }) else { return }
        worker.fetchRemoveUserFromOnGoingProject(request) { response in
            switch response {
            case .success:
                self.users?.users[index].relation = .nothing
            case .error(let error):
                self.presenter.presentError(error)
                self.presenter.presentRelationUpdate(ProjectInvites.Info.Model.RelationUpdate(index: index, relation: .simpleParticipant))
            }
        }
    }
    
    private func removeInvite(request: ProjectInvites.Request.RemoveInvite) {
        guard let index = self.users?.users.firstIndex(where: { $0.userId == self.interactingUser?.userId }) else { return }
        switch receivedContext {
        case .ongoing:
            worker.fetchRemoveOnGoingProjectInviteToUser(request) { response in
                switch response {
                case .success:
                    self.users?.users[index].relation = .nothing
                case .error(let error):
                    self.presenter.presentError(error)
                    self.presenter.presentRelationUpdate(ProjectInvites.Info.Model.RelationUpdate(index: index, relation: .receivedRequest))
                }
            }
        case .finished:
            worker.fetchRemoveFinishedProjectInvite(request: request) { response in
                switch response {
                case .success:
                    self.users?.users[index].relation = .nothing
                case .error(let error):
                    self.presenter.presentError(error)
                    self.presenter.presentRelationUpdate(ProjectInvites.Info.Model.RelationUpdate(index: index, relation: .receivedRequest))
                }
            }
        case .none:
            break
        }
    }
    
    private func allRelationsFetched() -> Bool {
        return !(users?.users.contains(where: { $0.relation == nil }) ?? false)
    }
    
    private func parseProjectData(data: ProjectInvites.Info.Response.Project) {
        projectModel = ProjectInvites
            .Info
            .Model
            .Project(projectId: projectReceivedModel?.projectId ?? .empty,
                     title: data.title ?? .empty,
                     image: data.image ?? .empty,
                     authorId: data.authorId ?? .empty)
        guard let project = projectModel else { return }
        presenter.presentProject(project)
    }
}

extension ProjectInvitesInteractor: ProjectInvitesBusinessLogic {
    
    func fetchUsers(_ request: ProjectInvites.Request.FetchUsers) {
        presenter.presentLoading(true)
        users = ProjectInvites.Info.Model.UpcomingUsers(users: .empty)
        worker.fetchConnections(request) { response in
            switch response {
            case .success(let data):
                guard data.count > 0 else {
                    self.presenter.presentLoading(false)
                    guard let users = self.users else { return }
                    self.presenter.presentUsers(users)
                    return
                }
                for i in 0..<data.count {
                    self.users?.users.append(ProjectInvites
                        .Info
                        .Model
                        .User(userId: data[i].id ?? .empty,
                              image: data[i].image ?? .empty,
                              name: data[i].name ?? .empty,
                              ocupation: data[i].ocupation ?? .empty,
                              email: data[i].email ?? .empty,
                              relation: nil))
                    switch self.receivedContext {
                    case .ongoing:
                        self.fetchUserRelationToOnGoingProject(request: ProjectInvites.Request.FetchRelation(userId: data[i].id ?? .empty, projectId: self.projectReceivedModel?.projectId ?? .empty, index: i))
                    case .finished:
                        self.fetchUserRelationToFinishedProject(request: ProjectInvites.Request.FetchRelation(userId: data[i].id ?? .empty, projectId: self.projectReceivedModel?.projectId ?? .empty, index: i))
                    case .none:
                        break
                    }
                }
            case .error(let error):
                self.presenter.presentLoading(false)
                self.presenter.presentError(error)
            }
        }
    }
    
    func fetchProject(_ request: ProjectInvites.Request.FetchProject) {
        self.presenter.presentLoading(true)
        switch receivedContext {
        case .ongoing:
            worker.fetchOnGoingProjectInfo(ProjectInvites.Request.FetchProjectWithId(id: projectReceivedModel?.projectId ?? .empty)) { response in
                switch response {
                case .success(let data):
                    self.parseProjectData(data: data)
                case .error(let error):
                    self.presenter.presentLoading(false)
                    self.presenter.presentError(error)
                }
            }
        case .finished:
            worker.fetchFinishedProjectInfo(request: ProjectInvites.Request.FetchProjectWithId(id: projectReceivedModel?.projectId ?? .empty)) { response in
                switch response {
                case .success(let data):
                    self.parseProjectData(data: data)
                case .error(let error):
                    self.presenter.presentLoading(false)
                    self.presenter.presentError(error)
                }
            }
        case .none:
            break
        }
    }
    
    func fetchInteract(_ request: ProjectInvites.Request.Interaction) {
        let index = request.index
        interactingUser = users?.users[index]
        let relation = interactingUser?.relation ?? .nothing
        switch relation {
        case .simpleParticipant:
            switch receivedContext {
            case .ongoing:
                presenter.presentModalAlert(ProjectInvites.Info.Model.Alert(text: ProjectInvites.Constants.Texts.removeUserAlert))
            case .finished:
                break
            case .none:
                break
            }
        case .sentRequest:
            presenter.presentModalAlert(ProjectInvites.Info.Model.Alert(text: ProjectInvites.Constants.Texts.acceptUserAlert))
        case .receivedRequest:
            presenter.presentModalAlert(ProjectInvites.Info.Model.Alert(text: ProjectInvites.Constants.Texts.removeInvite))
        case .nothing:
            presenter.presentRelationUpdate(ProjectInvites.Info.Model.RelationUpdate(index: index, relation: .receivedRequest))
            let request = ProjectInvites
                .Request
                .InviteUser(userId: interactingUser?.userId ?? .empty,
                            projectId: projectModel?.projectId ?? .empty,
                            projectImage: projectModel?.image ?? .empty,
                            projectTitle: projectModel?.title ?? .empty,
                            authorId: projectModel?.authorId ?? .empty)
            switch receivedContext {
            case .ongoing:
                worker.fetchInviteUserToOnGoingProject(request) { response in
                    switch response {
                    case .success:
                        self.users?.users[index].relation = .receivedRequest
                    case .error(let error):
                        self.presenter.presentError(error)
                        self.presenter.presentRelationUpdate(ProjectInvites.Info.Model.RelationUpdate(index: index, relation: .nothing))
                    }
                }
            case .finished:
                worker.fetchInviteUserToFinishedProject(request: request) { response in
                    switch response {
                    case .success:
                        self.users?.users[index].relation = .receivedRequest
                    case .error(let error):
                        self.presenter.presentError(error)
                        self.presenter.presentRelationUpdate(ProjectInvites.Info.Model.RelationUpdate(index: index, relation: .nothing))
                    }
                }
            case .none:
                break
            }
        }
    }
    
    func fetchConfirmInteraction(_ request: ProjectInvites.Request.ConfirmInteraction) {
        guard let index = users?.users.firstIndex(where: { $0.userId == interactingUser?.userId }) else { return }
        switch interactingUser?.relation ?? .nothing {
        case .simpleParticipant:
            presenter.hideModalAlert()
            presenter.presentRelationUpdate(ProjectInvites.Info.Model.RelationUpdate(index: index, relation: .nothing))
            removeUserFromProject(request: ProjectInvites.Request.RemoveUserFromProject(userId: interactingUser?.userId ?? .empty, projectId: projectModel?.projectId ?? .empty))
        case .sentRequest:
            presenter.hideModalAlert()
            presenter.presentRelationUpdate(ProjectInvites.Info.Model.RelationUpdate(index: index, relation: .simpleParticipant))
            acceptUserIntoProject(request: ProjectInvites.Request.AcceptUser(userId: interactingUser?.userId ?? .empty, projectId: projectModel?.projectId ?? .empty))
        case .receivedRequest:
            presenter.hideModalAlert()
            presenter.presentRelationUpdate(ProjectInvites.Info.Model.RelationUpdate(index: index, relation: .nothing))
            removeInvite(request: ProjectInvites.Request.RemoveInvite(userId: interactingUser?.userId ?? .empty, projectId: projectModel?.projectId ?? .empty))
        case .nothing:
            break
        }
    }
    
    func fetchRefuseInteraction(_ request: ProjectInvites.Request.RefuseInteraction) {
        presenter.hideModalAlert()
        guard let index = users?.users.firstIndex(where: { $0.userId == interactingUser?.userId }) else { return }
        switch interactingUser?.relation ?? .nothing {
        case .simpleParticipant:
            break
        case .sentRequest:
            presenter.presentRelationUpdate(ProjectInvites.Info.Model.RelationUpdate(index: index, relation: .nothing))
            refuseUserIntoProject(request: ProjectInvites.Request.RefuseUser(userId: interactingUser?.userId ?? .empty, projectId: projectModel?.projectId ?? .empty))
        case .receivedRequest:
            break
        case .nothing:
            break
        }
    }
    
    func fetchSearchUser(_ request: ProjectInvites.Request.Search) {
        guard let filtered = filteredUsers?.users.filter({ $0.name.hasPrefix(request.preffix) }),
            var filteredUsers = filteredUsers else { return }
        filteredUsers.users = filtered
        presenter.presentUsers(filteredUsers)
    }
    
    func didSelectUser(_ request: ProjectInvites.Request.SelectUser) {
        selectedUser = users?.users[request.index]
        presenter.presentProfileDetails()
    }
}
