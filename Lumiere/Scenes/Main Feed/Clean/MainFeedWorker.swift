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
}

class MainFeedWorker: MainFeedWorkerProtocol {
    
    private let builder: FirebaseManagerProtocol
    
    init(builder: FirebaseManagerProtocol = FirebaseManager()) {
        self.builder = builder
    }
    
    func fetchProfileSuggestions(_ request: MainFeed.Request.FetchSuggestedProfiles,
                                 completion: @escaping (BaseResponse<[MainFeed.Info.Response.ProfileSuggestion]>) -> Void) {
        let headers: [String : Any] = ["limit": MainFeed.Constants.BusinessLogic.suggestionsLimit]
        builder.fetchProfileSuggestions(request: headers,
                                        completion: completion)
    }
}
