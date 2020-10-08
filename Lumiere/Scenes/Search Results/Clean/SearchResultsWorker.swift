//
//  SearchResultsWorker.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 29/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol SearchResultsWorkerProtocol {
    func fetchProfiles(_ request: SearchResults.Request.SearchWithPreffix,
                       completion: @escaping (BaseResponse<[SearchResults.Info.Response.Profile]>) -> Void)
    func fetchProjects(_ request: SearchResults.Request.SearchWithPreffix,
                       completion: @escaping (BaseResponse<[SearchResults.Info.Response.Project]>) -> Void)
}

class SearchResultsWorker: SearchResultsWorkerProtocol {
    
    private let builder: FirebaseManagerProtocol
    
    init(builder: FirebaseManagerProtocol = FirebaseManager()) {
        self.builder = builder
    }
    
    func fetchProfiles(_ request: SearchResults.Request.SearchWithPreffix,
                       completion: @escaping (BaseResponse<[SearchResults.Info.Response.Profile]>) -> Void) {
        let headers: [String : Any] = ["preffix": request.preffix]
        builder.fetchSearchProfiles(request: headers, completion: completion)
    }
    
    func fetchProjects(_ request: SearchResults.Request.SearchWithPreffix,
                       completion: @escaping (BaseResponse<[SearchResults.Info.Response.Project]>) -> Void) {
        let headers: [String : Any] = ["preffix": request.preffix]
        builder.fetchSearchProjects(request: headers, completion: completion)
    }
}
