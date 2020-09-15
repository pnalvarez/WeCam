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
    
    private func fetchUserToProjectRelation(request: InviteProfileToProjects.Request.FetchRelation) {
        worker.fetchUserProjectRelation(request: InviteProfileToProjects.Request.FetchUserProjectRelation(userId: request.userId, projectId: request.projectId)) { response in
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
        worker.fetchProjects(request: request) { response in
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
                                                               name: $0.name ?? .empty,
                                                               image: $0.image ?? .empty,
                                                               firstCathegory: firstCathegory ?? .empty,
                                                               secondCathegory: secondCathegory, relation: nil)
                }))
                for i in 0..<data.count {
                    self.fetchUserToProjectRelation(request: InviteProfileToProjects.Request.FetchRelation(userId: self.receivedUser?.userId ?? .empty, projectId: data[i].id ?? .empty, index: i))
                }
            case .error(let error):
                self.presenter.presentLoading(false)
            }
        }
    }
    
    func fetchInteraction(_ request: InviteProfileToProjects.Request.Interaction) {
        
    }
    
    func fetchConfirmInteraction(_ request: InviteProfileToProjects.Request.ConfirmInteraction) {
        
    }
    
    func fetchRefuseInteraction(_ request: InviteProfileToProjects.Request.RefuseInteraction) {
        
    }
    
    func fetchSearchProject(_ request: InviteProfileToProjects.Request.SearchProject) {
        guard let filteredProjects = projectsModel?.projects.filter({ $0.name.hasPrefix(request.preffix) }) else { return }
        presenter.presentProjects(InviteProfileToProjects.Info.Model.UpcomingProjects(projects: filteredProjects))
    }
}
