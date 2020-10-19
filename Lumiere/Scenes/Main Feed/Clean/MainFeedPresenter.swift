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
    func presentOnGoingProjects(_ response: MainFeed.Info.Model.UpcomingProjects)
    func presentOnGoingProjectDetails()
    func presentOnGoingProjectsFeedCriterias(_ response: MainFeed.Info.Model.UpcomingOnGoingProjectCriterias)
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
    
    func presentOnGoingProjects(_ response: MainFeed.Info.Model.UpcomingProjects) {
        let viewModel = MainFeed.Info.ViewModel.UpcomingProjects(projects: response.projects.map({ MainFeed.Info.ViewModel.OnGoingProject(image: $0.image, progress: Float($0.progress) / 100)}))
        viewController.displayOnGoingProjectsFeed(viewModel)
    }
    
    func presentOnGoingProjectDetails() {
        viewController.displayOnGoingProjectDetails()
    }
    
    func presentOnGoingProjectsFeedCriterias(_ response: MainFeed.Info.Model.UpcomingOnGoingProjectCriterias) {
        let viewModel = MainFeed.Info.ViewModel.UpcomingOnGoingProjectsCriterias(selectedCriteria: MainFeed.Info.ViewModel.OnGoingProjectFeedCriteria(criteria: response.selectedCriteria.mapToString()), criterias: response.criterias.map({ MainFeed.Info.ViewModel.OnGoingProjectFeedCriteria(criteria: $0.mapToString())}))
        viewController.displayOnGoingProjectsCriterias(viewModel)
    }
}
