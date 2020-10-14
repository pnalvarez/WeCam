//
//  OnGoingProjectInvitesWorkerMock.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 04/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

@testable import Lumiere

final class OnGoingProjectInvitesWorkerMock: OnGoingProjectInvitesWorkerProtocol {
    
    func fetchConnections(_ request: OnGoingProjectInvites.Request.FetchUsers,
                          completion: @escaping (BaseResponse<[OnGoingProjectInvites.Info.Response.User]>) -> Void) {
        completion(.success(OnGoingProjectInvites.Info.Response.User.stubArray))
    }
    
    func fetchUserRelationToProject(_ request: OnGoingProjectInvites.Request.FetchRelation,
                                    completion: @escaping (BaseResponse<OnGoingProjectInvites.Info.Response.UserRelation>) -> Void) {
        guard request.projectId != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success(OnGoingProjectInvites.Info.Response.UserRelation.stub))
    }
    
    func fetchProjectInfo(_ request: OnGoingProjectInvites.Request.FetchProjectWithId,
                          completion: @escaping (BaseResponse<OnGoingProjectInvites.Info.Response.Project>) -> Void) {
        guard request.id != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success(OnGoingProjectInvites.Info.Response.Project.stub))
    }
    
    func fetchInviteUser(_ request: OnGoingProjectInvites.Request.InviteUser,
                         completion: @escaping (EmptyResponse) -> Void) {
        guard request.projectId != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success)
    }
    
    func fetchAcceptUserIntoProject(_ request: OnGoingProjectInvites.Request.AcceptUser,
                                    completion: @escaping (EmptyResponse) -> Void) {
        guard request.projectId != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success)
    }
    
    func fetchRefuseUserIntoProject(_ request: OnGoingProjectInvites.Request.RefuseUser,
                                    completion: @escaping (EmptyResponse) -> Void) {
        guard request.projectId != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success)
    }
    
    func fetchRemoveUserFromProject(_ request: OnGoingProjectInvites.Request.RemoveUserFromProject,
                                    completion: @escaping (EmptyResponse) -> Void) {
        guard request.projectId != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success)
    }
    
    func fetchRemoveInviteToUser(_ request: OnGoingProjectInvites.Request.RemoveInvite,
                                 completion: @escaping (EmptyResponse) -> Void) {
        guard request.projectId != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success)
    }
}
