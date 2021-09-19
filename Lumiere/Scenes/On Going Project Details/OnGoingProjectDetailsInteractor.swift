//
//  OnGoingProjectDetailsInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 22/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol OnGoingProjectDetailsBusinessLogic {
    func fetchData(_ request: OnGoingProjectDetails.Request.FetchProject)
    func fetchContext(_ request: OnGoingProjectDetails.Request.FetchContext)
    func didSelectTeamMember(_ request: OnGoingProjectDetails.Request.SelectedTeamMember)
    func fetchUpdateProjectImage(_ request: OnGoingProjectDetails.Request.UpdateImage)
    func fetchUpdateProjectInfo(_ request: OnGoingProjectDetails.Request.UpdateInfo)
    func fetchUpdateProjectNeeding(_ request: OnGoingProjectDetails.Request.UpdateNeeding)
    func didCancelEditing(_ request: OnGoingProjectDetails.Request.CancelEditing)
    func fetchInteract(_ request: OnGoingProjectDetails.Request.FetchInteraction)
    func fetchConfirmInteraction(_ request: OnGoingProjectDetails.Request.ConfirmInteraction)
    func fetchRefuseInteraction(_ request: OnGoingProjectDetails.Request.RefuseInteraction)
    func fetchProgressPercentage(_ request: OnGoingProjectDetails.Request.FetchProgress)
    func fetchUpdateProgress(_ request: OnGoingProjectDetails.Request.UpdateProgress)
    func fetchConfirmNewProgress(_ request: OnGoingProjectDetails.Request.ConfirmProgress)
}

protocol OnGoingProjectDetailsDataStore {
    var receivedData: OnGoingProjectDetails.Info.Received.Project? { get set }
    var projectModel: OnGoingProjectDetails.Info.Model.ProjectData? { get }
    var selectedTeamMemberId: String? { get set }
    var routingContext: OnGoingProjectDetails.Info.Received.RoutingContext? { get set }
    var selectedProgress: OnGoingProjectDetails.Info.Model.SavedProgress? { get }
}

class OnGoingProjectDetailsInteractor: OnGoingProjectDetailsDataStore {
    
    private let worker: OnGoingProjectDetailsWorkerProtocol
    private let presenter: OnGoingProjectDetailsPresentationLogic
    
    var receivedData: OnGoingProjectDetails.Info.Received.Project?
    var projectModel: OnGoingProjectDetails.Info.Model.ProjectData?
    var selectedTeamMemberId: String?
    var routingContext: OnGoingProjectDetails.Info.Received.RoutingContext?
    var selectedProgress: OnGoingProjectDetails.Info.Model.SavedProgress?
    
    init(worker: OnGoingProjectDetailsWorkerProtocol = OnGoingProjectDetailsWorker(),
         presenter: OnGoingProjectDetailsPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
    
    private func fetchAcceptProjectInvite(_ request: OnGoingProjectDetails.Request.AcceptProjectInvite) {
        worker.fetchAcceptProjectInvite(request) { response in
            switch response {
            case .success:
                self.presenter.presentLoading(false)
                self.presenter.presentInteractionEffectivated()
                self.presenter.presentSuccessAlert(OnGoingProjectDetails
                    .Info
                    .Model
                    .Alert(title: OnGoingProjectDetails
                        .Constants
                        .Texts
                        .projectInviteAcceptedTitle,
                              message: OnGoingProjectDetails
                                .Constants
                                .Texts
                                .projectInviteAcceptedMessage))
            case .error(let error):
                self.presenter.presentLoading(false)
                self.presenter.presentAlertError(error.description)
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
                self.presenter.presentAlertError(error.description)
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
                self.presenter.presentAlertError(error.description)
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
                self.presenter.presentAlertError(error.description)
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
                self.presenter.presentAlertError(error.description)
            }
        }
    }
    
    private func fetchUpdateProgress(progress: Float) {
        presenter.presentLoading(true)
        worker.fetchUpdateProgress(OnGoingProjectDetails.Request.UpdateProgressToInteger(projectId: projectModel?.project.id ?? .empty, progress: Int(progress))) { response in
            self.presenter.presentLoading(false)
            switch response {
            case .success:
                self.projectModel?.project.progress = Int(progress)
                guard let projectModel = self.projectModel else { return }
                self.presenter.presentProjectProgressUpdateSuccessMessage()
                self.presenter.presentProject(projectModel)
                self.presenter.presentToastError("Oi")
            case .error(let error):
                self.presenter.presentToastError(error.description)
            }
        }
    }
    
    private func finishProject() {
        presenter.presentInsertMediaScreen()
    }
    
    private func fetchRelation(withProject project: OnGoingProjectDetails.Info.Model.Project) {
        guard let id = receivedData?.projectId else { return }
        worker.fetchProjectRelation(request: OnGoingProjectDetails.Request.ProjectRelationWithId(projectId: id)) { response in
            self.presenter.presentLoading(false)
            switch response {
            case .success(let data):
                var projectRelation: OnGoingProjectDetails.Info.Model.ProjectRelation
                guard let relation = data.relation else {
                    return
                }
                if relation == "AUTHOR" {
                    projectRelation = .author
                } else if relation == "PARTICIPATING" {
                    projectRelation = .simpleParticipating
                } else if relation == "PENDING" {
                    projectRelation = .sentRequest
                } else if relation == "INVITED" {
                    projectRelation = .receivedRequest
                } else {
                    projectRelation = .nothing
                }
                self.projectModel = OnGoingProjectDetails.Info.Model.ProjectData(project: project, relation: OnGoingProjectDetails.Info.Model.RelationModel(relation: projectRelation))
                guard let projectModel = self.projectModel else { return }
                self.presenter.presentProject(projectModel)
            case .error(let error):
                self.presenter.presentAlertError(error.description)
            }
        }
    }
}

extension OnGoingProjectDetailsInteractor: OnGoingProjectDetailsBusinessLogic {
    
