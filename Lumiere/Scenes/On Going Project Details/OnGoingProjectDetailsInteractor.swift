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
    func didCancelEditing(_ request: OnGoingProjectDetails.Request.CancelEditing)
    func fetchInteract(_ request: OnGoingProjectDetails.Request.FetchInteraction)
    func fetchConfirmInteraction(_ request: OnGoingProjectDetails.Request.ConfirmInteraction)
    func fetchRefuseInteraction(_ request: OnGoingProjectDetails.Request.RefuseInteraction)
}

protocol OnGoingProjectDetailsDataStore {
    var receivedData: OnGoingProjectDetails.Info.Received.Project? { get set }
    var projectData: OnGoingProjectDetails.Info.Model.Project? { get set }
    var projectRelation: OnGoingProjectDetails.Info.Model.ProjectRelation? { get set }
    var selectedTeamMeberId: String? { get set }
}

class OnGoingProjectDetailsInteractor: OnGoingProjectDetailsDataStore {
    
    private let worker: OnGoingProjectDetailsWorkerProtocol
    private let presenter: OnGoingProjectDetailsPresentationLogic
    
    var receivedData: OnGoingProjectDetails.Info.Received.Project?
    var projectData: OnGoingProjectDetails.Info.Model.Project?
    var projectRelation: OnGoingProjectDetails.Info.Model.ProjectRelation?
    var selectedTeamMeberId: String?
    
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
    
    private func fetchAcceptProjectInvite(_ request: OnGoingProjectDetails.Request.AcceptProjectInvite) {
        worker.fetchAcceptProjectInvite(request) { response in
            switch response {
            case .success:
                self.presenter.presentLoading(false)
                self.presenter.presentInteractionEffectivated()
                self.presenter.presentFeedback(OnGoingProjectDetails
                    .Info
                    .Model
                    .Feedback(title: OnGoingProjectDetails
                        .Constants
                        .Texts
                        .projectInviteAcceptedTitle,
                              message: OnGoingProjectDetails
                                .Constants
                                .Texts
                                .projectInviteAcceptedMessage))
            case .error(let error):
                self.presenter.presentLoading(false)
                self.presenter.presentFeedback(OnGoingProjectDetails
                .Info
                .Model
                .Feedback(title: "Erro",
                          message: error.localizedDescription))
            }
        }
    }
    
    private func fetchRefuseProjectInvite(_ request: OnGoingProjectDetails.Request.RefuseProjectInvite) {
        worker.fetchRefuseProjectInvite(request) { response in
            switch response {
            case .success:
                self.presenter.presentLoading(false)
                self.presenter.presentInteractionEffectivated()
            case .error(let error):
                self.presenter.presentLoading(false)
                self.presenter.presentFeedback(OnGoingProjectDetails
                              .Info
                              .Model
                              .Feedback(title: "Erro",
                                        message: error.localizedDescription))
            }
        }
    }
    
    private func fetchSendProjectParticipationRequest(_ request: OnGoingProjectDetails.Request.ProjectParticipationRequest) {
        worker.fetchSendProjectParticipationRequest(request) { response in
            switch response {
            case .success:
                self.presenter.presentLoading(false)
                self.presenter.presentInteractionEffectivated()
            case .error(let error):
                self.presenter.presentLoading(false)
                self.presenter.presentFeedback(OnGoingProjectDetails.Info.Model.Feedback(title: "Erro",
                                                                                         message: error.localizedDescription))
            }
        }
    }
    
    private func fetchRemoveProjectParticipationRequest(_ request: OnGoingProjectDetails.Request.RemoveProjectParticipationRequest) {
        worker.fetchRemoveParticipantRequest(request) { response in
            switch response {
            case .success:
                self.presenter.presentLoading(false)
                self.presenter.presentInteractionEffectivated()
            case .error(let error):
                self.presenter.presentLoading(false)
                self.presenter.presentFeedback(OnGoingProjectDetails.Info.Model.Feedback(title: "Erro",
                                                                                         message: error.localizedDescription))
            }
        }
    }
    
