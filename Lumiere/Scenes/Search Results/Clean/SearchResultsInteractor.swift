//
//  SearchResultsInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 29/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol SearchResultsBusinessLogic {
    func fetchBeginSearch(_ request: SearchResults.Request.Search)
    func fetchResultTypes(_ request: SearchResults.Request.FetchResultTypes)
    func fetchSelectItem(_ request: SearchResults.Request.SelectItem)
}

protocol SearchResultsDataStore {
    var searchKey: SearchResults.Info.Received.SearchKey? { get set }
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
    
    private func mapJSONProjectsToModel(_ projects: [SearchResults.Info.Response.Project]) -> [SearchResults.Info.Model.Project] {
        return projects.map({
            var secondCathegory: String?
            if $0.cathegories?.count ?? 0 > 1 {
                secondCathegory = $0.cathegories?[1]
            }
            return SearchResults.Info.Model.Project(id: $0.id ?? .empty,
                                             title: $0.title ?? .empty,
                                             progress: $0.progress ?? SearchResults.Constants.BusinessLogic.finishedProjectPercentage,
                                             firstCathegory: $0.cathegories?[0] ?? .empty,
                                             secondCathegory: secondCathegory,
                                             image: $0.image ?? .empty)
        })
    }
    
    private func fetchSearchProjects(_ request: SearchResults.Request.SearchWithPreffix) {
        worker.fetchOngoingProjects(request) { response in
            switch response {
            case .success(let data):
                self.results?.projects = self.mapJSONProjectsToModel(data)
                self.worker.fetchFinishedProjects(request) { response in
                    switch response {
                    case .success(let data):
                        self.presenter.presentLoading(false)
                        self.results?.projects.append(contentsOf: self.mapJSONProjectsToModel(data))
                        guard let results = self.results else { return }
                        self.presenter.presentResults(results)
                    case .error(let error):
                        self.presenter.presentLoading(false)
                        self.presenter.presentError(SearchResults.Info.Model.ResultError(error: error))
                    }
                }
            case .error(let error):
                self.presenter.presentLoading(false)
                self.presenter.presentError(SearchResults.Info.Model.ResultError(error: error))
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
                self.presenter.presentLoading(false)
                self.presenter.presentError(SearchResults.Info.Model.ResultError(error: error))
            }
        }
    }
    
    func fetchResultTypes(_ request: SearchResults.Request.FetchResultTypes) {
        let resultTypes = SearchResults.Info.Model.UpcomingTypes(types: SearchResults.Info.Model.ResultType.toArray())
        presenter.presentResultTypes(resultTypes)
    }
    
    func fetchSelectItem(_ request: SearchResults.Request.SelectItem) {
        switch request.type {
        case .profile:
            guard let user = results?.users[request.index] else { return }
            worker.fetchRegisterSearch(SearchResults.Request.RegisterSearch(id: user.id, type: SearchResults.Info.Model.SearchType.user.rawValue)) { _ in }
            selectedItem = .profile(user)
            presenter.presentProfileDetails()
        case .project:
            guard let project = results?.projects[request.index] else { return }
            if project.finished {
                worker.fetchRegisterSearch(SearchResults.Request.RegisterSearch(id: project.id, type: SearchResults.Info.Model.SearchType.finishedProject.rawValue)) { _ in}
                selectedItem = .project(project)
                presenter.presentFinishedProjectDetails()
            } else {
                worker.fetchRegisterSearch(SearchResults.Request.RegisterSearch(id: project.id, type: SearchResults.Info.Model.SearchType.ongoingProject.rawValue)) { _ in }
                selectedItem = .project(project)
                presenter.presentOnGoingProjectDetails()
            }
        }
    }
}
