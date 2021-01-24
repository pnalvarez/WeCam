//
//  OnGoingProjectInvitesWorker.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 12/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol ProjectInvitesWorkerProtocol {
    func fetchConnections(_ request: ProjectInvites.Request.FetchUsers,
                          completion: @escaping (BaseResponse<[ProjectInvites.Info.Response.User]>) -> Void)
    func fetchUserRelationToOnGoingProject(_ request: ProjectInvites.Request.FetchRelation,
                                    completion: @escaping (BaseResponse<ProjectInvites.Info.Response.UserRelation>) -> Void)
    func fetchOnGoingProjectInfo(_ request: ProjectInvites.Request.FetchProjectWithId,
                          completion: @escaping (BaseResponse<ProjectInvites.Info.Response.Project>) -> Void)
    func fetchInviteUserToOnGoingProject(_ request: ProjectInvites.Request.InviteUser,
                         completion: @escaping (EmptyResponse) -> Void)
    func fetchAcceptUserIntoProject(_ request: ProjectInvites.Request.AcceptUser,
                                    completion: @escaping (EmptyResponse) -> Void)
    func fetchRefuseUserIntoProject(_ request: ProjectInvites.Request.RefuseUser,
                                    completion: @escaping (EmptyResponse) -> Void)
    func fetchRemoveUserFromOnGoingProject(_ request: ProjectInvites.Request.RemoveUserFromProject,
                                    completion: @escaping (EmptyResponse) -> Void)
    func fetchRemoveOnGoingProjectInviteToUser(_ request: ProjectInvites.Request.RemoveInvite,
                                 completion: @escaping (EmptyResponse) -> Void)
    func fetchUserRelationToFinishedProject(_ request: ProjectInvites.Request.FetchRelation,
                                            completion: @escaping (BaseResponse<ProjectInvites.Info.Response.UserRelation>) -> Void)
    func fetchInviteUserToFinishedProject(request: ProjectInvites.Request.InviteUser,
                                          completion: @escaping (EmptyResponse) -> Void)
    func fetchRemoveFinishedProjectInvite(request: ProjectInvites.Request.RemoveInvite,
                                          completion: @escaping (EmptyResponse) -> Void)
    func fetchFinishedProjectInfo(request: ProjectInvites.Request.FetchProjectWithId,
                                  completion: @escaping (BaseResponse<ProjectInvites.Info.Response.Project>) -> Void)
}

class ProjectInvitesWorker: ProjectInvitesWorkerProtocol {
    
    private let builder: FirebaseManagerProtocol
    
    init(builder: FirebaseManagerProtocol = FirebaseManager()) {
        self.builder = builder
    }
    
    func fetchConnections(_ request: ProjectInvites.Request.FetchUsers,
                          completion: @escaping (BaseResponse<[ProjectInvites.Info.Response.User]>) -> Void) {
        builder.fetchCurrentUserConnections(completion: completion)
    }
    
    func fetchUserRelationToOnGoingProject(_ request: ProjectInvites.Request.FetchRelation,
                                    completion: @escaping (BaseResponse<ProjectInvites.Info.Response.UserRelation>) -> Void) {
        let headers: [String : Any] = ["userId": request.userId, "projectId": request.projectId]
        builder.fetchUserRelationToOnGoingProject(request: headers,
                                           completion: completion)
    }
    
    func fetchOnGoingProjectInfo(_ request: ProjectInvites.Request.FetchProjectWithId,
                          completion: @escaping (BaseResponse<ProjectInvites.Info.Response.Project>) -> Void) {
        let headers: [String : Any] = ["projectId": request.id]
        builder.fetchProjectWorking(request: headers, completion: completion)
    }
    
    func fetchInviteUserToOnGoingProject(_ request: ProjectInvites.Request.InviteUser,
                         completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["userId": request.userId,
                                       "projectId": request.projectId,
                                       "image": request.projectImage,
                                       "project_title": request.projectTitle,
                                       "author_id": request.authorId]
        builder.inviteUserToProject(request: headers, completion: completion)
    }
    
    func fetchAcceptUserIntoProject(_ request: ProjectInvites.Request.AcceptUser,
                                    completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["userId": request.userId, "projectId": request.projectId]
        builder.acceptUserIntoProject(request: headers, completion: completion)
    }
    
    func fetchRefuseUserIntoProject(_ request: ProjectInvites.Request.RefuseUser,
                                    completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["userId": request.userId, "projectId": request.projectId]
        builder.refuseUserIntoProject(request: headers, completion: completion)
    }
    
    func fetchRemoveUserFromOnGoingProject(_ request: ProjectInvites.Request.RemoveUserFromProject,
                                    completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["userId": request.userId, "projectId": request.projectId]
        builder.removeUserFromProject(request: headers, completion: completion)
    }
    
    func fetchRemoveOnGoingProjectInviteToUser(_ request: ProjectInvites.Request.RemoveInvite,
                                 completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["userId" : request.userId, "projectId": request.projectId]
        builder.removeProjectInviteToUser(request: headers, completion: completion)
    }
    
    func fetchUserRelationToFinishedProject(_ request: ProjectInvites.Request.FetchRelation,
                                            completion: @escaping (BaseResponse<ProjectInvites.Info.Response.UserRelation>) -> Void) {
        let headers: [String : Any] = ["userId": request.userId, "projectId": request.projectId]
        builder.fetchUserRelationToFinishedProject(request: headers, completion: completion)
    }
    
    func fetchInviteUserToFinishedProject(request: ProjectInvites.Request.InviteUser,
                                          completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["projectId": request.projectId, "userId": request.userId]
        builder.inviteUserToFinishedProject(request: headers, completion: completion)
    }
    
    func fetchRemoveFinishedProjectInvite(request: ProjectInvites.Request.RemoveInvite,
                                          completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["projectId": request.projectId, "userId": request.userId]
        builder.removeInviteToFinishedProjectFromUser(request: headers, completion: completion)
    }
    
    func fetchFinishedProjectInfo(request: ProjectInvites.Request.FetchProjectWithId,
                                  completion: @escaping (BaseResponse<ProjectInvites.Info.Response.Project>) -> Void) {
        let headers: [String : Any] = ["projectId": request.id]
        builder.fetchFinishedProjectData(request: headers, completion: completion)
    }
}
