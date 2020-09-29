//
//  SearchResultsInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 29/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol SearchResultsBusinessLogic {
    
}

protocol SearchResultsDataStore {
    
}

class SearchResultsInteractor: SearchResultsDataStore {
    
    private let worker: SearchResultsWorkerProtocol
    private let presenter: SearchResultsPresentationLogic
    
    init(worker: SearchResultsWorkerProtocol = SearchResultsWorker(),
         presenter: SearchResultsPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
}

extension SearchResultsInteractor: SearchResultsBusinessLogic {
    
}
