//
//  RecentSearchWorker.swift
//  WeCam
//
//  Created by Pedro Alvarez on 10/03/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

protocol RecentSearchWorkerProtocol {
    func fetchRecentSearches(_ request: RecentSearch.Request.FetchRecentSearches,
                             completion: @escaping (BaseResponse<[RecentSearch.Info.Response.Search]>) -> Void)
    func fetchUserData(_ request: RecentSearch.Request.FetchUserData,
                       completion: @escaping (BaseResponse<RecentSearch.Info.Response.User>) -> Void)
    func fetchOngoingProjectData(_ request: RecentSearch.Request.FetchProjectData,
                                 completion: @escaping (BaseResponse<RecentSearch.Info.Response.Project>) -> Void)
    func fetchFinishedProjectData(_ request: RecentSearch.Request.FetchProjectData,
                                  completion: @escaping (BaseResponse<RecentSearch.Info.Response.Project>) -> Void)
    func fetchRegisterRecentSearch(_ request: RecentSearch.Request.RegisterSearch,
                                   completion: @escaping (EmptyResponse) -> Void)
}

class RecentSearchWorker: RecentSearchWorkerProtocol {
    
    private let builder: FirebaseManagerProtocol
    
    init(builder: FirebaseManagerProtocol = FirebaseManager()) {
        self.builder = builder
    }
    
    func fetchRecentSearches(_ request: RecentSearch.Request.FetchRecentSearches,
                             completion: @escaping (BaseResponse<[RecentSearch.Info.Response.Search]>) -> Void) {
        let headers: [String : Any] = .empty
        builder.fetchRecentSearches(request: headers,
                                    completion: completion)
    }
    
    func fetchUserData(_ request: RecentSearch.Request.FetchUserData,
                       completion: @escaping (BaseResponse<RecentSearch.Info.Response.User>) -> Void) {
        let headers: [String : Any] = ["userId": request.userId]
        builder.fetchUserData(request: headers, completion: completion)
    }
    
    func fetchOngoingProjectData(_ request: RecentSearch.Request.FetchProjectData,
                                 completion: @escaping (BaseResponse<RecentSearch.Info.Response.Project>) -> Void) {
        let headers: [String : Any] = ["projectId" : request.projectId]
        builder.fetchOngoingProjectDetails(request: headers, completion: completion)
    }
    
    func fetchFinishedProjectData(_ request: RecentSearch.Request.FetchProjectData,
                                  completion: @escaping (BaseResponse<RecentSearch.Info.Response.Project>) -> Void) {
        let headers: [String : Any] = ["projectId" : request.projectId]
        builder.fetchFinishedProjectData(request: headers, completion: completion)
    }
    
    func fetchRegisterRecentSearch(_ request: RecentSearch.Request.RegisterSearch,
                                   completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["id": request.id]
        builder.registerRecentSearch(request: headers,
                                     completion: completion)
    }
}
