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

extension InviteProfileToProjectsInteractor: InviteProfileToProjectsBusinessLogic {
    
    func fetchProjects(_ request: InviteProfileToProjects.Request.FetchProjects) {
        
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
