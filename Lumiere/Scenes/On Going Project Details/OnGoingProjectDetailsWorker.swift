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
}
