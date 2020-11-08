//
//  InsertMediaWorker.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 04/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol InsertMediaWorkerProtocol {
    func fetchProjectDetails(_ request: InsertMedia.Request.FetchProjectDetails,
                             completion: @escaping (BaseResponse<InsertMedia.Info.Response.Project>) -> Void)
    func fetchPublishProject(_ request: InsertMedia.Request.SubmitVideo,
                             completion: @escaping (EmptyResponse) -> Void)
}

class InsertMediaWorker: InsertMediaWorkerProtocol {
    
    private let builder: FirebaseManagerProtocol
    
    init(builder: FirebaseManagerProtocol = FirebaseManager()) {
        self.builder = builder
    }
    
    func fetchProjectDetails(_ request: InsertMedia.Request.FetchProjectDetails,
                             completion: @escaping (BaseResponse<InsertMedia.Info.Response.Project>) -> Void) {
        let headers: [String : Any] = ["projectId": request.id]
        builder.fetchProjectWorking(request: headers, completion: completion)
    }
    
    func fetchPublishProject(_ request: InsertMedia.Request.SubmitVideo,
                             completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["projectId" : request.projectId, "youtube_url" : request.media, "title" : request.projectTitle, "sinopsis" : request.sinopsis, "cathegories" : request.cathegories, "participants" : request.participants, "image" : request.image, "finish_date" : request.finishedDate]
        builder.publishProject(request: headers, completion: completion)
    }
}
