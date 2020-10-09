//
//  OnGoingProjectDetailsWorkerMock.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 04/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

@testable import Lumiere

final class OnGoingProjectDetailsWorkerMock: OnGoingProjectDetailsWorkerProtocol {
    
    func fetchProjectDetails(request: OnGoingProjectDetails.Request.FetchProjectWithId,
                             completion: @escaping (BaseResponse<OnGoingProjectDetails.Info.Response.Project>) -> Void) {
        guard request.id != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success(OnGoingProjectDetails.Info.Response.Project.stub))
    }
    
    func fetchteamMemberData(request: OnGoingProjectDetails.Request.FetchUserWithId,
                             completion: @escaping (BaseResponse<OnGoingProjectDetails.Info.Response.TeamMember>) -> Void) {
        guard request.id != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success(OnGoingProjectDetails.Info.Response.TeamMember.stub))
    }
    
    func fetchProjectRelation(request: OnGoingProjectDetails.Request.ProjectRelationWithId,
                              completion: @escaping (BaseResponse<OnGoingProjectDetails.Info.Response.ProjectRelation>) -> Void) {
        guard request.projectId != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success(OnGoingProjectDetails.Info.Response.ProjectRelation.stub))
    }
    
    func fetchUpdateProjectInfo(request: OnGoingProjectDetails.Request.UpdateInfoWithId,
                                completion: @escaping (EmptyResponse) -> Void) {
        guard request.projectId != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success)
    }
    
    func fetchUpdateProjectImage(request: OnGoingProjectDetails.Request.UpdateImageWithId,
                                 completion: @escaping (BaseResponse<OnGoingProjectDetails.Info.Response.ProjectImage>) -> Void) {
        guard request.projectId != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success(OnGoingProjectDetails.Info.Response.ProjectImage.stub))
    }
    
    func fetchUpdateProjectNeeding(request: OnGoingProjectDetails.Request.UpdateNeedingWithId,
                                   completion: @escaping (EmptyResponse) -> Void) {
        guard request.projectId != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success)
    }
    
    func fetchAcceptProjectInvite(_ request: OnGoingProjectDetails.Request.AcceptProjectInvite, completion: @escaping (EmptyResponse) -> Void) {
        guard request.projectId != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success)
    }
    
    func fetchRefuseProjectInvite(_ request: OnGoingProjectDetails.Request.RefuseProjectInvite,
                                  completion: @escaping (EmptyResponse) -> Void) {
        guard request.projectId != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success)
    }
    
    func fetchSendProjectParticipationRequest(_ request: OnGoingProjectDetails.Request.ProjectParticipationRequest,
                                              completion: @escaping (EmptyResponse) -> Void) {
        guard request.projectId != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success)
    }
    
    func fetchRemoveParticipantRequest(_ request: OnGoingProjectDetails.Request.RemoveProjectParticipationRequest,
                                       completion: @escaping (EmptyResponse) -> Void) {
        guard request.projectId != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success)
    }
    
    func fetchExitProject(_ request: OnGoingProjectDetails.Request.ExitProject,
                           completion: @escaping (EmptyResponse) -> Void) {
        guard request.projectId != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success)
    }
    
    func fetchUpdateProgress(_ request: OnGoingProjectDetails.Request.UpdateProgressToInteger,
                             completion: @escaping ((EmptyResponse) -> Void)) {
        guard request.projectId != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success)
    }
}
