//
//  SearchResultsInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 29/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol SearchResultsBusinessLogic {
    func fetchBeginSearch(_ request: SearchResults.Request.Search)
    func fetchSearch(_ request: SearchResults.Request.SearchWithPreffix)
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

extension SearchResultsInteractor {
    
    private func fetchSearchProjects(_ request: SearchResults.Request.SearchWithPreffix) {
        worker.fetchProjects(request) { response in
            switch response {
            case .success(let data):
                self.presenter.presentLoading(false)
                self.results?.projects = data.map({
                    SearchResults.Info.Model.Project(id: $0.id ?? .empty,
                                                     title: $0.title ?? .empty,
                                                     progress: $0.progress ?? 0,
                                                     firstCathegory: $0.firstCathegory ?? .empty,
                                                     secondCathegory: $0.secondCathegory,
                                                     image: $0.image ?? .empty)
                })
                guard let results = self.results else { return }
                self.presenter.presentResults(results)
            case .error(let error):
                break
            }
        }
    }
}

extension SearchResultsInteractor: SearchResultsBusinessLogic {
    
    func fetchBeginSearch(_ request: SearchResults.Request.Search) {
        presenter.presentLoading(true)
        let request = SearchResults.Request.SearchWithPreffix(preffix: searchKey?.key ?? .empty)
        worker.fetchProfiles(request) { response in
            switch response {
            case .success(let data):
                self.results = SearchResults
                    .Info
                    .Model
                    .Results(users: data.map({ SearchResults
                                                .Info
                                                .Model
                                                .Profile(id: $0.id ?? .empty,
                                                         name: $0.name ?? .empty,
                                                         image: $0.image ?? .empty,
                                                         ocupation: $0.ocupation ?? .empty)}), projects: .empty)
                self.fetchSearchProjects(request)
            case .error(let error):
                break
            }
        }
    }
    
    func fetchSearch(_ request: SearchResults.Request.SearchWithPreffix) {
        presenter.presentLoading(true)
        worker.fetchProfiles(request) { response in
            switch response {
            case .success(let data):
                self.results = SearchResults
                    .Info
                    .Model
                    .Results(users: data.map({ SearchResults
                                                .Info
                                                .Model
                                                .Profile(id: $0.id ?? .empty,
                                                         name: $0.name ?? .empty,
                                                         image: $0.image ?? .empty,
                                                         ocupation: $0.ocupation ?? .empty)}), projects: .empty)
                self.fetchSearchProjects(request)
            case .error(let error):
                break
            }
        }
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
