//
//  InviteProfileToProjectsInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 13/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol InviteProfileToProjectsBusinessLogic {
    func fetchProjects(_ request: InviteProfileToProjects.Request.FetchProjects)
    func fetchInteraction(_ request: InviteProfileToProjects.Request.Interaction)
    func fetchConfirmInteraction(_ request: InviteProfileToProjects.Request.ConfirmInteraction)
    func fetchRefuseInteraction(_ request: InviteProfileToProjects.Request.RefuseInteraction)
    func fetchSearchProject(_ request: InviteProfileToProjects.Request.SearchProject)
}

protocol InviteProfileToProjectsDataStore {
    var receivedUser: InviteProfileToProjects.Info.Received.User? { get set }
    var interactingProject: InviteProfileToProjects.Info.Model.Project? { get set }
    var projectsModel: InviteProfileToProjects.Info.Model.UpcomingProjects? { get set }
}

class InviteProfileToProjectsInteractor: InviteProfileToProjectsDataStore {
    
    private let worker: InviteProfileToProjectsWorkerProtocol
    private let presenter: InviteProfileToProjectsPresentationLogic
    
    var receivedUser: InviteProfileToProjects.Info.Received.User?
    var interactingProject: InviteProfileToProjects.Info.Model.Project?
    var projectsModel: InviteProfileToProjects.Info.Model.UpcomingProjects?
    
    init(worker: InviteProfileToProjectsWorkerProtocol = InviteProfileToProjectsWorker(),
         presenter: InviteProfileToProjectsPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
}

extension InviteProfileToProjectsInteractor {
    
    private func fetchUserToOngoingProjectRelation(request: InviteProfileToProjects.Request.FetchRelation) {
        worker.fetchUserOnGoingProjectRelation(request: InviteProfileToProjects.Request.FetchUserProjectRelation(userId: request.userId, projectId: request.projectId)) { response in
            switch response {
            case .success(let data):
                guard let relation = data.relation else { return }
                var newRelation: InviteProfileToProjects.Info.Model.Relation
                if relation == "SIMPLE PARTICIPANT" {
                    newRelation = .participating
                } else if relation == "SENT REQUEST" {
                    newRelation = .sentRequest
                } else if relation == "RECEIVED REQUEST" {
                    newRelation = .receivedRequest
                } else {
                    newRelation = .nothing
                }
                guard let index = self.projectsModel?.projects.firstIndex(where: { $0.id == request.projectId }) else { return }
                self.projectsModel?.projects[index].relation = newRelation
                if self.allRelationsFetched() {
                    self.presenter.presentLoading(false)
                    guard let projectsModel = self.projectsModel else {
                        return
                    }
                    self.presenter.presentProjects(projectsModel)
                }
            case .error(let error):
                self.presenter.presentLoading(false)
                self.presenter.presenterError(error)
            }
        }
    }
    
    private func fetchUserToFinishedProjectRelation(request: InviteProfileToProjects.Request.FetchRelation) {
        worker.fetchUserFinishedProjectRelation(request: InviteProfileToProjects.Request.FetchUserProjectRelation(userId: request.userId, projectId: request.projectId)) { response in
            switch response {
            case .success(let data):
                guard let relation = data.relation else { return }
                var newRelation: InviteProfileToProjects.Info.Model.Relation
                if relation == "SIMPLE PARTICIPANT" {
                    newRelation = .participating
                } else if relation == "SENT REQUEST" {
                    newRelation = .sentRequest
                } else if relation == "RECEIVED REQUEST" {
                    newRelation = .receivedRequest
                } else {
                    newRelation = .nothing
                }
                guard let index = self.projectsModel?.projects.firstIndex(where: { $0.id == request.projectId }) else { return }
                self.projectsModel?.projects[index].relation = newRelation
                if self.allRelationsFetched() {
                    self.presenter.presentLoading(false)
                    guard let projectsModel = self.projectsModel else {
                        return
                    }
                    self.presenter.presentProjects(projectsModel)
                }
            case .error(let error):
                self.presenter.presentLoading(false)
                self.presenter.presenterError(error)
            }
        }
    }
    
    private func fetchAcceptUserIntoProject(request: InviteProfileToProjects.Request.AcceptUser) {
        guard let index = projectsModel?.projects.firstIndex(where: { $0.id == interactingProject?.id  }) else { return }
        presenter.presentRelationUpdate(InviteProfileToProjects
                                            .Info
                                            .Model
                                            .RelationUpdate(index: index,
                                                            relation: .participating))
        worker.fetchAcceptUserIntoOngoingProject(request: request) { response in
            switch response {
            case .success:
                self.projectsModel?.projects[index].relation = .participating
            case .error(let error):
                self.presenter.presenterError(error)
                self.presenter.presentRelationUpdate(InviteProfileToProjects.Info.Model.RelationUpdate(index: index, relation: .sentRequest))
            }
        }
    }
    
