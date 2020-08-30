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
    func fetchProjectRelation(_ request: OnGoingProjectDetails.Request.ProjectRelation)
    func fetchUpdateProjectImage(_ request: OnGoingProjectDetails.Request.UpdateImage)
    func fetchUpdateProjectInfo(_ request: OnGoingProjectDetails.Request.UpdateInfo)
    func fetchUpdateProjectNeeding(_ request: OnGoingProjectDetails.Request.UpdateNeeding)
}

protocol OnGoingProjectDetailsDataStore {
    var receivedData: OnGoingProjectDetails.Info.Received.Project? { get set }
    var projectData: OnGoingProjectDetails.Info.Model.Project? { get set }
    var projectRelation: OnGoingProjectDetails.Info.Model.ProjectRelation? { get set }
}

class OnGoingProjectDetailsInteractor: OnGoingProjectDetailsDataStore {
    
    private let worker: OnGoingProjectDetailsWorkerProtocol
    var presenter: OnGoingProjectDetailsPresentationLogic
    
    var receivedData: OnGoingProjectDetails.Info.Received.Project?
    var projectData: OnGoingProjectDetails.Info.Model.Project?
    var projectRelation: OnGoingProjectDetails.Info.Model.ProjectRelation?
    
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
        guard let projedtId = receivedData?.projectId,
            let uninvitedUsers = receivedData?.notInvitedUsers else { return }
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
                    guard let teamMemberIds = data.participants,
                        let projectData = self.projectData else { return }
                    guard teamMemberIds.count > 0 else {
                        self.presenter.presentLoading(false)
                        self.presenter.presentProjectDetails(projectData)
                        return
                    }
                    if uninvitedUsers.count > 0 {
                        self.presenter.presentError(OnGoingProjectDetails.Constants.Texts.inviteError)
                    }
                    for id in teamMemberIds {
                        self.fetchUserDetails(OnGoingProjectDetails.Request.FetchUserWithId(id: id))
                    }
                case .error(let error):
                    break
                }
        }
    }
    
    func didSelectTeamMember(_ request: OnGoingProjectDetails.Request.SelectedTeamMember) {
        
    }
    
    func fetchProjectRelation(_ request: OnGoingProjectDetails.Request.ProjectRelation) {
        presenter.presentLoading(true)
        guard let id = receivedData?.projectId else { return }
        worker.fetchProjectRelation(request: OnGoingProjectDetails.Request.ProjectRelationWithId(projectId: id)) { response in
            switch response {
            case .success(let data):
                guard let relation = data.relation else {
                    return
                }
                if relation == "AUTHOR" {
                    self.projectRelation = .author
                } else if relation == "PARTICIPATING" {
                    self.projectRelation = .simpleParticipating
                } else if relation == "PENDING" {
                    self.projectRelation = .sentRequest
                } else if relation == "INVITED" {
                    self.projectRelation = .receivedRequest
                } else {
                    self.projectRelation = .nothing
                }
                self.presenter.presentProjectRelationUI(OnGoingProjectDetails
                    .Info
                    .Model
                    .RelationModel(relation: self.projectRelation ?? .nothing))
            case .error(_):
                break
            }
        }
    }
    
    func fetchUpdateProjectImage(_ request: OnGoingProjectDetails.Request.UpdateImage) {
        self.presenter.presentLoading(true)
        worker.fetchUpdateProjectImage(request: OnGoingProjectDetails
            .Request
            .UpdateImageWithId(projectId: projectData?.id ?? .empty, image: request.image)) { response in
                switch response {
                case .success(let data):
                    self.presenter.presentLoading(false)
                    self.projectData?.image = data.imageURL
                    guard let project = self.projectData else { return }
                    self.presenter.presentProjectDetails(project)
                case .error(let error):
                    self.presenter.presentLoading(false)
                    self.presenter.presentError(error.localizedDescription)
                }
        }
    }
    
    func fetchUpdateProjectInfo(_ request: OnGoingProjectDetails.Request.UpdateInfo) {
        
    }
    
    func fetchUpdateProjectNeeding(_ request: OnGoingProjectDetails.Request.UpdateNeeding) {
        
    }
}
