//
//  InsertVideoWorker.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 04/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
protocol InsertVideoWorkerProtocol {
    func fetchProjectDetails(_ request: InsertVideo.Request.FetchProjectDetails,
                             completion: @escaping (BaseResponse<InsertVideo.Info.Response.Project>) -> Void)
    func fetchPublishExistingProject(_ request: InsertVideo.Request.SubmitVideo,
                             completion: @escaping (EmptyResponse) -> Void)
    func fetchPublishNewProject(_ request: InsertVideo.Request.CreateProject,
                                completion: @escaping (BaseResponse<InsertVideo.Info.Response.FinishedProject>) -> Void)
    func fetchInviteUserToFinishedProject(request: InsertVideo.Request.InviteUser,
                                          completion: @escaping (EmptyResponse) -> Void)
}

class InsertVideoWorker: InsertVideoWorkerProtocol {
    
    private let builder: FirebaseManagerProtocol
    
    init(builder: FirebaseManagerProtocol = FirebaseManager()) {
        self.builder = builder
    }
    
    func fetchProjectDetails(_ request: InsertVideo.Request.FetchProjectDetails,
                             completion: @escaping (BaseResponse<InsertVideo.Info.Response.Project>) -> Void) {
        let headers: [String : Any] = ["projectId": request.id]
        builder.fetchProjectWorking(request: headers, completion: completion)
    }
    
    func fetchPublishExistingProject(_ request: InsertVideo.Request.SubmitVideo,
                             completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["projectId" : request.projectId, "youtube_url" : request.video, "title" : request.projectTitle, "sinopsis" : request.sinopsis, "cathegories" : request.cathegories, "participants" : request.participants, "image" : request.image, "finish_date" : request.finishedDate]
        builder.publishOngoingProject(request: headers, completion: completion)
    }
    
    func fetchPublishNewProject(_ request: InsertVideo.Request.CreateProject,
                                completion: @escaping (BaseResponse<InsertVideo.Info.Response.FinishedProject>) -> Void) {
        let headers: [String : Any] = ["title": request.projectTitle, "sinopsis": request.sinopsis, "cathegories": request.cathegories, "youtube_url": request.video, "image": request.image]
        builder.publishNewProject(request: headers,
                                  completion: completion)
    }
    
    func fetchInviteUserToFinishedProject(request: InsertVideo.Request.InviteUser,
                                          completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["projectId": request.projectId,
                                       "userId": request.userId]
        builder.inviteUserToFinishedProject(request: headers, completion: completion)
    }
}
