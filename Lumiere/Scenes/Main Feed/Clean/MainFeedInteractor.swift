//
//  MainFeedInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol MainFeedBusinessLogic {
    func fetchSearch(_ request: MainFeed.Request.Search)
    func fetchRecentSearches(_ request: MainFeed.Request.RecentSearches)
    func fetchSuggestedProfiles(_ request: MainFeed.Request.FetchSuggestedProfiles)
    func didSelectSuggestedProfile(_ request: MainFeed.Request.SelectSuggestedProfile)
    func fetchOnGoingProjectsFeed(_ request: MainFeed.Request.FetchOnGoingProjects)
}

protocol MainFeedDataStore {
    var currentUserId: MainFeed.Info.Received.CurrentUser? { get set }
    var searchKey: MainFeed.Info.Model.SearchKey? { get set }
    var profileSuggestions: MainFeed.Info.Model.UpcomingProfiles? { get set }
    var selectedProfile: String? { get set }
}

class MainFeedInteractor: MainFeedDataStore {
    
    private let worker: MainFeedWorkerProtocol
    private let presenter: MainFeedPresentationLogic
    
    var currentUserId: MainFeed.Info.Received.CurrentUser?
    var searchKey: MainFeed.Info.Model.SearchKey?
    var profileSuggestions: MainFeed.Info.Model.UpcomingProfiles?
    var selectedProfile: String?
    
    init(worker: MainFeedWorkerProtocol = MainFeedWorker(),
         presenter: MainFeedPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
}

extension MainFeedInteractor {
    
    private func fetchData(_ request: MainFeed.Request.FetchData) {
        
    }
}

extension MainFeedInteractor: MainFeedBusinessLogic {
    
    func fetchSearch(_ request: MainFeed.Request.Search) {
        searchKey = MainFeed.Info.Model.SearchKey(key: request.key)
        presenter.presentSearchResults()
    }
    
    func fetchRecentSearches(_ request: MainFeed.Request.RecentSearches) {
        let searchIds = LocalSaveManager.instance.fetchRecentSearches()
    }
    
    func fetchSuggestedProfiles(_ request: MainFeed.Request.FetchSuggestedProfiles) {
        worker.fetchProfileSuggestions(MainFeed.Request.FetchSuggestedProfiles()) { response in
            switch response {
            case .success(let data):
                self.profileSuggestions = MainFeed
                    .Info
                    .Model
                    .UpcomingProfiles(suggestions: data.map({ MainFeed
                                                                .Info
                                                                .Model
                                                                .ProfileSuggestion(userId: $0.userId ?? .empty,
                                                                                   image: $0.image ?? .empty,
                                                                                   name: $0.name ?? .empty,
                                                                                   ocupation: $0.ocupation ?? .empty)}))
                guard let suggestions = self.profileSuggestions else { return }
                self.presenter.presentProfileSuggestions(suggestions)
            case .error(let error):
                break
            }
        }
    }
    
    func didSelectSuggestedProfile(_ request: MainFeed.Request.SelectSuggestedProfile) {
        selectedProfile = profileSuggestions?.suggestions[request.index].userId
        presenter.presentProfileDetails()
    }
    
    func fetchOnGoingProjectsFeed(_ request: MainFeed.Request.FetchOnGoingProjects) {
        
    }
}
