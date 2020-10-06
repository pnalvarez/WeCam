//
//  MainFeedInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol MainFeedBusinessLogic {
    func fetchSearch(_ request: MainFeed.Request.Search)
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

extension MainFeedInteractor: MainFeedBusinessLogic {
    
    func fetchSearch(_ request: MainFeed.Request.Search) {
        searchKey = MainFeed.Info.Model.SearchKey(key: request.key)
        presenter.presentSearchResults()
    }
}