    private func fetchExitProject(_ request: OnGoingProjectDetails.Request.ExitProject) {
        worker.fetchExitProject(request) { response in
            switch response {
            case .success:
                self.presenter.presentLoading(false)
                self.presenter.presentInteractionEffectivated()
            case .error(let error):
                self.presenter.presentLoading(false)
                self.presenter.presentFeedback(OnGoingProjectDetails
                    .Info
                    .Model
                    .Feedback(title: "Erro",
                message: error.localizedDescription))
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
                    self.projectData = OnGoingProjectDetails
                        .Info
                        .Model
                        .Project(id: projedtId,
                                 firstCathegory: data.cathegories?[0] ?? .empty,
                                 secondCathegory: data.cathegories?.count ?? 0 > 1 ? (data.cathegories?[1] ?? .empty) : nil,
                                 image: data.image,
                                 progress: data.progress ?? 0,
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
        guard let teamMemberId = projectData?.teamMembers[request.index].id else { return }
        selectedTeamMeberId = teamMemberId
        presenter.presentUserDetails()
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
                    self.presenter.presentFeedback(OnGoingProjectDetails.Info.Model.Feedback(title: "Alteração realizada", message: "Imagem do projeto foi alterada com sucesso"))
                case .error(let error):
                    self.presenter.presentLoading(false)
                    self.presenter.presentError(error.localizedDescription)
                }
        }
    }
    
    func fetchUpdateProjectInfo(_ request: OnGoingProjectDetails.Request.UpdateInfo) {
        self.presenter.presentLoading(true)
        worker.fetchUpdateProjectInfo(request: OnGoingProjectDetails
            .Request
            .UpdateInfoWithId(projectId: self.projectData?.id ?? .empty,
                              title: request.title,
                              sinopsis: request.sinopsis)) { response in
                                switch response {
                                case .success:
                                    self.presenter.presentLoading(false)
                                    self.projectData?.title = request.title
                                    self.projectData?.sinopsis = request.sinopsis
                                    guard let project = self.projectData else { return }
                                    self.presenter.presentProjectDetails(project)
                                    self.presenter.presentFeedback(OnGoingProjectDetails.Info.Model.Feedback(title: "Alteração realizada", message: "O título e a sinopse do projeto foram alterados com sucesso"))
                                case .error(let error):
                                    self.presenter.presentLoading(false)
                                    self.presenter.presentError(error.localizedDescription)
                                    guard let project = self.projectData else { return }
                                    self.presenter.presentProjectDetails(project)
                                }
                                                                                               
        }
    }
    
    func fetchUpdateProjectNeeding(_ request: OnGoingProjectDetails.Request.UpdateNeeding) {
        presenter.presentLoading(true)
        worker.fetchUpdateProjectNeeding(request: OnGoingProjectDetails
            .Request
            .UpdateNeedingWithId(projectId: projectData?.id ?? .empty,
                                 needing: request.needing)) { response in
                                    switch response {
                                    case .success:
                                        self.presenter.presentLoading(false)
                                        self.projectData?.needing = request.needing
                                        guard let project = self.projectData else { return }
                                        self.presenter.presentProjectDetails(project)
                                        self.presenter.presentFeedback(OnGoingProjectDetails.Info.Model.Feedback(title: "Alteração realizada", message: "Alteração do que o projeto precisa foi realizada com sucesso"))
                                    case .error(let error):
                                        self.presenter.presentLoading(false)
                                        self.presenter.presentError(error.localizedDescription)
                                    }
        }
    }
    
    func didCancelEditing(_ request: OnGoingProjectDetails.Request.CancelEditing) {
        guard let project = self.projectData else { return }
        presenter.presentProjectDetails(project)
    }
    
    func fetchInteract(_ request: OnGoingProjectDetails.Request.FetchInteraction) {
        presenter.presentConfirmationModal(forRelation: OnGoingProjectDetails.Info.Model.RelationModel(relation: projectRelation ?? .nothing))
    }
    
    func fetchConfirmInteraction(_ request: OnGoingProjectDetails.Request.ConfirmInteraction) {
        presenter.presentLoading(true)
        guard let relation = projectRelation else { return }
        switch relation {
        case .author:
            break
        case .simpleParticipating:
            fetchExitProject(OnGoingProjectDetails
                .Request
                .ExitProject(projectId: projectData?.id ?? .empty))
        case .sentRequest:
            fetchRemoveProjectParticipationRequest(OnGoingProjectDetails
                .Request
                .RemoveProjectParticipationRequest(projectId: projectData?.id ?? .empty))
        case .receivedRequest:
            fetchAcceptProjectInvite(OnGoingProjectDetails
                .Request
                .AcceptProjectInvite(projectId: projectData?.id ?? .empty))
        case .nothing:
            fetchSendProjectParticipationRequest(OnGoingProjectDetails.Request.ProjectParticipationRequest(projectId: projectData?.id ?? .empty))
        }
    }
    
    func fetchRefuseInteraction(_ request: OnGoingProjectDetails.Request.RefuseInteraction) {
        presenter.presentLoading(true)
        guard let relation = projectRelation else { return }
        switch relation {
        case .author:
            presenter.presentLoading(false)
            presenter.presentRefusedInteraction()
        case .simpleParticipating:
            presenter.presentLoading(false)
            presenter.presentRefusedInteraction()
        case .sentRequest:
            presenter.presentLoading(false)
            presenter.presentRefusedInteraction()
        case .receivedRequest:
            fetchRefuseProjectInvite(OnGoingProjectDetails
                .Request
                .RefuseProjectInvite(projectId: projectData?.id ?? .empty))
        case .nothing:
            presenter.presentLoading(false)
            presenter.presentRefusedInteraction()
        }
    }
}
