//
//  MainFeedInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import Foundation

protocol MainFeedBusinessLogic {
    func fetchSearch(_ request: MainFeed.Request.Search)
    func fetchRecentSearches(_ request: MainFeed.Request.RecentSearches)
    func fetchMainFeed(_ request: MainFeed.Request.MainFeed)
    func didSelectSuggestedProfile(_ request: MainFeed.Request.SelectSuggestedProfile)
    func didSelectOnGoingProject(_ request: MainFeed.Request.SelectOnGoingProject)
    func didSelectOnGoingProjectCathegory(_ request: MainFeed.Request.SelectOnGoingProjectCathegory)
}

protocol MainFeedDataStore {
    var currentUserId: MainFeed.Info.Received.CurrentUser? { get set }
    var searchKey: MainFeed.Info.Model.SearchKey? { get set }
    var selectedProfile: String? { get set }
    var selectedProject: String? { get set }
    var mainFeedData: MainFeed.Info.Model.UpcomingFeedData? { get }
    var selectedCathegory: String { get }
}

class MainFeedInteractor: MainFeedDataStore {
    
    private let worker: MainFeedWorkerProtocol
    private let presenter: MainFeedPresentationLogic
    
    var currentUserId: MainFeed.Info.Received.CurrentUser?
    var searchKey: MainFeed.Info.Model.SearchKey?
    var selectedProfile: String?
    var selectedProject: String?
    var mainFeedData: MainFeed.Info.Model.UpcomingFeedData?
    
    var selectedCathegory: String = MainFeed.Constants.Texts.allCriteria {
        didSet {
            mainFeedData?.interestCathegories?.selectedCriteria = buildMainFeedCathegory()
        }
    }
    
    init(worker: MainFeedWorkerProtocol = MainFeedWorker(),
         presenter: MainFeedPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
}

extension MainFeedInteractor {
    
    private func fetchSuggestedProfiles(_ request: MainFeed.Request.FetchSuggestedProfiles) {
        worker.fetchProfileSuggestions(MainFeed.Request.FetchSuggestedProfiles()) { response in
            switch response {
            case .success(let data):
                self.mainFeedData = MainFeed.Info.Model.UpcomingFeedData(profileSuggestions: MainFeed.Info.Model.UpcomingProfiles(suggestions: data.map({
                    MainFeed.Info.Model.ProfileSuggestion(userId: $0.userId ?? .empty,
                                                          image: $0.image ?? .empty,
                                                          name: $0.name ?? .empty,
                                                          ocupation: $0.ocupation ?? .empty)
                })), ongoingProjects: nil,
                interestCathegories: nil)
                self.fetchOnGoingProjectsFeed(MainFeed.Request.RequestOnGoingProjectsFeed(item: self.selectedCathegory))
            case .error(let error):
                break
            }
        }
    }
    
    private func fetchOnGoingProjectsFeed(_ request: MainFeed.Request.RequestOnGoingProjectsFeed) {
        let newRequest = MainFeed.Request.FetchOnGoingProjects(fromConnections: request.item == MainFeed.Constants.Texts.relativeToConnectionsCriteria, cathegory: request.item)
        worker.fetchOnGoingProjects(newRequest) { response in
            switch response {
            case .success(let data):
                self.mainFeedData?.ongoingProjects = MainFeed.Info.Model.UpcomingProjects(projects: data.map({
                    MainFeed.Info.Model.OnGoingProject(id: $0.id ?? .empty,
                                                       image: $0.image ?? .empty,
                                                       progress: $0.progress ?? 0)
                }))
                self.fetchInterestCathegories(MainFeed.Request.FetchInterestCathegories())
            case .error(let error):
                break
            }
        }
    }
    
    private func fetchInterestCathegories(_ request: MainFeed.Request.FetchInterestCathegories) {
        worker.fetchInterestCathegories(MainFeed.Request.FetchInterestCathegories()) { response in
            switch response {
            case .success(let cathegories):
                var defaultCathegories: [MainFeed.Info.Model.OnGoingProjectFeedCriteria] = [.all, .connections]
                guard let cathegories = cathegories.cathegories else { return }
                defaultCathegories.append(contentsOf: cathegories.map( {
                    MainFeed.Info.Model.OnGoingProjectFeedCriteria.cathegory(MovieStyle(rawValue: $0) ?? .action)
                }))
                self.mainFeedData?.interestCathegories = MainFeed.Info.Model.UpcomingOnGoingProjectCriterias(selectedCriteria: self.buildMainFeedCathegory(), criterias: defaultCathegories)
                self.fetchFinishedProjectsLogicFeeds()
            case .error(let error):
                break
            }
        }
    }
    
    private func buildMainFeedCathegory() -> MainFeed.Info.Model.OnGoingProjectFeedCriteria{
        var criteria: MainFeed.Info.Model.OnGoingProjectFeedCriteria
        if selectedCathegory == MainFeed.Constants.Texts.allCriteria {
            criteria = .all
        } else if selectedCathegory == MainFeed.Constants.Texts.relativeToConnectionsCriteria {
            criteria = .connections
        } else {
            criteria = MainFeed.Info.Model.OnGoingProjectFeedCriteria.cathegory(MovieStyle(rawValue: selectedCathegory) ?? .action)
        }
        return criteria
    }
    
