//
//  MainFeedWorker.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol MainFeedWorkerProtocol {
    func fetchProfileSuggestions(_ request: MainFeed.Request.FetchSuggestedProfiles,
                                 completion: @escaping (BaseResponse<[MainFeed.Info.Response.ProfileSuggestion]>) -> Void)
    func fetchOnGoingProjects(_ request: MainFeed.Request.FetchOnGoingProjects,
                              completion: @escaping (BaseResponse<[MainFeed.Info.Response.OnGoingProject]>) -> Void)
    func fetchInterestCathegories(_ request: MainFeed.Request.FetchInterestCathegories,
                                  completion: @escaping (BaseResponse<MainFeed.Info.Response.InterestCathegories>) -> Void)
    func fetchFinishedProjectsLogicFeed(_ request: MainFeed.Request.FinishedProjectsLogicFeed,
                                        completion: @escaping (BaseResponse<[MainFeed.Info.Response.FinishedProject]>) -> Void)
}

class MainFeedWorker: MainFeedWorkerProtocol {
    
    private let builder: FirebaseManagerProtocol
    
    init(builder: FirebaseManagerProtocol = FirebaseManager()) {
        self.builder = builder
    }
    
    func fetchProfileSuggestions(_ request: MainFeed.Request.FetchSuggestedProfiles,
                                 completion: @escaping (BaseResponse<[MainFeed.Info.Response.ProfileSuggestion]>) -> Void) {
        let headers: [String : Any] = ["limit": MainFeed.Constants.BusinessLogic.suggestionsLimit]
        builder.fetchGeneralProfileSuggestions(request: headers,
                                               completion: completion)
    }
    
    func fetchOnGoingProjects(_ request: MainFeed.Request.FetchOnGoingProjects,
                              completion: @escaping (BaseResponse<[MainFeed.Info.Response.OnGoingProject]>) -> Void) {
        let headers: [String : Any] = ["limits": MainFeed.Constants.BusinessLogic.ongoingProjectsLimit, "fromConnections": request.fromConnections, "cathegory": request.cathegory]
        builder.fetchOnGoingProjectsFeed(request: headers,
                                         completion: completion)
//        completion(.success(MainFeed.Info.Response.OnGoingProject.stubArray))
    }
    
    func fetchInterestCathegories(_ request: MainFeed.Request.FetchInterestCathegories,
                                  completion: @escaping (BaseResponse<MainFeed.Info.Response.InterestCathegories>) -> Void) {
        let headers: [String : Any] = .empty
        builder.fetchCurrentUser(request: headers, completion: completion)
    }
    
    func fetchFinishedProjectsLogicFeed(_ request: MainFeed.Request.FinishedProjectsLogicFeed,
                                        completion: @escaping (BaseResponse<[MainFeed.Info.Response.FinishedProject]>) -> Void) {
        let headers: [String : Any] = ["criteria": request.criteria]
        builder.fetchFinishedProjectsLogicFeed(request: headers, completion: completion)
     }
}
