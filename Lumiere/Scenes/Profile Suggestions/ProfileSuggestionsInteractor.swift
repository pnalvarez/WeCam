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

extension ProfileSuggestionsInteractor: ProfileSuggestionsBusinessLogic {
    
    func fetchProfileSuggestions(_ request: ProfileSuggestions.Request.FetchProfileSuggestions) {
        
    }
    
    func fetchAddUser(_ request: ProfileSuggestions.Request.AddUser) {
        
    }
    
    func fetchRemoveUser(_ request: ProfileSuggestions.Request.RemoveUser) {
        
    }
    
    func didSelectProfile(_ request: ProfileSuggestions.Request.SelectProfile) {
        
    }
    
    func didChangeCriteria(_ request: ProfileSuggestions.Request.ChangeCriteria) {
        
    }
}
