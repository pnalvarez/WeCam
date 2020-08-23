//
//  OnGoingProjectDetailsInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 22/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol OnGoingProjectDetailsBusinessLogic {
    func fetchProjectDetails(_ request: OnGoingProjectDetails.Request.FetchProject)
    func didSelectTeamMember(_ request: OnGoingProjectDetails.Request.SelectedTeamMember)
}

protocol OnGoingProjectDetailsDataStore {
    var receivedData: OnGoingProjectDetails.Info.Received.Project? { get set }
    var projectData: OnGoingProjectDetails.Info.Model.Project? { get set }
}

class OnGoingProjectDetailsInteractor: OnGoingProjectDetailsDataStore {
    
    private let worker: OnGoingProjectDetailsWorkerProtocol
    var presenter: OnGoingProjectDetailsPresentationLogic
    
    var receivedData: OnGoingProjectDetails.Info.Received.Project?
    var projectData: OnGoingProjectDetails.Info.Model.Project?
    
    init(worker: OnGoingProjectDetailsWorkerProtocol = OnGoingProjectDetailsWorker(),
         viewController: OnGoingProjectDetailsDisplayLogic) {
        self.worker = worker
        self.presenter = OnGoingProjectDetailsPresenter(viewController: viewController)
    }
}

extension OnGoingProjectDetailsInteractor {
    
    private func fetchUserDetails(_ request: OnGoingProjectDetails.Request.FetchUserWithId) {
        worker.fetchteamMemberData(request: request) { response in
            switch response {
            case .success(let data):
                self.projectData?.teamMembers.append(OnGoingProjectDetails.Info.Model.TeamMember(id: request.id,
                                                                                                 name: data.name ?? .empty,
                                                                                                 ocupation: data.ocupation ?? .empty,
                                                                                                 image: data.image ?? .empty))
                guard let project = self.projectData else { return }
                self.presenter.presentLoading(false)
                self.presenter.presentProjectDetails(project)
                break
            case .error(let error):
                break
            }
        }
    }
}

extension OnGoingProjectDetailsInteractor: OnGoingProjectDetailsBusinessLogic {
    
    func fetchProjectDetails(_ request: OnGoingProjectDetails.Request.FetchProject) {
        presenter.presentLoading(true)
        guard let projedtId = receivedData?.projectId else { return }
        worker.fetchProjectDetails(request: OnGoingProjectDetails
            .Request
            .FetchProjectWithId(id: projedtId)) { response in
                switch response {
                case .success(let data):
                    self.projectData = OnGoingProjectDetails.Info.Model.Project(id: projedtId,
                                                                                image: data.image,
                                                                                title: data.title ?? .empty,
                                                                                sinopsis: data.sinopsis ?? .empty,
                                                                                teamMembers: .empty,
                                                                                needing: data.needing ?? .empty)
                    guard let teamMemberIds = data.participants else { return }
                    for id in teamMemberIds {
                        self.fetchUserDetails(OnGoingProjectDetails.Request.FetchUserWithId(id: id))
                    }
                    break
                case .error(let error):
                    break
                }
        }
    }
    
    func didSelectTeamMember(_ request: OnGoingProjectDetails.Request.SelectedTeamMember) {
        
    }
}
