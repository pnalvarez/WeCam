//
//  InviteProfileToProjectsWorker.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 13/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol InviteProfileToProjectsWorkerProtocol {
    func fetchOngoingProjects(request: InviteProfileToProjects.Request.FetchProjects,
                       completion: @escaping (BaseResponse<[InviteProfileToProjects.Info.Response.OngoingProject]>) -> Void)
    func fetchUserOnGoingProjectRelation(request: InviteProfileToProjects.Request.FetchUserProjectRelation,
                                  completion: @escaping (BaseResponse<InviteProfileToProjects.Info.Response.ProjectRelation>) -> Void)
    func fetchUserFinishedProjectRelation(request: InviteProfileToProjects.Request.FetchUserProjectRelation,
                                  completion: @escaping (BaseResponse<InviteProfileToProjects.Info.Response.ProjectRelation>) -> Void)
    func fetchInviteUserToOngoingProject(request: InviteProfileToProjects.Request.InviteUserToOngoingProject,
                                  completion: @escaping (EmptyResponse) -> Void)
    func fetchInviteUserToFinishedProject(request: InviteProfileToProjects.Request.InviteUserToFinishedProject,
                                          completion: @escaping (EmptyResponse) -> Void)
    func fetchRemoveInviteToOngoingProject(request: InviteProfileToProjects.Request.RemoveInvite,
                           completion: @escaping (EmptyResponse) -> Void)
    func fetchRemoveInviteToFinishedProject(request: InviteProfileToProjects.Request.RemoveInvite,
                                            completion: @escaping (EmptyResponse) -> Void)
    func fetchRemoveUserFromOngoingProject(request: InviteProfileToProjects.Request.RemoveUser,
                                    completion: @escaping (EmptyResponse) -> Void)
    func fetchAcceptUserIntoOngoingProject(request: InviteProfileToProjects.Request.AcceptUser,
                                    completion: @escaping (EmptyResponse) -> Void)
    func fetchRefuseUserIntoOngoingProject(request: InviteProfileToProjects.Request.RefuseUser,
                                    completion: @escaping (EmptyResponse) -> Void)
}

class InviteProfileToProjectsWorker: InviteProfileToProjectsWorkerProtocol {
    
    private let builder: FirebaseManagerProtocol
    
    init(builder: FirebaseManagerProtocol = FirebaseManager()) {
        self.builder = builder
    }
    
    func fetchOngoingProjects(request: InviteProfileToProjects.Request.FetchProjects,
                       completion: @escaping (BaseResponse<[InviteProfileToProjects.Info.Response.OngoingProject]>) -> Void) {
        let headers: [String : Any] = .empty
        builder.fetchCurrentUserAuthoringProjects(request: headers,
                                                  completion: completion)
    }
    
    func fetchUserOnGoingProjectRelation(request: InviteProfileToProjects.Request.FetchUserProjectRelation,
                                  completion: @escaping (BaseResponse<InviteProfileToProjects.Info.Response.ProjectRelation>) -> Void) {
        let headers: [String : Any] = ["userId": request.userId, "projectId": request.projectId]
        builder.fetchUserRelationToOnGoingProject(request: headers, completion: completion)
    }
    
    func fetchUserFinishedProjectRelation(request: InviteProfileToProjects.Request.FetchUserProjectRelation,
                                          completion: @escaping (BaseResponse<InviteProfileToProjects.Info.Response.ProjectRelation>) -> Void) {
        let headers: [String : Any] = ["userId": request.userId, "projectId": request.projectId]
        builder.fetchUserRelationToFinishedProject(request: headers, completion: completion)
    }
    
    func fetchInviteUserToOngoingProject(request: InviteProfileToProjects.Request.InviteUserToOngoingProject,
                                  completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["userId": request.userId,
                                       "projectId": request.projectId,
                                       "project_title": request.projectTitle,
                                       "author_id": request.authorId,
                                       "image": request.projectImage]
        builder.inviteUserToProject(request: headers, completion: completion)
    }
    
    func fetchInviteUserToFinishedProject(request: InviteProfileToProjects.Request.InviteUserToFinishedProject,
                                          completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["userId": request.userId, "projectId": request.projectId]
        builder.inviteUserToFinishedProject(request: headers, completion: completion)
    }
    
    func fetchRemoveInviteToOngoingProject(request: InviteProfileToProjects.Request.RemoveInvite,
                           completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["userId": request.userId, "projectId": request.projectId]
        builder.removeProjectInviteToUser(request: headers, completion: completion)
    }
    
    func fetchRemoveInviteToFinishedProject(request: InviteProfileToProjects.Request.RemoveInvite,
                                            completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["userId": request.userId, "projectId": request.projectId]
        builder.removeInviteToFinishedProjectFromUser(request: headers,
                                                      completion: completion)
    }
    
    func fetchAcceptUserIntoOngoingProject(request: InviteProfileToProjects.Request.AcceptUser,
                                    completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["userId": request.userId, "projectId": request.projectId]
        builder.acceptUserIntoProject(request: headers, completion: completion)
    }
    
    func fetchRefuseUserIntoOngoingProject(request: InviteProfileToProjects.Request.RefuseUser,
                                    completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["userId": request.userId, "projectId": request.projectId]
        builder.refuseUserIntoProject(request: headers, completion: completion)
    }
    
    func fetchRemoveUserFromOngoingProject(request: InviteProfileToProjects.Request.RemoveUser,
                                    completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["userId": request.userId, "projectId": request.projectId]
        builder.removeUserFromProject(request: headers, completion: completion)
    }
}
