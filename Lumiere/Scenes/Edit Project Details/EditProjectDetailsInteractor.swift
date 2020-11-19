//
//  EditProjectDetailsInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 21/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol EditProjectDetailsBusinessLogic {
    func fetchInvitations(_ request: EditProjectDetails.Request.Invitations)
    func fetchContext(_ request: EditProjectDetails.Request.FetchContext)
    func fetchSubmit(_ request: EditProjectDetails.Request.Publish)
}

protocol EditProjectDetailsDataStore {
    var receivedData: EditProjectDetails.Info.Received.Project? { get set }
    var routingContext: EditProjectDetails.Info.Received.RoutingContext? { get set }
    var invitedUsers: EditProjectDetails.Info.Model.InvitedUsers? { get set }
    var publishingProject: EditProjectDetails.Info.Model.PublishingProject? { get set }
    var publishedProject: EditProjectDetails.Info.Model.PublishedProject? { get set }
}

class EditProjectDetailsInteractor: EditProjectDetailsDataStore {
    
    private var worker: EditProjectDetailsWorkerProtocol
    var presenter: EditProjectDetailsPresentationLogic
    
    var receivedData: EditProjectDetails.Info.Received.Project?
    var routingContext: EditProjectDetails.Info.Received.RoutingContext?
    var invitedUsers: EditProjectDetails.Info.Model.InvitedUsers?
    var publishingProject: EditProjectDetails.Info.Model.PublishingProject?
    var publishedProject: EditProjectDetails.Info.Model.PublishedProject?
    
    init(worker: EditProjectDetailsWorkerProtocol = EditProjectDetailsWorker(),
         presenter: EditProjectDetailsPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
        invitedUsers = EditProjectDetails.Info.Model.InvitedUsers(users: .empty)
    }
}

extension EditProjectDetailsInteractor {
    
    private func fetchInviteUsers(withProjectDate project: EditProjectDetails.Info.Model.PublishedProject) {
        guard let users = invitedUsers?.users, users.count > 0 else {
            presenter.presentPublishedProjectDetails()
            return
        }
        for i in 0..<users.count {
            let request = EditProjectDetails.Request.InviteUser(projectId: project.id,
                                                                userId: users[i].id,
                                                                title: project.title,
                                                                image: project.image,
                                                                authorId: project.authorId)
            worker.fetchInviteUser(request: request) { response in
                switch response {
                case .success:
                    if i == users.count-1 {
                        self.presenter.presentPublishedProjectDetails()
                    }
                    break
                case .error(_):
                    self.publishedProject?.userIdsNotInvited.append(users[i].id)
                    if i == users.count-1 {
                        self.presenter.presentPublishedProjectDetails()
                    }
                    break
                }
            }
        }
    }
    
    private func checkErrors(_ request: EditProjectDetails.Request.Publish) -> Bool {
        guard !request.title.isEmpty else {
            presenter.presentLocalError(EditProjectDetails.Info.Model.LocalError(description: EditProjectDetails.Info.Model.InputErrors.titleEmpty.rawValue))
            return true
        }
        guard !request.sinopsis.isEmpty else {
            presenter.presentLocalError(EditProjectDetails.Info.Model.LocalError(description: EditProjectDetails.Info.Model.InputErrors.sinopsisEmpty.rawValue))
            return true
        }
        return false
    }
    
    private func publishProject(_ request: EditProjectDetails.Request.Publish) {
        presenter.presentLoading(true)
        guard let project = publishingProject else { return }
        worker.fetchPublish(request: EditProjectDetails.Request.CompletePublish(project: project)) { response in
            switch response {
            case .success(let data):
                self.publishedProject = EditProjectDetails.Info.Model.PublishedProject(id: data.id ?? .empty,
                                                                                       title: data.title ?? .empty,
                                                                                       authorId: data.authorId ?? .empty,
                                                                                       image: data.image ?? .empty,
                                                                                       userIdsNotInvited: .empty)
                guard let project = self.publishedProject else { return }
                self.fetchInviteUsers(withProjectDate: project)
                break
            case .error(let error):
                self.presenter.presentLoading(false)
                self.presenter.presentServerError(EditProjectDetails.Info.Model.ServerError(error: error))
                break
            }
        }
    }
}

extension EditProjectDetailsInteractor: InviteListDelegate {
    
    func didSelectUser(_ user: InviteList.Info.Model.User) {
        invitedUsers?.users.append(EditProjectDetails.Info.Model.User(id: user.id,
                                                                      name: user.name,
                                                                      image: user.image,
                                                                      ocupation: user.ocupation))
    }
    
    func didUnselectUser(_ userId: String) {
        invitedUsers?.users.removeAll(where: {$0.id == userId})
    }
}

extension EditProjectDetailsInteractor: EditProjectDetailsBusinessLogic {
    
    func fetchInvitations(_ request: EditProjectDetails.Request.Invitations) {
        guard let users = invitedUsers else { return }
        presenter.presentInvitedUsers(users)
    }
    
    func fetchContext(_ request: EditProjectDetails.Request.FetchContext) {
        if routingContext?.context == .finished {
            presenter.presentFinishedProjectContextUI()
        }
    }
    
    func fetchSubmit(_ request: EditProjectDetails.Request.Publish) {
        guard !checkErrors(request) else { return }
        publishingProject = EditProjectDetails.Info.Model.PublishingProject(image: receivedData?.image,
                                                                  cathegories: receivedData?.cathegories ?? .empty,
                                                                  progress: Int((receivedData?.progress ?? 0) * 100),
                                                                  title: request.title,
                                                                  invitedUserIds: invitedUsers?.users.map({$0.id}) ?? .empty,
                                                                  sinopsis: request.sinopsis,
                                                                  needing: request.needing)
        switch routingContext?.context {
        case .ongoing:
            publishProject(request)
        case .finished:
            presenter.presentInsertVideo()
        case .none:
            break
        }
    }
}
