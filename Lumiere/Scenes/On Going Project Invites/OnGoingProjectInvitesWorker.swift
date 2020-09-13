//
//  OnGoingProjectInvitesWorker.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 12/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol OnGoingProjectInvitesWorkerProtocol {
    func fetchConnections(_ request: OnGoingProjectInvites.Request.FetchUsers,
                          completion: @escaping (BaseResponse<[OnGoingProjectInvites.Info.Response.User]>) -> Void)
    func fetchUserRelationToProject(_ request: OnGoingProjectInvites.Request.FetchRelation,
                                    completion: @escaping (BaseResponse<OnGoingProjectInvites.Info.Response.UserRelation>) -> Void)
    func fetchProjectInfo(_ request: OnGoingProjectInvites.Request.FetchProjectWithId,
                          completion: @escaping (BaseResponse<OnGoingProjectInvites.Info.Response.Project>) -> Void)
    func fetchInviteUser(_ request: OnGoingProjectInvites.Request.InviteUser,
                         completion: @escaping (EmptyResponse) -> Void)
    func fetchAcceptUserIntoProject(_ request: OnGoingProjectInvites.Request.AcceptUser,
                                    completion: @escaping (EmptyResponse) -> Void)
    func fetchRefuseUserIntoProject(_ request: OnGoingProjectInvites.Request.RefuseUser,
                                    completion: @escaping (EmptyResponse) -> Void)
    func fetchRemoveUserFromProject(_ request: OnGoingProjectInvites.Request.RemoveUserFromProject,
                                    completion: @escaping (EmptyResponse) -> Void)
}

class OnGoingProjectInvitesWorker: OnGoingProjectInvitesWorkerProtocol {
    
    private let builder: FirebaseAuthHelperProtocol
    
    init(builder: FirebaseAuthHelperProtocol = FirebaseAuthHelper()) {
        self.builder = builder
    }
    
    func fetchConnections(_ request: OnGoingProjectInvites.Request.FetchUsers,
                          completion: @escaping (BaseResponse<[OnGoingProjectInvites.Info.Response.User]>) -> Void) {
        builder.fetchCurrentUserConnections(completion: completion)
    }
    
    func fetchUserRelationToProject(_ request: OnGoingProjectInvites.Request.FetchRelation,
                                    completion: @escaping (BaseResponse<OnGoingProjectInvites.Info.Response.UserRelation>) -> Void) {
        let headers: [String : Any] = ["userId": request.userId, "projectId": request.projectId]
        builder.fetchUserRelationToProject(request: headers,
                                           completion: completion)
    }
    
    func fetchProjectInfo(_ request: OnGoingProjectInvites.Request.FetchProjectWithId,
                          completion: @escaping (BaseResponse<OnGoingProjectInvites.Info.Response.Project>) -> Void) {
        let headers: [String : Any] = ["projectId": request.id]
        builder.fetchProjectWorking(request: headers, completion: completion)
    }
    
    func fetchInviteUser(_ request: OnGoingProjectInvites.Request.InviteUser,
                         completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["userId": request.userId,
                                       "projectId": request.projectId,
                                       "image": request.projectImage,
                                       "project_title": request.projectTitle,
                                       "author_id": request.authorId]
        builder.inviteUserToProject(request: headers, completion: completion)
    }
    
    func fetchAcceptUserIntoProject(_ request: OnGoingProjectInvites.Request.AcceptUser,
                                    completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["userId": request.userId, "projectId": request.projectId]
        builder.acceptUserIntoProject(request: headers, completion: completion)
    }
    
    func fetchRefuseUserIntoProject(_ request: OnGoingProjectInvites.Request.RefuseUser,
                                    completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["userId": request.userId, "projectId": request.projectId]
        builder.refuseUserIntoProject(request: headers, completion: completion)
    }
    
    func fetchRemoveUserFromProject(_ request: OnGoingProjectInvites.Request.RemoveUserFromProject,
                                    completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["userId": request.userId, "projectId": request.projectId]
        //TO DO
    }
}
