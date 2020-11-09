//
//  FinishedProjectDetailsWorker.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 08/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol FinishedProjectDetailsWorkerProtocol {
    func fetchProjectData(_ request: FinishedProjectDetails.Request.FetchProjectDataWithId,
                          completion: @escaping  (BaseResponse<FinishedProjectDetails.Info.Response.Project>) -> Void)
    func fetchTeamMemberData(_ request: FinishedProjectDetails.Request.FetchTeamMembersWithId,
                          completion: @escaping (BaseResponse<FinishedProjectDetails.Info.Response.TeamMember>) -> Void)
    func fetchAcceptProjectInvite(_ request: FinishedProjectDetails.Request.AcceptInvite,
                                  completion: @escaping (EmptyResponse) -> Void)
    func fetchRefuseProjectInvite(_ request: FinishedProjectDetails.Request.RefuseInvite,
                                  completion: @escaping (EmptyResponse) -> Void)
    func fetchProjectRelation(_ request: FinishedProjectDetails.Request.ProjectRelationWithId,
                              completion: @escaping (EmptyResponse) -> Void)
}

class FinishedProjectDetailsWorker: FinishedProjectDetailsWorkerProtocol {
    
    private let builder: FirebaseManagerProtocol
    
    init(builder: FirebaseManagerProtocol = FirebaseManager()) {
        self.builder = builder
    }
    
    func fetchProjectData(_ request: FinishedProjectDetails.Request.FetchProjectDataWithId,
                          completion: @escaping (BaseResponse<FinishedProjectDetails.Info.Response.Project>) -> Void) {
        let headers: [String : Any] = ["projectId" : request.id]
        builder.fetchFinishedProjectData(request: headers,
                                         completion: completion)
    }
    
    func fetchTeamMemberData(_ request: FinishedProjectDetails.Request.FetchTeamMembersWithId,
                             completion: @escaping (BaseResponse<FinishedProjectDetails.Info.Response.TeamMember>) -> Void) {
        let headers: [String : Any] = ["userId" : request.id]
        builder.fetchUserData(request: headers,
                              completion: completion)
    }
    
    func fetchAcceptProjectInvite(_ request: FinishedProjectDetails.Request.AcceptInvite,
                                  completion: @escaping (EmptyResponse) -> Void) {
        
    }
    
    func fetchRefuseProjectInvite(_ request: FinishedProjectDetails.Request.RefuseInvite,
                                  completion: @escaping (EmptyResponse) -> Void) {
        
    }
    
    func fetchProjectRelation(_ request: FinishedProjectDetails.Request.ProjectRelationWithId,
                              completion: @escaping (EmptyResponse) -> Void) {
        
    }
}
