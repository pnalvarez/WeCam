//
//  MainFeedWorkerMock.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 02/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

@testable import Lumiere

class MainFeedWorkerMock: MainFeedWorkerProtocol {
    
    func fetchProfileSuggestions(_ request: MainFeed.Request.FetchSuggestedProfiles, completion: @escaping (BaseResponse<[MainFeed.Info.Response.ProfileSuggestion]>) -> Void) {
        completion(.success(MainFeed.Info.Response.ProfileSuggestion.stubArray))
    }
    
    func fetchOnGoingProjects(_ request: MainFeed.Request.FetchOnGoingProjects, completion: @escaping (BaseResponse<[MainFeed.Info.Response.OnGoingProject]>) -> Void) {
        completion(.success(MainFeed.Info.Response.OnGoingProject.stubArray))
    }
    
    func fetchInterestCathegories(_ request: MainFeed.Request.FetchInterestCathegories, completion: @escaping (BaseResponse<MainFeed.Info.Response.InterestCathegories>) -> Void) {
        completion(.success(MainFeed.Info.Response.InterestCathegories.stub))
    }
}
