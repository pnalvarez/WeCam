//
//  SearchResultsWorkerMock.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 29/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

@testable import Lumiere

final class SearchResultsWorkerMock: SearchResultsWorkerProtocol {
    
    func fetchProfiles(_ request: SearchResults.Request.SelectProfile, completion: @escaping (BaseResponse<[SearchResults.Info.Response.Profile]>) -> Void) {
        guard request.index != 0 else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success(SearchResults.Info.Response.Profile.stubArray))
    }
    
    func fetchProjects(_ request: SearchResults.Request.SelectProject, completion: @escaping (BaseResponse<[SearchResults.Info.Response.Project]>) -> Void) {
        guard request.index != 0 else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success(SearchResults.Info.Response.Project.stubArray))
    }
}
