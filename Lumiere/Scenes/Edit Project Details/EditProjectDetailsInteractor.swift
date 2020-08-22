//
//  EditProjectDetailsInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 21/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol EditProjectDetailsBusinessLogic {
    func didTapInviteButton(_ request: EditProjectDetails.Request.Invite)
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
    }
}

extension EditProjectDetailsInteractor: EditProjectDetailsBusinessLogic {
    
    func didTapInviteButton(_ request: EditProjectDetails.Request.Invite) {
        presenter.presentInviteList()
    }
    
    func fetchPublish(_ request: EditProjectDetails.Request.Publish) {
        presenter.presentLoading(true)
        guard let project = publishingProject else { return }
        worker.fetchPublish(request: EditProjectDetails.Request.CompletePublish(project: project)) { response in
            switch response {
            case .success:
                break
            case .error(let error):
                break
            }
        }
    }
}
