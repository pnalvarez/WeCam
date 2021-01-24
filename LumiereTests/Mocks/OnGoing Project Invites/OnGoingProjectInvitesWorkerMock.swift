//
//  OnGoingProjectInvitesWorkerMock.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 04/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

@testable import Lumiere

final class OnGoingProjectInvitesWorkerMock: ProjectInvitesWorkerProtocol {
    
    func fetchConnections(_ request: ProjectInvites.Request.FetchUsers,
                          completion: @escaping (BaseResponse<[ProjectInvites.Info.Response.User]>) -> Void) {
        completion(.success(ProjectInvites.Info.Response.User.stubArray))
    }
    
    func fetchUserRelationToProject(_ request: ProjectInvites.Request.FetchRelation,
                                    completion: @escaping (BaseResponse<ProjectInvites.Info.Response.UserRelation>) -> Void) {
        guard request.projectId != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success(ProjectInvites.Info.Response.UserRelation.stub))
    }
    
    func fetchProjectInfo(_ request: ProjectInvites.Request.FetchProjectWithId,
                          completion: @escaping (BaseResponse<ProjectInvites.Info.Response.Project>) -> Void) {
        guard request.id != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success(ProjectInvites.Info.Response.Project.stub))
    }
    
    func fetchInviteUser(_ request: ProjectInvites.Request.InviteUser,
                         completion: @escaping (EmptyResponse) -> Void) {
        guard request.projectId != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success)
    }
    
    func fetchAcceptUserIntoProject(_ request: ProjectInvites.Request.AcceptUser,
                                    completion: @escaping (EmptyResponse) -> Void) {
        guard request.projectId != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success)
    }
    
    func fetchRefuseUserIntoProject(_ request: ProjectInvites.Request.RefuseUser,
                                    completion: @escaping (EmptyResponse) -> Void) {
        guard request.projectId != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success)
    }
    
    func fetchRemoveUserFromProject(_ request: ProjectInvites.Request.RemoveUserFromProject,
                                    completion: @escaping (EmptyResponse) -> Void) {
        guard request.projectId != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success)
    }
    
    func fetchRemoveInviteToUser(_ request: ProjectInvites.Request.RemoveInvite,
                                 completion: @escaping (EmptyResponse) -> Void) {
        guard request.projectId != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success)
    }
}
