//
//  WatchVideoWorker.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 09/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol WatchVideoWorkerProtocol {
    func fetchYoutubeVideo(_ request: WatchVideo.Request.FetchYoutubeIdWithProjectId,
                           completion: @escaping (BaseResponse<WatchVideo.Info.Response.Video>) -> Void)
    func fetchRegisterView(_ request: WatchVideo.Request.RegisterViewWithId,
                           completion: @escaping (EmptyResponse) -> Void)
}

class WatchVideoWorker: WatchVideoWorkerProtocol {
    
    private let builder: FirebaseManagerProtocol
    
    init(builder: FirebaseManagerProtocol = FirebaseManager()) {
        self.builder = builder
    }
    
    func fetchYoutubeVideo(_ request: WatchVideo.Request.FetchYoutubeIdWithProjectId,
                           completion: @escaping (BaseResponse<WatchVideo.Info.Response.Video>) -> Void) {
        let headers: [String : Any] = ["projectId" : request.projectId]
        builder.fetchFinishedProjectData(request: headers, completion: completion)
    }
    
    func fetchRegisterView(_ request: WatchVideo.Request.RegisterViewWithId,
                           completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["projectId": request.projectId]
        builder.addViewToProject(request: headers, completion: completion)
    }
}
