//
//  FinishedProjectDetailsInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 08/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import Foundation

protocol FinishedProjectDetailsBusinessLogic {
    func fetchRoutingModel(_ request: FinishedProjectDetails.Request.FetchRoutingModel)
    func fetchProjectData(_ request: FinishedProjectDetails.Request.FetchProjectData)
    func fetchProjectRelation(_ request: FinishedProjectDetails.Request.ProjectRelation)
    func fetchNotinvitedUsers(_ request: FinishedProjectDetails.Request.FetchNotInvitedUsers)
}

protocol FinishedProjectDetailsDataStore {
    var receivedData: FinishedProjectDetails.Info.Received.Project? { get set }
    var routingModel: FinishedProjectDetails.Info.Received.Routing? { get set }
    var projectData: FinishedProjectDetails.Info.Model.Project? { get }
    var projectRelation: FinishedProjectDetails.Info.Model.Relation? { get }
}

class FinishedProjectDetailsInteractor: FinishedProjectDetailsDataStore {
    
    private let worker: FinishedProjectDetailsWorkerProtocol
    private let presenter: FinishedProjectDetailsPresentationLogic
    
    var receivedData: FinishedProjectDetails.Info.Received.Project?
    var routingModel: FinishedProjectDetails.Info.Received.Routing?
    var projectData: FinishedProjectDetails.Info.Model.Project?
    var projectRelation: FinishedProjectDetails.Info.Model.Relation?
    
    init(worker: FinishedProjectDetailsWorkerProtocol = FinishedProjectDetailsWorker(),
         presenter: FinishedProjectDetailsPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
}

extension FinishedProjectDetailsInteractor {
    
    private func fetchParticipantsDetails(ids: [String]) {
        let dispatchGroup = DispatchGroup()
        var participants = [FinishedProjectDetails.Info.Model.TeamMember]()
        for id in ids {
            dispatchGroup.enter()
            worker.fetchTeamMemberData(FinishedProjectDetails.Request.FetchTeamMembersWithId(id: id)) { response in
                switch response {
                case .success(let data):
                    participants.append(FinishedProjectDetails.Info.Model.TeamMember(id: id, name: data.name ?? .empty, ocupation: data.ocupation ?? .empty, image: data.image ?? .empty))
                    dispatchGroup.leave()
                case .error(let error):
                    dispatchGroup.leave()
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
            self.presenter.presentLoading(false)
            self.projectData?.participants = participants
            guard let project = self.projectData else { return }
            self.presenter.presentProjectData(project)
        }
    }
}

extension FinishedProjectDetailsInteractor: FinishedProjectDetailsBusinessLogic {
    
    func fetchRoutingModel(_ request: FinishedProjectDetails.Request.FetchRoutingModel) {
        let response = FinishedProjectDetails.Info.Model.Routing(context: routingModel?.context ?? .checking, method: routingModel?.routingMethod ?? .push)
        presenter.presentRoutingUI(response)
    }

    func fetchProjectData(_ request: FinishedProjectDetails.Request.FetchProjectData) {
        presenter.presentLoading(true)
        worker.fetchProjectData(FinishedProjectDetails.Request.FetchProjectDataWithId(id: receivedData?.id ?? .empty)) { response in
            switch response {
            case .success(let data):
                self.projectData = FinishedProjectDetails
                    .Info
                    .Model
                    .Project(id: self.receivedData?.id ?? .empty,
                             image: data.image ?? .empty,
                             title: data.title ?? .empty,
                             sinopsis: data.sinopsis ?? .empty,
                             participants: .empty)
                self.fetchParticipantsDetails(ids: data.participants ?? .empty)
            case .error(let error):
                break
            }
        }
    }
    
    func fetchProjectRelation(_ request: FinishedProjectDetails.Request.ProjectRelation) {
        self.presenter.presentLoading(true)
        worker.fetchProjectRelation(FinishedProjectDetails.Request.ProjectRelationWithId(projectId: receivedData?.id ?? .empty)) { response in
            switch response {
            case .success(let data):
                self.presenter.presentLoading(false)
                var relation: FinishedProjectDetails.Info.Model.ProjectRelation
                guard let relationResponse = data.relation else { return }
                if relationResponse == "AUTHOR" {
                    relation = .author
                } else if relationResponse == "SIMPLE_PARTICIPATING" {
                    relation = .simpleParticipant
                } else if relationResponse == "PENDING" {
                    relation = .receivedInvite
                } else {
                    relation = .nothing
                }
                self.projectRelation = FinishedProjectDetails.Info.Model.Relation(relation: relation)
                guard let projectRelation = self.projectRelation else { return }
                self.presenter.presentRelationUI(projectRelation)
            case .error(let error):
                break
            }
        }
    }
    
    func fetchNotinvitedUsers(_ request: FinishedProjectDetails.Request.FetchNotInvitedUsers) {
        if !(receivedData?.userIdsNotInvited.isEmpty ?? true) {
            
        }
    }
}
