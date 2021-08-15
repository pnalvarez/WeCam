//
//  MainFeedPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol MainFeedPresentationLogic: PresenterInterface {
    func presentProfileDetails()
    func presentOnGoingProjectDetails()
    func presentFinishedProjectDetails()
    func presentError(_ response: MainFeed.Info.Model.Error)
    func presentFeedData(_ response: MainFeed.Info.Model.UpcomingFeedData)
}

class MainFeedPresenter: MainFeedPresentationLogic {
    
    private unowned var viewController: MainFeedDisplayLogic
    
    init(viewController: MainFeedDisplayLogic) {
        self.viewController = viewController
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
                                                           progress: Float($0.progress)/WCConstants.Floats.hundredPercent)
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
                                                  }) ?? .empty ),
            finishedProjects: mapFinishedProjectsFeeds(response.finishedProjectsFeeds))
        viewController.displayFeedData(viewModel)
    }
    
    func presentError(_ response: MainFeed.Info.Model.Error) {
        viewController.displayErrorView(withMessage: response.message)
    }
    
    func presentFinishedProjectDetails() {
        viewController.displayFinishedProjectDetails()
    }
    
    func presentLoading(_ loading: Bool) {
        viewController.defaultScreenLoading(!loading)
    }
    
    private func mapFinishedProjectsFeeds(_ input: MainFeed.Info.Model.UpcomingFinishedProjectsFeeds?) -> MainFeed.Info.ViewModel.UpcomingFinishedProjectsFeeds {
        var feedsViewModel = [MainFeed.Info.ViewModel.FinishedProjectFeed]()
        guard let input = input else { return MainFeed.Info.ViewModel.UpcomingFinishedProjectsFeeds(feeds: .empty)}
        for feed in input.feeds {
            var projects = [MainFeed.Info.ViewModel.FinishedProject]()
            for project in feed.projects {
                projects.append(MainFeed
                                    .Info
                                    .ViewModel
                                    .FinishedProject(image: project.image))
            }
            feedsViewModel.append(MainFeed
                                    .Info
                                    .ViewModel
                                    .FinishedProjectFeed(criteria: feed.criteria,
                                                         projects: projects))
        }
        return MainFeed.Info.ViewModel.UpcomingFinishedProjectsFeeds(feeds: feedsViewModel)
    }
}
