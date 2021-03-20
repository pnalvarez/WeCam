//
//  RecentSearchInteractor.swift
//  WeCam
//
//  Created by Pedro Alvarez on 13/03/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//
import Foundation

protocol RecentSearchBusinessLogic {
    func fetchRecentSearches(_ request: RecentSearch.Request.FetchRecentSearches)
    func didSelectSearch(_ request: RecentSearch.Request.SelectSearch)
    func didTapSearchAction(_ request: RecentSearch.Request.SearchAction)
}

protocol RecentSearchDataStore {
    var searches: RecentSearch.Info.Model.UpcomingResults? { get set}
    var selectedUser: String? { get set }
    var selectedOngoingProject: String? { get set }
    var selectedFinishedProject: String? { get set }
    var searchKey: String? { get }
}

class RecentSearchInteractor: RecentSearchDataStore {

    private let worker: RecentSearchWorkerProtocol
    private let presenter: RecentSearchPresentationLogic
    
    var searches: RecentSearch.Info.Model.UpcomingResults?
    var selectedUser: String?
    var selectedOngoingProject: String?
    var selectedFinishedProject: String?
    var searchKey: String?
    
    init(worker: RecentSearchWorkerProtocol = RecentSearchWorker(),
         presenter: RecentSearchPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
    
    private func fetchData(forId id: String, ofType type: RecentSearch.Info.Model.SearchType, completion: @escaping (RecentSearch.Info.Model.Search?) -> Void) {
        switch type {
        case .user:
            self.worker.fetchUserData(RecentSearch.Request.FetchUserData(userId: id)) { response in
                switch response {
                case .success(let data):
                    completion(.user(user: RecentSearch.Info.Model.UserSearch(userId: data.userId ?? .empty, image: data.image ?? .empty, name: data.name ?? .empty, ocupation: data.ocupation ?? .empty)))
                case .error(_):
                    completion(nil)
                }
            }
        case .ongoingProject:
            self.worker.fetchOngoingProjectData(RecentSearch.Request.FetchProjectData(projectId: id)) { response in
                switch response {
                case .success(let data):
                    completion(.project(project: RecentSearch.Info.Model.ProjectSearch(projectId: data.projectId ?? .empty, image: data.image ?? .empty, title: data.title ?? .empty, firstCathegory: data.cathegories?.first ?? .empty, secondCathegory: data.cathegories?.last ?? .empty, finished: false)))
                case .error(_):
                    completion(nil)
                }
            }
        case .finishedProject:
            self.worker.fetchFinishedProjectData(RecentSearch.Request.FetchProjectData(projectId: id)) { response in
                switch response {
                case .success(let data):
                    completion(.project(project: RecentSearch.Info.Model.ProjectSearch(projectId: data.projectId ?? .empty, image: data.image ?? .empty, title: data.title ?? .empty, firstCathegory: data.cathegories?.first ?? .empty, secondCathegory: data.cathegories?.last ?? .empty, finished: true)))
                case .error(_):
                    completion(nil)
                }
            }
        }
    }
}

extension RecentSearchInteractor: RecentSearchBusinessLogic {
    
    func fetchRecentSearches(_ request: RecentSearch.Request.FetchRecentSearches) {
        presenter.presentLoading(true)
        worker.fetchRecentSearches(RecentSearch.Request.FetchRecentSearches()) { response in
            switch response {
            case .success(let data):
                let dispatchGroup = DispatchGroup()
                self.searches = RecentSearch.Info.Model.UpcomingResults(results: .empty)
                for item in data {
                    dispatchGroup.enter()
                    let id = item.id ?? .empty
                    guard let searchType = RecentSearch.Info.Model.SearchType(rawValue: item.type ?? .empty) else {
                        dispatchGroup.leave()
                        return
                    }
                    self.fetchData(forId: id, ofType: searchType) {
                        search in
                        if let search = search {
                            self.searches?.results.append(search)
                        }
                        dispatchGroup.leave()
                    }
                }
                dispatchGroup.notify(queue: .main) {
                    self.presenter.presentLoading(false)
                    if let searches = self.searches {
                        self.presenter.presentRecentSearches(searches)
                    }
                }
            case .error(let error):
                self.presenter.presentLoading(false)
                self.presenter.presentError(RecentSearch.Info.Model.Error(title: RecentSearch.Constants.Texts.errorDefaultTitle, message: error.localizedDescription))
            }
        }
    }
    
    func didSelectSearch(_ request: RecentSearch.Request.SelectSearch) {
        guard let search = searches?.results[request.index] else {
            return
        }
        switch search {
        case .user(let user):
            worker.fetchRegisterRecentSearch(RecentSearch.Request.RegisterSearch(id: user.userId)) { _ in }
            selectedUser = user.userId
            presenter.presentProfileDetails()
        case .project(let project):
            if project.finished {
                worker.fetchRegisterRecentSearch(RecentSearch.Request.RegisterSearch(id: project.projectId)) { _ in }
                selectedFinishedProject = project.projectId
                presenter.presentFinishedProjectDetails()
            } else {
                worker.fetchRegisterRecentSearch(RecentSearch.Request.RegisterSearch(id: project.projectId)) { _ in }
                selectedOngoingProject = project.projectId
                presenter.presentOngoingProjectDetails()
            }
        }
    }
    
    func didTapSearchAction(_ request: RecentSearch.Request.SearchAction) {
        searchKey = request.text
        presenter.presentSearchResults()
    }
}
