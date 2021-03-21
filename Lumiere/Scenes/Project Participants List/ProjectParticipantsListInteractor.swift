//
//  ProjectParticipantsInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 05/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol ProjectParticipantsListBusinessLogic {
    func fetchParticipants(_ request: ProjectParticipantsList.Request.FetchParticipants)
    func didSelectParticipant(_ request: ProjectParticipantsList.Request.SelectParticipant)
}

protocol ProjectParticipantsListDataStore {
    var project: ProjectParticipantsList.Info.Received.Project? { get set }
    var participantsModel: ProjectParticipantsList.Info.Model.UpcomingParticipants? { get set }
    var selectedParticipant: ProjectParticipantsList.Info.Model.Participant? { get set }
}

class ProjectParticipantsListInteractor: ProjectParticipantsListDataStore {
    
    private let worker: ProjectParticipantsListWorkerProtocol
    private let presenter: ProjectParticipantsListPresentationLogic
    
    var project: ProjectParticipantsList.Info.Received.Project?
    var participantsModel: ProjectParticipantsList.Info.Model.UpcomingParticipants?
    var selectedParticipant: ProjectParticipantsList.Info.Model.Participant?
    
    init(worker: ProjectParticipantsListWorkerProtocol = ProjectParticipantsListWorker(),
         presenter: ProjectParticipantsListPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
}

extension ProjectParticipantsListInteractor: ProjectParticipantsListBusinessLogic {
    
    func fetchParticipants(_ request: ProjectParticipantsList.Request.FetchParticipants) {
        presenter.presentLoading(true)
        worker.fetchParticipants(ProjectParticipantsList.Request.FetchParticipantsWithId(projectId: project?.projectId ?? .empty)) { response in
            switch response {
            case .success(let data):
                self.participantsModel = ProjectParticipantsList.Info.Model.UpcomingParticipants(participants: data.map({ ProjectParticipantsList
                    .Info
                    .Model
                    .Participant(id: $0.id ?? .empty,
                                 name: $0.name ?? .empty,
                                 ocupation: $0.ocupation ?? .empty,
                                 image: $0.image ?? .empty,
                                 email: $0.email ?? .empty)}))
                self.presenter.presentLoading(false)
                guard let participants = self.participantsModel else { return }
                self.presenter.presentParticipants(participants)
            case .error(let error):
                self.presenter.presentLoading(false)
                self.presenter.presentError(error.description)
            }
        }
    }
    
    func didSelectParticipant(_ request: ProjectParticipantsList.Request.SelectParticipant) {
        selectedParticipant = participantsModel?.participants[request.index]
        presenter.presentProfileDetails()
    }
}
