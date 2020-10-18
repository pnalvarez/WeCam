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
//        let headers: [String : Any] = ["limit": MainFeed.Constants.BusinessLogic.ongoingProjectsLimit]
//        builder.fetchOnGoingProjectsFeed(request: headers,
//                                         completion: completion)
        completion(.success(MainFeed.Info.Response.OnGoingProject.stubArray))
    }
}