    private func fetchRefuseUserIntoProject(request: InviteProfileToProjects.Request.RefuseUser) {
        guard let index = projectsModel?.projects.firstIndex(where: { $0.id == interactingProject?.id }) else { return }
        presenter.presentRelationUpdate(InviteProfileToProjects
                                            .Info
                                            .Model
                                            .RelationUpdate(index: index,
                                                            relation: .nothing))
        worker.fetchRefuseUserIntoOngoingProject(request: request) { response in
            switch response {
            case .success:
                self.projectsModel?.projects[index].relation = .nothing
            case .error(let error):
                self.presenter.presenterError(error)
                self.presenter.presentRelationUpdate(InviteProfileToProjects.Info.Model.RelationUpdate(index: index, relation: .sentRequest))
            }
        }
    }
    
    private func fetchRemoveUserFromProject(request: InviteProfileToProjects.Request.RemoveUser) {
        guard let index = projectsModel?.projects.firstIndex(where: { $0.id == interactingProject?.id }) else { return }
        presenter.presentRelationUpdate(InviteProfileToProjects
                                            .Info
                                            .Model
                                            .RelationUpdate(index: index,
                                                            relation: .nothing))
        worker.fetchRemoveUserFromOngoingProject(request: request) { response in
            switch response {
            case .success:
                self.projectsModel?.projects[index].relation = .nothing
            case .error(let error):
                self.presenter.presenterError(error)
                self.presenter.presentRelationUpdate(InviteProfileToProjects.Info.Model.RelationUpdate(index: index, relation: .participating))
            }
        }
    }
    
    private func removeInviteToOngoingProject(index: Int) {
        worker.fetchRemoveInviteToOngoingProject(request: InviteProfileToProjects.Request.RemoveInvite(userId: receivedUser?.userId ?? .empty, projectId: interactingProject?.id ?? .empty)) { response in
            switch response {
            case .success:
                self.projectsModel?.projects[index].relation = .nothing
            case .error(let error):
                self.presenter.presenterError(error)
                self.presenter.presentRelationUpdate(InviteProfileToProjects.Info.Model.RelationUpdate(index: index, relation: .receivedRequest))
            }
        }
    }
    
    private func removeInviteToFinishedProject(index: Int) {
        worker.fetchRemoveInviteToFinishedProject(request: InviteProfileToProjects.Request.RemoveInvite(userId: receivedUser?.userId ?? .empty, projectId: interactingProject?.id ?? .empty)) { response in
            switch response {
            case .success:
                self.projectsModel?.projects[index].relation = .nothing
            case .error(let error):
                self.presenter.presenterError(error)
                self.presenter.presentRelationUpdate(InviteProfileToProjects.Info.Model.RelationUpdate(index: index, relation: .receivedRequest))
            }
        }
    }
    
    private func inviteUserToOngoingProject(index: Int) {
        worker.fetchInviteUserToOngoingProject(request: InviteProfileToProjects
                                                .Request
                                                .InviteUserToOngoingProject(userId: receivedUser?.userId ?? .empty,
                                                                            projectId: interactingProject?.id ?? .empty,
                                                                            projectTitle: interactingProject?.name ?? .empty,
                                                                            projectImage: interactingProject?.image ?? .empty,
                                                                            authorId: interactingProject?.authorId ?? .empty)) { response in
            switch response {
            case .success:
                self.projectsModel?.projects[index].relation = .receivedRequest
            case .error(let error):
                self.presenter.presenterError(error)
                self.presenter.presentRelationUpdate(InviteProfileToProjects.Info.Model.RelationUpdate(index: index, relation: .nothing))
            }
        }
    }
    
    private func inviteUserToFinishedProject(index: Int) {
        worker.fetchInviteUserToFinishedProject(request: InviteProfileToProjects.Request.InviteUserToFinishedProject(userId: receivedUser?.userId ?? .empty, projectId: interactingProject?.id ?? .empty)) { response in
            switch response {
            case .success:
                self.projectsModel?.projects[index].relation = .receivedRequest
            case .error(let error):
                self.presenter.presenterError(error)
                self.presenter.presentRelationUpdate(InviteProfileToProjects.Info.Model.RelationUpdate(index: index, relation: .nothing))
            }
        }
    }
    
    private func allRelationsFetched() -> Bool {
        return !(projectsModel?.projects.contains(where: { $0.relation == nil }) ?? false)
    }
}

extension InviteProfileToProjectsInteractor: InviteProfileToProjectsBusinessLogic {
    
