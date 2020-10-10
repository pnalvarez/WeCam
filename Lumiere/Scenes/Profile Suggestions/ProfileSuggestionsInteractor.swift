//
//  ProfileSuggestionsInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 10/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol ProfileSuggestionsBusinessLogic {
    
}

protocol ProfileSuggestionsDataStore {
    
}

class ProfileSuggestionsInteractor: ProfileSuggestionsDataStore {
    
    private let worker: ProfileSuggestionsWorkerProtocol
    private let presenter: ProfileSuggestionsPresentationLogic
    
    init(worker: ProfileSuggestionsWorkerProtocol = ProfileSuggestionsWorker(),
         presenter: ProfileSuggestionsPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
}

extension ProfileSuggestionsInteractor: ProfileSuggestionsBusinessLogic {
    
}
