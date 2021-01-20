//
//  EditProjectDetailsWorkerMock.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 27/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

@testable import Lumiere

final class EditProjectDetailsWorkerMock: EditProjectDetailsWorkerProtocol {
    
    func fetchPublish(request: EditProjectDetails.Request.CompletePublish, completion: @escaping (BaseResponse<EditProjectDetails.Info.Response.Project>) -> Void) {
        guard request.project.title != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success(EditProjectDetails.Info.Response.Project.stub))
    }
    
    func fetchInviteUserToOnGoingProject(request: EditProjectDetails.Request.InviteUser, completion: @escaping (EmptyResponse) -> Void) {
        guard request.userId != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success)
    }
}
