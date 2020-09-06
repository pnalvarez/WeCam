//
//  OnGoingProjectDetailsWorker.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 22/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol OnGoingProjectDetailsWorkerProtocol {
    func fetchProjectDetails(request: OnGoingProjectDetails.Request.FetchProjectWithId,
                             completion: @escaping (BaseResponse<OnGoingProjectDetails.Info.Response.Project>) -> Void)
    func fetchteamMemberData(request: OnGoingProjectDetails.Request.FetchUserWithId,
                             completion: @escaping (BaseResponse<OnGoingProjectDetails.Info.Response.TeamMember>) -> Void)
    func fetchProjectRelation(request: OnGoingProjectDetails.Request.ProjectRelationWithId,
                              completion: @escaping (BaseResponse<OnGoingProjectDetails.Info.Response.ProjectRelation>) -> Void)
    func fetchUpdateProjectInfo(request: OnGoingProjectDetails.Request.UpdateInfoWithId,
                                completion: @escaping (EmptyResponse) -> Void)
    func fetchUpdateProjectImage(request: OnGoingProjectDetails.Request.UpdateImageWithId,
                                 completion: @escaping (BaseResponse<OnGoingProjectDetails.Info.Response.ProjectImage>) -> Void)
    func fetchUpdateProjectNeeding(request: OnGoingProjectDetails.Request.UpdateNeedingWithId,
                                   completion: @escaping (EmptyResponse) -> Void)
    func fetchAcceptProjectInvite(_ request: OnGoingProjectDetails.Request.AcceptProjectInvite,
                                  completion: @escaping (EmptyResponse) -> Void)
    func fetchRefuseProjectInvite(_ request: OnGoingProjectDetails.Request.RefuseProjectInvite,
                                  completion: @escaping (EmptyResponse) -> Void)
    func fetchSendProjectParticipationRequest(_ request:     OnGoingProjectDetails.Request.ProjectParticipationRequest,
                                              completion: @escaping (EmptyResponse) -> Void)
    func fetchRemoveParticipantRequest(_ request: OnGoingProjectDetails.Request.RemoveProjectParticipationRequest,
                                       completion: @escaping (EmptyResponse) -> Void)
}

class OnGoingProjectDetailsWorker: OnGoingProjectDetailsWorkerProtocol {
    
    private let builder: FirebaseAuthHelperProtocol
    
    init(builder: FirebaseAuthHelperProtocol = FirebaseAuthHelper()) {
        self.builder = builder
    }
    
    func fetchProjectDetails(request: OnGoingProjectDetails.Request.FetchProjectWithId,
                             completion: @escaping (BaseResponse<OnGoingProjectDetails.Info.Response.Project>) -> Void) {
        let headers: [String : Any] = ["projectId" : request.id]
        builder.fetchProjectWorking(request: headers, completion: completion)
    }
    
    func fetchteamMemberData(request: OnGoingProjectDetails.Request.FetchUserWithId,
                             completion: @escaping (BaseResponse<OnGoingProjectDetails.Info.Response.TeamMember>) -> Void) {
        let headers: [String : Any] = ["userId" : request.id]
        builder.fetchUserData(request: headers, completion: completion)
    }
    
    func fetchProjectRelation(request: OnGoingProjectDetails.Request.ProjectRelationWithId,
                              completion: @escaping (BaseResponse<OnGoingProjectDetails.Info.Response.ProjectRelation>) -> Void) {
        let headers: [String : Any] = ["projectId" : request.projectId]
        builder.fetchProjectRelation(request: headers, completion: completion)
    }
    
    func fetchUpdateProjectInfo(request: OnGoingProjectDetails.Request.UpdateInfoWithId,
                                completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["projectId": request.projectId,
                                       "title": request.title,
                                       "sinopsis": request.sinopsis]
        builder.updateProjectInfo(request: headers, completion: completion)
    }
    
    func fetchUpdateProjectImage(request: OnGoingProjectDetails.Request.UpdateImageWithId,
                                 completion: @escaping (BaseResponse<OnGoingProjectDetails.Info.Response.ProjectImage>) -> Void) {
        let headers: [String : Any] = ["projectId": request.projectId, "image": request.image]
        builder.updateProjectImage(request: headers, completion: completion)
    }
    
    func fetchUpdateProjectNeeding(request: OnGoingProjectDetails.Request.UpdateNeedingWithId,
                                   completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["projectId": request.projectId, "needing": request.needing]
        builder.updateProjectNeedingField(request: headers, completion: completion)
    }
    
    func fetchAcceptProjectInvite(_ request: OnGoingProjectDetails.Request.AcceptProjectInvite,
                                  completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["projectId": request.projectId]
        builder.acceptProjectInvite(request: headers, completion: completion)
    }
    
    func fetchRefuseProjectInvite(_ request: OnGoingProjectDetails.Request.RefuseProjectInvite,
                                  completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["projectId": request.projectId]
        builder.refuseProjectInvite(request: headers, completion: completion)
    }
    
    func fetchSendProjectParticipationRequest(_ request: OnGoingProjectDetails.Request.ProjectParticipationRequest,
                                              completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["projectId": request.projectId]
        builder.sendProjectParticipationRequest(request: headers, completion: completion)
    }
    
    func fetchRemoveParticipantRequest(_ request: OnGoingProjectDetails.Request.RemoveProjectParticipationRequest,
                                       completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["projectId": request.projectId]
        builder.removeProjectParticipationRequest(request: headers, completion: completion)
    }
}
