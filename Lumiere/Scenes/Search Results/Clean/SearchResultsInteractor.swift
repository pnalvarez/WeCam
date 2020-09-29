//
//  SearchResultsInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 29/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol SearchResultsBusinessLogic {
    func fetchSearch(_ request: SearchResults.Request.Search)
    func fetchSelectProfile(_ request: SearchResults.Request.SelectProfile)
    func fetchSelectProject(_ request: SearchResults.Request.SelectProject)
}

protocol SearchResultsDataStore {
    var searchKey: SearchResults.Info.Received.SearchKey? { get }
    var results: SearchResults.Info.Model.Results? { get set }
    var selectedItem: SearchResults.Info.Model.SelectedItem? { get set }
}

class SearchResultsInteractor: SearchResultsDataStore {
    
    private let worker: SearchResultsWorkerProtocol
    private let presenter: SearchResultsPresentationLogic
    
    var searchKey: SearchResults.Info.Received.SearchKey?
    var results: SearchResults.Info.Model.Results?
    var selectedItem: SearchResults.Info.Model.SelectedItem?
    
    init(worker: SearchResultsWorkerProtocol = SearchResultsWorker(),
         presenter: SearchResultsPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
}

extension SearchResultsInteractor: SearchResultsBusinessLogic {
    
    func fetchSearch(_ request: SearchResults.Request.Search) {
        //TO DO
    }
    
    func fetchSelectProfile(_ request: SearchResults.Request.SelectProfile) {
        guard let profile = results?.users[request.index] else { return }
        selectedItem = .profile(profile)
        presenter.presentProfileDetails()
    }
    
    func fetchSelectProject(_ request: SearchResults.Request.SelectProject) {
        guard let project = results?.projects[request.index] else { return }
        selectedItem = .project(project)
        presenter.presentProjectDetails()
    }
}
