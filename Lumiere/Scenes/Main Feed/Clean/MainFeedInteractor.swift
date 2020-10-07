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
}

protocol MainFeedDataStore {
    var currentUserId: MainFeed.Info.Received.CurrentUser? { get set }
    var searchKey: MainFeed.Info.Model.SearchKey? { get set }
}

class MainFeedInteractor: MainFeedDataStore {
    
    private let worker: MainFeedWorkerProtocol
    private let presenter: MainFeedPresentationLogic
    
    var currentUserId: MainFeed.Info.Received.CurrentUser?
    var searchKey: MainFeed.Info.Model.SearchKey?
    
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
}
