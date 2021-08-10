//
//  RecentSearchPresenter.swift
//  WeCam
//
//  Created by Pedro Alvarez on 13/03/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol RecentSearchPresentationLogic {
    func presentLoading(_ loading: Bool)
    func presentError(_ response: RecentSearch.Info.Model.Error)
    func presentRecentSearches(_ response: RecentSearch.Info.Model.UpcomingResults)
    func presentProfileDetails()
    func presentOngoingProjectDetails()
    func presentFinishedProjectDetails()
    func presentSearchResults()
}

class RecentSearchPresenter: RecentSearchPresentationLogic {
    
    private unowned var viewController: RecentSearchDisplayLogic
    
    init(viewController: RecentSearchDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentLoading(_ loading: Bool) {
        viewController.defaultScreenLoading(!loading)
    }
    
    func presentError(_ response: RecentSearch.Info.Model.Error) {
        viewController.showAlertError(title: response.title,
                                      description: response.message)
    }
    
    func presentRecentSearches(_ response: RecentSearch.Info.Model.UpcomingResults) {
        let viewModel = RecentSearch.Info.ViewModel.UpcomingResults(searches: response.results.map({ result in
            switch result {
            case .user(let user):
                return RecentSearch.Info.ViewModel.Search(image: user.image, name: user.name, secondaryInfo: user.ocupation)
            case .project(let project):
                var secondaryInfo: String = "\(project.firstCathegory)"
                if let secondCathegory = project.secondCathegory {
                    secondaryInfo += "/ \(secondCathegory)"
                }
                return RecentSearch.Info.ViewModel.Search(image: project.image, name: project.title, secondaryInfo: secondaryInfo)
            }
        }))
        viewController.displayRecentSearches(viewModel)
    }
    
    func presentProfileDetails() {
        viewController.displayProfileDetails()
    }
    
    func presentOngoingProjectDetails() {
        viewController.displayOnGoingProjectDetails()
    }
    
    func presentFinishedProjectDetails() {
        viewController.displayFinishedProjectDetails()
    }
    
    func presentSearchResults() {
        viewController.displaySearchResults()
    }
}
