//
//  ProfileSuggestionsPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 10/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol ProfileSuggestionsPresentationLogic {
    func presentProfileSuggestions(_ response: ProfileSuggestions.Info.Model.UpcomingSuggestions)
    func presentProfileDetails()
    func presentFadeItem(_ response: ProfileSuggestions.Info.Model.ProfileFade)
    func presentError(_ response: ProfileSuggestions.Info.Model.ProfileSuggestionsError)
    func presentLoading(_ loading: Bool)
    func presentCriterias(_ response: ProfileSuggestions.Info.Model.UpcomingCriteria)
}

class ProfileSuggestionsPresenter: ProfileSuggestionsPresentationLogic {
    
    private unowned var viewController: ProfileSuggestionsDisplayLogic
    
    init(viewController: ProfileSuggestionsDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentProfileSuggestions(_ response: ProfileSuggestions.Info.Model.UpcomingSuggestions) {
        let viewModel = ProfileSuggestions
            .Info
            .ViewModel
            .UpcomingSuggestions(profiles: response.profiles.map({ ProfileSuggestions
                                                                    .Info
                                                                    .ViewModel
                                                                    .Profile(name: $0.name,
                                                                             image: $0.image,
                                                                             ocupation: $0.ocupation) }))
        viewController.displayProfileSuggestions(viewModel)
    }
    
    func presentProfileDetails() {
        viewController.displayProfileDetails()
    }
    
    func presentFadeItem(_ response: ProfileSuggestions.Info.Model.ProfileFade) {
        let viewModel = ProfileSuggestions.Info.ViewModel.ProfileItemToFade(index: response.index)
        viewController.fadeProfileItem(viewModel)
    }
    
    func presentError(_ response: ProfileSuggestions.Info.Model.ProfileSuggestionsError) {
        let viewModel = ProfileSuggestions.Info.ViewModel.ProfileSuggestionsError(error: response.error.description)
        viewController.displayError(viewModel)
    }
    
    func presentLoading(_ loading: Bool) {
        viewController.displayLoading(loading)
    }
    
    func presentCriterias(_ response: ProfileSuggestions.Info.Model.UpcomingCriteria) {
        let viewModel = ProfileSuggestions.Info.ViewModel.UpcomingCriteria(selectedCriteria: response.selectedCriteria.rawValue, criterias: response.criterias.map({ $0.rawValue }))
        viewController.displayCriterias(viewModel)
    }
}
