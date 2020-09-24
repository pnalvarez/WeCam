//
//  ProfileDetailsWorkerMock.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 02/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
@testable import Lumiere

final class ProfileDetailsWorkerMock: ProfileDetailsWorkerProtocol {
    
    func fetchUserData(_ request: ProfileDetails.Request.FetchUserDataWithId,
                       completion: @escaping (BaseResponse<ProfileDetails.Response.User>) -> Void) {
        guard request.userId != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success(ProfileDetails.Response.User.stub))
    }
    
    func fetchUserRelation(_ request: ProfileDetails.Request.FetchUserRelation,
                           completion: @escaping (BaseResponse<ProfileDetails.Response.UserRelation>) -> Void) {
        guard request.userId != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success(ProfileDetails.Response.UserRelation.stub))
    }
    
    func fetchProjectsData(_ request: ProfileDetails.Request.FetchUserProjects,
                           completion: @escaping (BaseResponse<[ProfileDetails.Response.Project]>) -> Void) {
        guard request.userId != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success(ProfileDetails.Response.Project.stubArray))
    }
    
    func fetchRemoveConnection(_ request: ProfileDetails.Request.RemoveConnection,
                               completion: @escaping (EmptyResponse) -> Void) {
        guard request.id != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success)
    }
    
    func fetchRemovePendingConnection(_ request: ProfileDetails.Request.RemovePendingConnection,
                                      completion: @escaping (EmptyResponse) -> Void) {
        guard request.id != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success)
    }
    
    func fetchSendConnectionRequest(_ request: ProfileDetails.Request.SendConnectionRequest,
                                    completion: @escaping (EmptyResponse) -> Void) {
        guard request.id != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success)
    }
    
    func fetchAcceptConnection(_ request: ProfileDetails.Request.AcceptConnectionRequest,
                               completion: @escaping (EmptyResponse) -> Void) {
        guard request.id != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success)
    }
    
    func fetchSignOut(_ request: ProfileDetails.Request.SignOut, completion: @escaping (EmptyResponse) -> Void) {
        completion(.success)
    }
}
