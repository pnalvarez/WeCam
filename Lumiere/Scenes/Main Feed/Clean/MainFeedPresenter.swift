//
//  MainFeedPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol MainFeedPresentationLogic {
    func presentSearchResults()
    func presentProfileSuggestions(_ response: MainFeed.Info.Model.UpcomingProfiles)
    func presentProfileDetails()
    func presentAllProfileSuggestions()
}

class MainFeedPresenter: MainFeedPresentationLogic {
    
    private unowned var viewController: MainFeedDisplayLogic
    
    init(viewController: MainFeedDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentSearchResults() {
        viewController.displaySearchResults()
    }
    
    func presentProfileSuggestions(_ response: MainFeed.Info.Model.UpcomingProfiles) {
        let viewModel = MainFeed.Info.ViewModel.UpcomingProfiles(suggestions: response.suggestions.map({ MainFeed.Info.ViewModel.ProfileSuggestion(image: $0.image, name: $0.name, ocupation: $0.ocupation) }))
        viewController.displayProfileSuggestions(viewModel)
    }
    
    func presentProfileDetails() {
        viewController.displayProfileDetails()
    }
    
    func presentAllProfileSuggestions() {
        viewController.displayAllProfileSuggestions()
    }
}
