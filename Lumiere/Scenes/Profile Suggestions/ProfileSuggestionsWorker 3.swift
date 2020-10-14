//
//  ProfilesSuggestionsWorker.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 10/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol ProfileSuggestionsWorkerProtocol {
    func fetchCommonConnectionsProfileSuggestions(_ request: ProfileSuggestions.Request.FetchCommonConnectionsProfileSuggestions,
                                                  completion: @escaping (BaseResponse<[ProfileSuggestions.Info.Response.Profile]>) -> Void)
    func fetchCommonProjectsProfileSuggestions(_ request: ProfileSuggestions.Request.FetchCommonProjectsProfileSuggestions,
                                               completion: @escaping (BaseResponse<[ProfileSuggestions.Info.Response.Profile]>) -> Void)
    func fetchCommonCathegoriesProfileSuggestions(_ request: ProfileSuggestions.Request.FetchCommonCathegoriesProfileSuggestions,
                                                  completion: @escaping (BaseResponse<[ProfileSuggestions.Info.Response.Profile]>) -> Void)
    func fetchSendConnectionRequest(_ request: ProfileSuggestions.Request.AddUserWithId,
                                    completion: @escaping (EmptyResponse) -> Void)
    func fetchRemoveProfileSuggestion(_ request: ProfileSuggestions.Request.RemoveUserWithId,
                                      completion: @escaping (EmptyResponse) -> Void)
}

class ProfileSuggestionsWorker: ProfileSuggestionsWorkerProtocol {
    
    private let builder: FirebaseManagerProtocol
    
    init(builder: FirebaseManagerProtocol = FirebaseManager()) {
        self.builder = builder
    }
    
    func fetchCommonConnectionsProfileSuggestions(_ request: ProfileSuggestions.Request.FetchCommonConnectionsProfileSuggestions,
                                                  completion: @escaping (BaseResponse<[ProfileSuggestions.Info.Response.Profile]>) -> Void) {
        let headers: [String : Any] = ["limit": ProfileSuggestions.Constants.BusinessLogic.suggestionsLimit]
        builder.fetchCommonConnectionsProfileSuggestions(request: headers,
                                                         completion: completion)
    }
    
    func fetchCommonProjectsProfileSuggestions(_ request: ProfileSuggestions.Request.FetchCommonProjectsProfileSuggestions,
                                               completion: @escaping (BaseResponse<[ProfileSuggestions.Info.Response.Profile]>) -> Void) {
        let headers: [String : Any] = ["limit": ProfileSuggestions.Constants.BusinessLogic.suggestionsLimit]
        builder.fetchCommonProjectsProfileSuggestions(request: headers,
                                                      completion: completion)
    }
    
    func fetchCommonCathegoriesProfileSuggestions(_ request: ProfileSuggestions.Request.FetchCommonCathegoriesProfileSuggestions,
                                                  completion: @escaping (BaseResponse<[ProfileSuggestions.Info.Response.Profile]>) -> Void) {
        let headers: [String : Any] = ["limit": ProfileSuggestions.Constants.BusinessLogic.suggestionsLimit]
        builder.fetchCommonCathegoriesProfileSuggestions(request: headers,
                                                         completion: completion)
    }
    
    func fetchSendConnectionRequest(_ request: ProfileSuggestions.Request.AddUserWithId,
                                    completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["userId" : request.userId]
        builder.fetchSendConnectionRequest(request: headers, completion: completion)
    }
    
    func fetchRemoveProfileSuggestion(_ request: ProfileSuggestions.Request.RemoveUserWithId,
                                      completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["userId" : request.userId]
        builder.removeProfileSuggestion(request: headers, completion: completion)
    }
}