    func fetchData(_ request: OnGoingProjectDetails.Request.FetchProject) {
        guard let projedtId = receivedData?.projectId else { return }
        presenter.presentLoading(true)
        worker.fetchProjectDetails(request: OnGoingProjectDetails
            .Request
            .FetchProjectWithId(id: projedtId)) { response in
                switch response {
                case .success(let data):
                    let project = OnGoingProjectDetails
                        .Info
                        .Model
                        .Project(id: projedtId,
                                 firstCathegory: data.cathegories?.first ?? .empty,
                                 secondCathegory: data.cathegories?.count ?? 0 > 1 ? data.cathegories?.last : nil,
                                 image: data.image,
                                 progress: data.progress ?? 0,
                                 title: data.title ?? .empty,
                                 sinopsis: data.sinopsis ?? .empty,
                                 teamMembers: .empty,
                                 needing: data.needing ?? .empty)
                    self.fetchRelation(withProject: project)
                case .error(let error):
                    self.presenter.presentLoading(false)
                    self.presenter.presentAlertError(error.description)
                }
        }
    }
    
    func fetchContext(_ request: OnGoingProjectDetails.Request.FetchContext) {
        if let context = routingContext?.context {
            presenter.presentRoutingContextUI(context)
        }
    }
    
    func didSelectTeamMember(_ request: OnGoingProjectDetails.Request.SelectedTeamMember) {
        guard let teamMemberId = projectModel?.project.teamMembers[request.index].id else { return }
        selectedTeamMemberId = teamMemberId
        presenter.presentUserDetails()
    }

    func fetchUpdateProjectImage(_ request: OnGoingProjectDetails.Request.UpdateImage) {
        self.presenter.presentLoading(true)
        worker.fetchUpdateProjectImage(request: OnGoingProjectDetails
            .Request
                                        .UpdateImageWithId(projectId: projectModel?.project.id ?? .empty, image: request.image)) { response in
                switch response {
                case .success(let data):
                    self.presenter.presentLoading(false)
                    self.projectModel?.project.image = data.imageURL
                    guard let projectModel = self.projectModel else { return }
                    self.presenter.presentProject(projectModel)
                    self.presenter.presentSuccessAlert(OnGoingProjectDetails.Info.Model.Alert(title: "Alteração realizada", message: "Imagem do projeto foi alterada com sucesso"))
                case .error(let error):
                    self.presenter.presentLoading(false)
                    self.presenter.presentToastError(error.description)
                }
        }
    }
    
    func fetchUpdateProjectInfo(_ request: OnGoingProjectDetails.Request.UpdateInfo) {
        self.presenter.presentLoading(true)
        worker.fetchUpdateProjectInfo(request: OnGoingProjectDetails
            .Request
                                        .UpdateInfoWithId(projectId: self.projectModel?.project.id ?? .empty,
                              title: request.title,
                              sinopsis: request.sinopsis)) { response in
                                switch response {
                                case .success:
                                    self.presenter.presentLoading(false)
                                    self.projectModel?.project.title = request.title
                                    self.projectModel?.project.sinopsis = request.sinopsis
                                    guard let projectModel = self.projectModel else { return }
                                    self.presenter.presentProject(projectModel)
                                    self.presenter.presentSuccessAlert(OnGoingProjectDetails.Info.Model.Alert(title: "Alteração realizada", message: "O título e a sinopse do projeto foram alterados com sucesso"))
                                case .error(let error):
                                    self.presenter.presentLoading(false)
                                    self.presenter.presentToastError(error.description)
                                }
                                                                                               
        }
    }
    