    func fetchProjects(_ request: InviteProfileToProjects.Request.FetchProjects) {
        presenter.presentLoading(true)
        worker.fetchOngoingProjects(request: request) { response in
            switch response {
            case .success(let data):
                self.projectsModel = InviteProfileToProjects.Info.Model.UpcomingProjects(projects: data.map({
                    var firstCathegory: String?
                    var secondCathegory: String?
                    if $0.cathegories?.count ?? 0 > 0 {
                        firstCathegory = $0.cathegories?[0]
                        if $0.cathegories?.count ?? 0 > 1 {
                            secondCathegory = $0.cathegories?[1]
                        }
                    }
                    return InviteProfileToProjects.Info.Model.Project(id: $0.id ?? .empty,
                                                                      name: $0.title ?? .empty,
                                                                      image: $0.image ?? .empty,
                                                                      authorId: $0.authorId ?? .empty,
                                                                      firstCathegory: firstCathegory ?? .empty,
                                                                      secondCathegory: secondCathegory,
                                                                      progress: $0.progress ?? 0,
                                                                      relation: nil)
                }))
                for i in 0..<data.count {
                    if data[i].progress ?? 0 < 100 {
                        self.fetchUserToOngoingProjectRelation(request: InviteProfileToProjects.Request.FetchRelation(userId: self.receivedUser?.userId ?? .empty, projectId: data[i].id ?? .empty, index: i))
                    } else {
                        self.fetchUserToFinishedProjectRelation(request: InviteProfileToProjects.Request.FetchRelation(userId: self.receivedUser?.userId ?? .empty, projectId: data[i].id ?? .empty, index: i))
                    }
                }
            case .error(let error):
                self.presenter.presentLoading(false)
                self.presenter.presenterError(error)
            }
        }
    }
    
    func fetchInteraction(_ request: InviteProfileToProjects.Request.Interaction) {
        guard let relation = projectsModel?.projects[request.index].relation else { return }
        interactingProject = projectsModel?.projects[request.index]
        guard let project = interactingProject else { return }
        switch relation {
        case .participating:
            if !project.finished {
                presenter.presentConfirmationAlert(InviteProfileToProjects
                                                    .Info
                                                    .Model
                                                    .Alert(text: InviteProfileToProjects.Constants.Texts.participatingAlert))
            }
        case .sentRequest:
            if !project.finished {
                presenter.presentConfirmationAlert(InviteProfileToProjects
                                                    .Info
                                                    .Model
                                                    .Alert(text: InviteProfileToProjects.Constants.Texts.sentRequestAlert))
            }
        case .receivedRequest:
            presenter.presentRelationUpdate(InviteProfileToProjects.Info.Model.RelationUpdate(index: request.index, relation: .nothing))
            if project.finished {
                removeInviteToFinishedProject(index: request.index)
            } else {
                removeInviteToOngoingProject(index: request.index)
            }
        case .nothing:
            presenter.presentRelationUpdate(InviteProfileToProjects.Info.Model.RelationUpdate(index: request.index, relation: .receivedRequest))
            if project.finished {
                inviteUserToFinishedProject(index: request.index)
            } else {
                inviteUserToOngoingProject(index: request.index)
            }
        }
    }
    
    func fetchConfirmInteraction(_ request: InviteProfileToProjects.Request.ConfirmInteraction) {
        guard let relation = interactingProject?.relation else { return }
        switch relation {
        case .participating:
            presenter.hideConfirmationAlert()
            fetchRemoveUserFromProject(request: InviteProfileToProjects
                                        .Request
                                        .RemoveUser(userId: receivedUser?.userId ?? .empty,
                                                    projectId: interactingProject?.id ?? .empty))
        case .sentRequest:
            presenter.hideConfirmationAlert()
            fetchAcceptUserIntoProject(request: InviteProfileToProjects
                                        .Request
                                        .AcceptUser(userId: receivedUser?.userId ?? .empty,
                                                    projectId: interactingProject?.id ?? .empty))
        case .receivedRequest:
            break
        case .nothing:
            break
        }
    }
    
    func fetchRefuseInteraction(_ request: InviteProfileToProjects.Request.RefuseInteraction) {
        guard let relation = interactingProject?.relation else { return }
        switch relation {
        case .participating:
            presenter.hideConfirmationAlert()
        case .sentRequest:
            presenter.hideConfirmationAlert()
            fetchRefuseUserIntoProject(request: InviteProfileToProjects
                                        .Request
                                        .RefuseUser(userId: receivedUser?.userId ?? .empty,
                                                    projectId: interactingProject?.id ?? .empty))
        case .receivedRequest:
            break
        case .nothing:
            break
        }
    }
    
    func fetchSearchProject(_ request: InviteProfileToProjects.Request.SearchProject) {
        guard let filteredProjects = projectsModel?.projects.filter({ $0.name.hasPrefix(request.preffix) }) else { return }
        presenter.presentProjects(InviteProfileToProjects.Info.Model.UpcomingProjects(projects: filteredProjects))
    }
}
