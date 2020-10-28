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
    func presentProfileDetails()
    func presentOnGoingProjectDetails()
    func presentFeedData(_ response: MainFeed.Info.Model.UpcomingFeedData)
}

class MainFeedPresenter: MainFeedPresentationLogic {
    
    private unowned var viewController: MainFeedDisplayLogic
    
    init(viewController: MainFeedDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentSearchResults() {
        viewController.displaySearchResults()
    }
    
    func presentProfileDetails() {
        viewController.displayProfileDetails()
    }
    func presentOnGoingProjectDetails() {
        viewController.displayOnGoingProjectDetails()
    }
    
    func presentFeedData(_ response: MainFeed.Info.Model.UpcomingFeedData) {
        let viewModel = MainFeed
            .Info
            .ViewModel
            .UpcomingFeedData(suggestedProfiles: MainFeed.Info.ViewModel.UpcomingProfiles(suggestions: response.profileSuggestions?.suggestions.map({
                MainFeed
                    .Info
                    .ViewModel
                    .ProfileSuggestion(image: $0.image,
                                       name: $0.name,
                                       ocupation: $0.ocupation)
            }) ?? .empty),
            ongoingProjects: MainFeed
                .Info
                .ViewModel
                .UpcomingProjects(projects: response.ongoingProjects?.projects.map({
                    MainFeed.Info.ViewModel.OnGoingProject(image: $0.image,
                                                           progress: Float($0.progress)/100)
                }) ?? .empty),
            interestCathegories: MainFeed
                .Info
                .ViewModel
                .UpcomingOnGoingProjectsCriterias(selectedCriteria: MainFeed
                                                    .Info
                                                    .ViewModel
                                                    .OnGoingProjectFeedCriteria(criteria: response.interestCathegories?.selectedCriteria.mapToString() ?? .empty),
                                                  criterias: response.interestCathegories?.criterias.map({
                                                    MainFeed.Info.ViewModel.OnGoingProjectFeedCriteria(criteria: $0.mapToString())
                                                  }) ?? .empty ))
        viewController.displayFeedData(viewModel)
    }
}
