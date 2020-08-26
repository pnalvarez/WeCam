//
//  EditProjectDetailsInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 21/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol EditProjectDetailsBusinessLogic {
    func fetchInvitations(_ request: EditProjectDetails.Request.Invitations)
    func fetchPublish(_ request: EditProjectDetails.Request.Publish)
}

protocol EditProjectDetailsDataStore {
    var receivedData: EditProjectDetails.Info.Received.Project? { get set }
    var invitedUsers: EditProjectDetails.Info.Model.InvitedUsers? { get set }
    var publishingProject: EditProjectDetails.Info.Model.Project? { get set }
}

class EditProjectDetailsInteractor: EditProjectDetailsDataStore {
    
    private var worker: EditProjectDetailsWorkerProtocol
    var presenter: EditProjectDetailsPresentationLogic
    
    var receivedData: EditProjectDetails.Info.Received.Project?
    var invitedUsers: EditProjectDetails.Info.Model.InvitedUsers?
    var publishingProject: EditProjectDetails.Info.Model.Project?
    
    init(worker: EditProjectDetailsWorkerProtocol = EditProjectDetailsWorker(),
         viewController: EditProjectDetailsDisplayLogic) {
        self.worker = worker
        self.presenter = EditProjectDetailsPresenter(viewController: viewController)
        invitedUsers = EditProjectDetails.Info.Model.InvitedUsers(users: .empty)
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
    
    func fetchPublish(_ request: EditProjectDetails.Request.Publish) {
        presenter.presentLoading(true)
        publishingProject = EditProjectDetails.Info.Model.Project(image: receivedData?.image,
                                                                  cathegories: receivedData?.cathegories ?? .empty,
                                                                  progress: receivedData?.progress ?? 0,
                                                                  title: request.title,
                                                                  invitedUserIds: invitedUsers?.users.map({$0.id}) ?? .empty,
                                                                  sinopsis: request.sinopsis,
                                                                  needing: request.needing)
        guard let project = publishingProject else { return }
        worker.fetchPublish(request: EditProjectDetails.Request.CompletePublish(project: project)) { response in
            switch response {
            case .success:
                self.presenter.presentLoading(false)
                break
            case .error(let error):
                break
            }
        }
    }
}
