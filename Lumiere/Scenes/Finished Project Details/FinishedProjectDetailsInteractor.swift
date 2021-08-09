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
    func didSelectTeamMember(_ request: FinishedProjectDetails.Request.SelectTeamMember)
    func didTapInteractionButton(_ request: FinishedProjectDetails.Request.Interaction)
    func didAcceptInteraction(_ request: FinishedProjectDetails.Request.AcceptInteraction)
    func didRefuseInteraction(_ request: FinishedProjectDetails.Request.RefuseInteraction)
}

protocol FinishedProjectDetailsDataStore {
    var receivedData: FinishedProjectDetails.Info.Received.Project? { get set }
    var routingModel: FinishedProjectDetails.Info.Received.Routing? { get set }
    var projectData: FinishedProjectDetails.Info.Model.Project? { get }
    var projectRelation: FinishedProjectDetails.Info.Model.Relation? { get }
    var selectedTeamMember: String? { get }
}

class FinishedProjectDetailsInteractor: FinishedProjectDetailsDataStore {
    
    private let worker: FinishedProjectDetailsWorkerProtocol
    private let presenter: FinishedProjectDetailsPresentationLogic
    
    var receivedData: FinishedProjectDetails.Info.Received.Project?
    var routingModel: FinishedProjectDetails.Info.Received.Routing?
    var projectData: FinishedProjectDetails.Info.Model.Project?
    var projectRelation: FinishedProjectDetails.Info.Model.Relation?
    var selectedTeamMember: String?
    
    init(worker: FinishedProjectDetailsWorkerProtocol = FinishedProjectDetailsWorker(),
         presenter: FinishedProjectDetailsPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
    
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
                case .error:
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
    
    private func acceptProjectInvite(request: FinishedProjectDetails.Request.AcceptInvite) {
        worker.fetchAcceptProjectInvite(request) {
            response in
            self.presenter.presentLoading(false)
            switch response {
            case .success:
                self.presenter.presentRelationUI(FinishedProjectDetails.Info.Model.Relation(relation: .simpleParticipant))
                self.presenter.presentSuccessAlert(FinishedProjectDetails.Info.Model.Alert(title: FinishedProjectDetails.Constants.Texts.acceptProjectInviteTitle, description: FinishedProjectDetails.Constants.Texts.acceptProjectInviteDescription))
            case .error(let error):
                self.presenter.presentError(FinishedProjectDetails.Info.Model.Alert(title: WCConstants.Strings.errorTitle, description: error.description))
            }
        }
    }
    
    private func exitProject(request: FinishedProjectDetails.Request.ExitProject) {
        worker.exitProject(request) {
            response in
            self.presenter.presentLoading(false)
            switch response {
            case .success:
                self.presenter.presentRelationUI(FinishedProjectDetails.Info.Model.Relation(relation: .nothing))
                self.presenter.presentSuccessAlert(FinishedProjectDetails.Info.Model.Alert(title: FinishedProjectDetails.Constants.Texts.exitProjectTitle, description: .empty))
            case .error(let error):
                self.presenter.presentError(FinishedProjectDetails.Info.Model.Alert(title: WCConstants.Strings.errorTitle, description: error.description))
            }
        }
    }
    
    private func refuseProjectInvite(request: FinishedProjectDetails.Request.RefuseInvite) {
        worker.fetchRefuseProjectInvite(request) {
            response in
            self.presenter.presentLoading(false)
            switch response {
            case .success:
                self.presenter.presentSuccessAlert(FinishedProjectDetails.Info.Model.Alert(title: FinishedProjectDetails.Constants.Texts.refuseProjectInviteTitle, description: .empty))
            case .error(let error):
                self.presenter.presentError(FinishedProjectDetails.Info.Model.Alert(title: WCConstants.Strings.errorTitle, description: error.description))
            }
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
                self.presenter.presentLoading(false)
                self.presenter.presentError(FinishedProjectDetails.Info.Model.Alert(title: WCConstants.Strings.errorTitle, description: error.description))
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
                } else if relationResponse == "SIMPLE_PARTICIPANT" {
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
                self.presenter.presentLoading(false)
                self.presenter.presentError(FinishedProjectDetails.Info.Model.Alert(title: WCConstants.Strings.errorTitle, description: error.description))
            }
        }
    }
    
    func fetchNotinvitedUsers(_ request: FinishedProjectDetails.Request.FetchNotInvitedUsers) {
        if !(receivedData?.userIdsNotInvited.isEmpty ?? true) {
            presenter.presentError(FinishedProjectDetails.Info.Model.Alert(title: FinishedProjectDetails.Constants.Texts.notInvitedUsersErrorTitle, description: FinishedProjectDetails.Constants.Texts.notInvitedUsersErrorDescription))
        }
    }
    
    func didSelectTeamMember(_ request: FinishedProjectDetails.Request.SelectTeamMember) {
        selectedTeamMember = projectData?.participants[request.index].id
        presenter.presentProfileDetails()
    }
    
    func didTapInteractionButton(_ request: FinishedProjectDetails.Request.Interaction) {
        switch projectRelation?.relation {
        case .author:
            presenter.presentProjectInvites()
        case .receivedInvite, .simpleParticipant:
            guard let projectRelation = projectRelation else { return }
            presenter.presentInteractionConfirmationModal(forRelation: projectRelation)
        case .nothing, .none:
            break
        }
    }
    
    func didAcceptInteraction(_ request: FinishedProjectDetails.Request.AcceptInteraction) {
        switch projectRelation?.relation {
        case .author, .nothing, .none:
            break
        case .receivedInvite:
            presenter.presentLoading(true)
            acceptProjectInvite(request: FinishedProjectDetails.Request.AcceptInvite(projectId: receivedData?.id ?? .empty))
        case .simpleParticipant:
            presenter.presentLoading(true)
            exitProject(request: FinishedProjectDetails.Request.ExitProject(projectId: receivedData?.id ?? .empty))
        }
    }
    
    func didRefuseInteraction(_ request: FinishedProjectDetails.Request.RefuseInteraction) {
        switch projectRelation?.relation {
        case .author, .nothing, .none, .simpleParticipant:
            break
        case .receivedInvite:
            presenter.presentLoading(true)
            refuseProjectInvite(request: FinishedProjectDetails.Request.RefuseInvite(projectId: receivedData?.id ?? .empty))
        }
    }
}
