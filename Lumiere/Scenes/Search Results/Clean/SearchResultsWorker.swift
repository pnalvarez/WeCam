//
//  SearchResultsWorker.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 29/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol SearchResultsWorkerProtocol {
    func fetchProfiles(_ request: SearchResults.Request.SelectProfile,
                       completion: @escaping (BaseResponse<[SearchResults.Info.Response.Profile]>) -> Void)
    func fetchProjects(_ request: SearchResults.Request.SelectProject,
                       completion: @escaping (BaseResponse<[SearchResults.Info.Response.Project]>) -> Void)
}

class SearchResultsWorker: SearchResultsWorkerProtocol {
    
    private let builder: FirebaseAuthHelperProtocol
    
    init(builder: FirebaseAuthHelperProtocol = FirebaseAuthHelper()) {
        self.builder = builder
    }
    
    func fetchProfiles(_ request: SearchResults.Request.SelectProfile,
                       completion: @escaping (BaseResponse<[SearchResults.Info.Response.Profile]>) -> Void) {
        
    }
    
    func fetchProjects(_ request: SearchResults.Request.SelectProject,
                       completion: @escaping (BaseResponse<[SearchResults.Info.Response.Project]>) -> Void) {
        
    }
}