    private func fetchFinishedProjectsLogicFeeds() {
        mainFeedData?.finishedProjectsFeeds = MainFeed.Info.Model.UpcomingFinishedProjectsFeeds(feeds: .empty)
        fetchLogicFeed(.connections) { response in
            switch response {
            case .success(let data):
                self.mainFeedData?.finishedProjectsFeeds?.feeds.append(MainFeed.Info.Model.FinishedProjectFeed(criteria: MainFeed.Info.Model.FinishedProjectsFeedLogicCriteria.connections.rawValue, projects: data.map({ MainFeed.Info.Model.FinishedProject(id: $0.id ?? .empty, image: $0.image ?? .empty)})))
                self.fetchLogicFeed(.popular) { response in
                    switch response {
                    case .success(let data):
                        self.mainFeedData?.finishedProjectsFeeds?.feeds.append(MainFeed.Info.Model.FinishedProjectFeed(criteria: MainFeed.Info.Model.FinishedProjectsFeedLogicCriteria.popular.rawValue, projects: data.map({ MainFeed.Info.Model.FinishedProject(id: $0.id ?? .empty, image: $0.image ?? .empty)})))
                        self.fetchLogicFeed(.recentlyWatched) { response in
                            switch response {
                            case .success(let data):
                                self.mainFeedData?.finishedProjectsFeeds?.feeds.append(MainFeed.Info.Model.FinishedProjectFeed(criteria: MainFeed.Info.Model.FinishedProjectsFeedLogicCriteria.recentlyWatched.rawValue, projects: data.map({ MainFeed.Info.Model.FinishedProject(id: $0.id ?? .empty, image: $0.image ?? .empty)})))
                                self.fetchFinishedProjectsCathegoryFeeds()
                            case .error(_):
                                break
                            }
                        }
                    case .error(_):
                        break
                    }
                }
            case .error(_):
                break
            }
        }
    }
    
    private func fetchLogicFeed(_ criteria: MainFeed.Info.Model.FinishedProjectsFeedLogicCriteria,
                                completion: @escaping (BaseResponse<[MainFeed.Info.Response.FinishedProject]>) -> Void) {
        worker.fetchFinishedProjectsLogicFeed(MainFeed.Request.FinishedProjectsLogicFeed(criteria: criteria.rawValue), completion: completion)
    }
    
    private func fetchFinishedProjectsCathegoryFeeds() {
        if let interestCathegories = mainFeedData?.interestCathegories {
            let dispatchGroup = DispatchGroup()
            for cathegory in interestCathegories.criterias {
                dispatchGroup.enter()
                switch cathegory {
                case .cathegory(let style):
                    worker.fetchFinishedProjectsCathegoryFeed(MainFeed.Request.FinishedProjectsCathegoryFeed(cathegory: style.rawValue)) { response in
                        switch response {
                        case .success(let projects):
                            self.mainFeedData?.finishedProjectsFeeds?.feeds.append(MainFeed.Info.Model.FinishedProjectFeed(criteria: style.rawValue, projects: projects.map({ MainFeed.Info.Model.FinishedProject(id: $0.id ?? .empty, image: $0.image ?? .empty)})))
                            dispatchGroup.leave()
                        case .error(let error):
                            dispatchGroup.leave()
                        }
                    }
                default:
                    break
                }
            }
            dispatchGroup.notify(queue: .main) {
                guard let data = self.mainFeedData else { return }
                self.presenter.presentFeedData(data)
            }
        }
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
    
    func fetchMainFeed(_ request: MainFeed.Request.MainFeed) {
        fetchSuggestedProfiles(MainFeed.Request.FetchSuggestedProfiles())
    }
    
    func didSelectSuggestedProfile(_ request: MainFeed.Request.SelectSuggestedProfile) {
        selectedProfile = mainFeedData?.profileSuggestions?.suggestions[request.index].userId
        presenter.presentProfileDetails()
    }
    
    func didSelectOnGoingProject(_ request: MainFeed.Request.SelectOnGoingProject) {
        selectedProject = mainFeedData?.ongoingProjects?.projects[request.index].id
        presenter.presentOnGoingProjectDetails()
    }
    
    func didSelectOnGoingProjectCathegory(_ request: MainFeed.Request.SelectOnGoingProjectCathegory) {
        let newRequest = MainFeed.Request.FetchOnGoingProjects(fromConnections: request.text == MainFeed.Constants.Texts.relativeToConnectionsCriteria, cathegory: request.text)
        worker.fetchOnGoingProjects(newRequest) { response in
            switch response {
            case .success(let data):
                self.selectedCathegory = request.text
                self.mainFeedData?.ongoingProjects = MainFeed.Info.Model.UpcomingProjects(projects: data.map({
                    MainFeed.Info.Model.OnGoingProject(id: $0.id ?? .empty,
                                                       image: $0.image ?? .empty,
                                                       progress: $0.progress ?? 0)
                }))
                guard let data = self.mainFeedData else { return }
                self.presenter.presentFeedData(data)
            case .error(let error):
                break
            }
        }
    }
}
