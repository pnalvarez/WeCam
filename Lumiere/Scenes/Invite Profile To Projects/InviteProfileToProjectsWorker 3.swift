//
//  InviteProfileToProjectsWorker.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 13/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol InviteProfileToProjectsWorkerProtocol {
    func fetchProjects(request: InviteProfileToProjects.Request.FetchProjects,
                       completion: @escaping (BaseResponse<[InviteProfileToProjects.Info.Response.Project]>) -> Void)
    func fetchUserProjectRelation(request: InviteProfileToProjects.Request.FetchUserProjectRelation,
                                  completion: @escaping (BaseResponse<InviteProfileToProjects.Info.Response.ProjectRelation>) -> Void)
    func fetchInviteUserToProject(request: InviteProfileToProjects.Request.InviteUser,
                                  completion: @escaping (EmptyResponse) -> Void)
    func fetchRemoveInvite(request: InviteProfileToProjects.Request.RemoveInvite,
                           completion: @escaping (EmptyResponse) -> Void)
    func fetchRemoveUserFromProject(request: InviteProfileToProjects.Request.RemoveUser,
                                    completion: @escaping (EmptyResponse) -> Void)
    func fetchAcceptUserIntoProject(request: InviteProfileToProjects.Request.AcceptUser,
                                    completion: @escaping (EmptyResponse) -> Void)
    func fetchRefuseUserIntoProject(request: InviteProfileToProjects.Request.RefuseUser,
                                    completion: @escaping (EmptyResponse) -> Void)
}

class InviteProfileToProjectsWorker: InviteProfileToProjectsWorkerProtocol {
    
    private let builder: FirebaseAuthHelperProtocol
    
    init(builder: FirebaseAuthHelperProtocol = FirebaseAuthHelper()) {
        self.builder = builder
    }
    
    func fetchProjects(request: InviteProfileToProjects.Request.FetchProjects,
                       completion: @escaping (BaseResponse<[InviteProfileToProjects.Info.Response.Project]>) -> Void) {
        let headers: [String : Any] = .empty
        builder.fetchCurrentUserAuthoringProjects(request: headers,
                                                  completion: completion)
    }
    
    func fetchUserProjectRelation(request: InviteProfileToProjects.Request.FetchUserProjectRelation,
                                  completion: @escaping (BaseResponse<InviteProfileToProjects.Info.Response.ProjectRelation>) -> Void) {
        let headers: [String : Any] = ["userId": request.userId, "projectId": request.projectId]
        builder.fetchUserRelationToProject(request: headers, completion: completion)
    }
    
    func fetchInviteUserToProject(request: InviteProfileToProjects.Request.InviteUser,
                                  completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["userId": request.userId,
                                       "projectId": request.projectId,
                                       "project_title": request.projectTitle,
                                       "author_id": request.authorId,
                                       "image": request.projectImage]
        builder.inviteUserToProject(request: headers, completion: completion)
    }
    
    func fetchRemoveInvite(request: InviteProfileToProjects.Request.RemoveInvite,
                           completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["userId": request.userId, "projectId": request.projectId]
        builder.removeProjectInviteToUser(request: headers, completion: completion)
    }
    
    func fetchAcceptUserIntoProject(request: InviteProfileToProjects.Request.AcceptUser,
                                    completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["userId": request.userId, "projectId": request.projectId]
        builder.acceptUserIntoProject(request: headers, completion: completion)
    }
    
    func fetchRefuseUserIntoProject(request: InviteProfileToProjects.Request.RefuseUser,
                                    completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["userId": request.userId, "projectId": request.projectId]
        builder.refuseUserIntoProject(request: headers, completion: completion)
    }
    
    func fetchRemoveUserFromProject(request: InviteProfileToProjects.Request.RemoveUser,
                                    completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["userId": request.userId, "projectId": request.projectId]
        builder.removeUserFromProject(request: headers, completion: completion)
    }
}
