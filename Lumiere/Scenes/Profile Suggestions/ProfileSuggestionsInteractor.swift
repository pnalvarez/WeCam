//
//  ProfileSuggestionsInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 10/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol ProfileSuggestionsBusinessLogic {
    func fetchProfileSuggestions(_ request: ProfileSuggestions.Request.FetchProfileSuggestions)
    func fetchAddUser(_ request: ProfileSuggestions.Request.AddUser)
    func fetchRemoveUser(_ request: ProfileSuggestions.Request.RemoveUser)
    func didSelectProfile(_ request: ProfileSuggestions.Request.SelectProfile)
    func didChangeCriteria(_ request: ProfileSuggestions.Request.ChangeCriteria)
}

protocol ProfileSuggestionsDataStore {
    var suggestionCriteria: ProfileSuggestions.Info.Model.SuggestionsCriteria { get set }
    var selectedProfile: String? { get }
    var profileSuggestions: ProfileSuggestions.Info.Model.UpcomingSuggestions? { get }
}

class ProfileSuggestionsInteractor: ProfileSuggestionsDataStore {
    
    private let worker: ProfileSuggestionsWorkerProtocol
    private let presenter: ProfileSuggestionsPresentationLogic
    
    var suggestionCriteria: ProfileSuggestions.Info.Model.SuggestionsCriteria = .commonFriends
    var selectedProfile: String?
    var profileSuggestions: ProfileSuggestions.Info.Model.UpcomingSuggestions?
    
    init(worker: ProfileSuggestionsWorkerProtocol = ProfileSuggestionsWorker(),
         presenter: ProfileSuggestionsPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
}

extension ProfileSuggestionsInteractor {
    
    private func fetchCommonConnectionsSuggestions() {
        worker.fetchCommonConnectionsProfileSuggestions(ProfileSuggestions.Request.FetchCommonConnectionsProfileSuggestions(limit: ProfileSuggestions.Constants.BusinessLogic.suggestionsLimit)) { response in
            switch response {
            case .success(let data):
                self.presenter.presentLoading(false)
                self.profileSuggestions = ProfileSuggestions
                    .Info
                    .Model
                    .UpcomingSuggestions(profiles: data.map({ return ProfileSuggestions
                                                                .Info
                                                                .Model
                                                                .Profile(id: $0.id ?? .empty,
                                                                         name: $0.name ?? .empty,
                                                                         image: $0.image ?? .empty,
                                                                         ocupation: $0.ocupation ?? .empty)}))
                guard let suggestions = self.profileSuggestions else { return }
                self.presenter.presentProfileSuggestions(suggestions)
            case .error(let error):
                self.presenter.presentLoading(false)
            }
        }
    }
    
    private func fetchCommonProjectsSuggestions() {
        worker.fetchCommonProjectsProfileSuggestions(ProfileSuggestions.Request.FetchCommonProjectsProfileSuggestions(limit: ProfileSuggestions.Constants.BusinessLogic.suggestionsLimit)) { response in
            switch response {
            case .success(let data):
                self.presenter.presentLoading(false)
                self.profileSuggestions = ProfileSuggestions
                    .Info
                    .Model
                    .UpcomingSuggestions(profiles: data.map({ return ProfileSuggestions
                                                                .Info
                                                                .Model
                                                                .Profile(id: $0.id ?? .empty,
                                                                         name: $0.name ?? .empty,
                                                                         image: $0.image ?? .empty,
                                                                         ocupation: $0.ocupation ?? .empty)}))
                guard let suggestions = self.profileSuggestions else { return }
                self.presenter.presentProfileSuggestions(suggestions)
            case .error(let error):
                self.presenter.presentLoading(false)
            }
        }
    }
    
    private func fetchCommonCathegoriesSuggestions() {
        worker.fetchCommonCathegoriesProfileSuggestions(ProfileSuggestions.Request.FetchCommonCathegoriesProfileSuggestions(limit: ProfileSuggestions.Constants.BusinessLogic.suggestionsLimit)) { response in
            switch response {
            case .success(let data):
                self.presenter.presentLoading(false)
                self.profileSuggestions = ProfileSuggestions
                    .Info
                    .Model
                    .UpcomingSuggestions(profiles: data.map({ return ProfileSuggestions
                                                                .Info
                                                                .Model
                                                                .Profile(id: $0.id ?? .empty,
                                                                         name: $0.name ?? .empty,
                                                                         image: $0.image ?? .empty,
                                                                         ocupation: $0.ocupation ?? .empty)}))
                guard let suggestions = self.profileSuggestions else { return }
                self.presenter.presentProfileSuggestions(suggestions)
            case .error(let error):
                self.presenter.presentLoading(false)
            }
        }
    }
}

extension ProfileSuggestionsInteractor: ProfileSuggestionsBusinessLogic {
    
    func fetchProfileSuggestions(_ request: ProfileSuggestions.Request.FetchProfileSuggestions) {
        presenter.presentLoading(true)
        switch suggestionCriteria {
        case .commonFriends:
            fetchCommonConnectionsSuggestions()
        case .commonProjects:
            fetchCommonProjectsSuggestions()
        case .commonInterestCathegories:
            fetchCommonCathegoriesSuggestions()
        }
    }
    
    func fetchAddUser(_ request: ProfileSuggestions.Request.AddUser) {
        guard let id = profileSuggestions?.profiles[request.index].id else { return }
        presenter.presentFadeItem(ProfileSuggestions
                                    .Info
                                    .Model
                                    .ProfileFade(index: request.index))
        worker.fetchSendConnectionRequest(ProfileSuggestions
                                            .Request
                                            .AddUserWithId(userId: id)) { response in
            switch response {
            case .success:
                self.profileSuggestions?.profiles.removeAll(where: { $0.id == id })
            case .error(let error):
                break
            }
        }
    }
    
    func fetchRemoveUser(_ request: ProfileSuggestions.Request.RemoveUser) {
        guard let id = profileSuggestions?.profiles[request.index].id else { return }
        worker.fetchRemoveProfileSuggestion(ProfileSuggestions
                                                .Request
                                                .RemoveUserWithId(userId: id)) { response in
            switch response {
            case .success:
                self.profileSuggestions?.profiles.removeAll(where: { $0.id == id })
            case .error(let error):
                break
            }
        }
    }
    
    func didSelectProfile(_ request: ProfileSuggestions.Request.SelectProfile) {
        selectedProfile = profileSuggestions?.profiles[request.index].id
        presenter.presentProfileDetails()
    }
    
    func didChangeCriteria(_ request: ProfileSuggestions.Request.ChangeCriteria) {
        self.presenter.presentLoading(true)
        guard let criteria = ProfileSuggestions.Info.Model.SuggestionsCriteria(rawValue: request.criteria) else { return }
        suggestionCriteria = criteria
        switch suggestionCriteria {
        case .commonFriends:
            fetchCommonConnectionsSuggestions()
        case .commonProjects:
            fetchCommonProjectsSuggestions()
        case .commonInterestCathegories:
            fetchCommonCathegoriesSuggestions()
        }
    }
}
