//
//  MainFeedInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol MainFeedBusinessLogic {
    
}

protocol MainFeedDataStore {
    var currentUserId: MainFeed.Info.Received.CurrentUser? { get set }
}

class MainFeedInteractor: MainFeedDataStore {
    
    private let worker: MainFeedWorkerProtocol
    private let presenter: MainFeedPresentationLogic
    
    var currentUserId: MainFeed.Info.Received.CurrentUser?
    
    init(worker: MainFeedWorkerProtocol = MainFeedWorker(),
         presenter: MainFeedPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
}

extension MainFeedInteractor: MainFeedBusinessLogic {
    
}
