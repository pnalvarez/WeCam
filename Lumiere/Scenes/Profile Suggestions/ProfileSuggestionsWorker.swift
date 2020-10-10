//
//  ProfilesSuggestionsWorker.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 10/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol ProfileSuggestionsWorkerProtocol {
    
}

class ProfileSuggestionsWorker: ProfileSuggestionsWorkerProtocol {
    
    private let builder: FirebaseManagerProtocol
    
    init(builder: FirebaseManagerProtocol = FirebaseManager()) {
        self.builder = builder
    }
}
