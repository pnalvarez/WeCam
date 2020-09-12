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

extension OnGoingProjectInvitesInteractor: OnGoingProjectInvitesBusinessLogic {
    
    func fetchUsers(_ request: OnGoingProjectInvites.Request.FetchUsers) {
        
    }
    
    func fetchProject(_ request: OnGoingProjectInvites.Request.FetchProject) {
        
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