    func fetchUpdateProjectNeeding(_ request: OnGoingProjectDetails.Request.UpdateNeeding) {
        presenter.presentLoading(true)
        worker.fetchUpdateProjectNeeding(request: OnGoingProjectDetails
            .Request
                                            .UpdateNeedingWithId(projectId: projectModel?.project.id ?? .empty,
                                 needing: request.needing)) { response in
                                    switch response {
                                    case .success:
                                        self.presenter.presentLoading(false)
                                        self.projectModel?.project.needing = request.needing
                                        guard let projectModel = self.projectModel else { return }
                                        self.presenter.presentProject(projectModel)
                                        self.presenter.presentSuccessAlert(OnGoingProjectDetails.Info.Model.Alert(title: "Alteração realizada", message: "Alteração do que o projeto precisa foi realizada com sucesso"))
                                    case .error(let error):
                                        self.presenter.presentLoading(false)
                                        self.presenter.presentToastError(error.description)
                                    }
        }
    }
    
    func didCancelEditing(_ request: OnGoingProjectDetails.Request.CancelEditing) {
        guard let projectModel = self.projectModel else { return }
        presenter.presentProject(projectModel)
    }
    
    func fetchInteract(_ request: OnGoingProjectDetails.Request.FetchInteraction) {
        presenter.presentConfirmationModal(forRelation: OnGoingProjectDetails.Info.Model.RelationModel(relation: projectModel?.relation.relation ?? .nothing))
    }
    
    func fetchConfirmInteraction(_ request: OnGoingProjectDetails.Request.ConfirmInteraction) {
        presenter.presentLoading(true)
        guard let relation = projectModel?.relation.relation else { return }
        switch relation {
        case .author:
            finishProject()
        case .simpleParticipating:
            fetchExitProject(OnGoingProjectDetails
                .Request
                                .ExitProject(projectId: projectModel?.project.id ?? .empty))
        case .sentRequest:
            fetchRemoveProjectParticipationRequest(OnGoingProjectDetails
                .Request
                                                    .RemoveProjectParticipationRequest(projectId: projectModel?.project.id ?? .empty))
        case .receivedRequest:
            fetchAcceptProjectInvite(OnGoingProjectDetails
                .Request
                                        .AcceptProjectInvite(projectId: projectModel?.project.id ?? .empty))
        case .nothing:
            fetchSendProjectParticipationRequest(OnGoingProjectDetails.Request.ProjectParticipationRequest(projectId: projectModel?.project.id ?? .empty))
        }
    }
    
    func fetchRefuseInteraction(_ request: OnGoingProjectDetails.Request.RefuseInteraction) {
        presenter.presentLoading(true)
        guard let relation = projectModel?.relation.relation else { return }
        switch relation {
        case .author, .simpleParticipating, .sentRequest, .nothing:
            presenter.presentLoading(false)
        case .receivedRequest:
            fetchRefuseProjectInvite(OnGoingProjectDetails
                .Request
                                        .RefuseProjectInvite(projectId: projectModel?.project.id ?? .empty))
        }
    }
    
    func fetchProgressPercentage(_ request: OnGoingProjectDetails.Request.FetchProgress) {
        guard let percentage = projectModel?.project.progress else { return }
        let progressModel = OnGoingProjectDetails.Info.Model.Progress(percentage: percentage)
        presenter.presentEditProgressModal(withProgress: progressModel)
    }
    
    func fetchUpdateProgress(_ request: OnGoingProjectDetails.Request.UpdateProgress) {
        selectedProgress = OnGoingProjectDetails.Info.Model.SavedProgress(progress: request.newProgress)
        request.newProgress > OnGoingProjectDetails.Constants.BusinessLogic.finishedProjectBottomRange ? presenter.presentConfirmFinishedProjectAlert() : fetchUpdateProgress(progress: request.newProgress * WCConstants.Floats.hundredPercent)
    }
    
    func fetchConfirmNewProgress(_ request: OnGoingProjectDetails.Request.ConfirmProgress) {
        guard let progress = selectedProgress?.progress else { return }
        fetchUpdateProgress(progress: Float(progress))
    }
}
