//
//  SearchResultsPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 29/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol SearchResultsPresentationLogic {
    func presentLoading(_ loading: Bool)
    func presentResults(_ response: SearchResults.Info.Model.Results)
    func presentProfileDetails()
    func presentOnGoingProjectDetails()
    func presentFinishedProjectDetails()
    func presentError(_ response: SearchResults.Info.Model.ResultError)
    func presentResultTypes(_ response: SearchResults.Info.Model.UpcomingTypes)
}

class SearchResultsPresenter: SearchResultsPresentationLogic {
    
    private unowned var viewController: SearchResultsDisplayLogic
    
    init(viewController: SearchResultsDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentLoading(_ loading: Bool) {
        viewController.defaultScreenLoading(!loading)
    }
    
    func presentResults(_ response: SearchResults.Info.Model.Results) {
        let viewModel = SearchResults.Info.ViewModel.UpcomingResults(users: mapUsers(response.users), projects: mapProjects(response.projects))
        viewController.displaySearchResults(viewModel)
    }
    
    func presentProfileDetails() {
        viewController.displayProfileDetails()
    }
    
    func presentOnGoingProjectDetails() {
        viewController.displayOnGoingProjectDetails()
    }
    
    func presentFinishedProjectDetails() {
        viewController.displayFinishedProjectDetails()
    }
    
    func presentError(_ response: SearchResults.Info.Model.ResultError) {
        let viewModel = SearchResults.Info.ViewModel.ResultError(error: response.error.description)
        viewController.displayError(viewModel)
    }
    
    func presentResultTypes(_ response: SearchResults.Info.Model.UpcomingTypes) {
        let viewModel = SearchResults.Info.ViewModel.UpcomingTypes(types: response.types.map({ SearchResults.Info.ViewModel.ResultType(text: $0.rawValue) }))
        viewController.displayResultTypes(viewModel)
    }
}

extension SearchResultsPresenter {
    
    private func mapUsers(_ model: [SearchResults.Info.Model.Profile]) -> [SearchResults.Info.ViewModel.Profile] {
        var viewModel = [SearchResults.Info.ViewModel.Profile]()
        for index in 0..<model.count {
            viewModel.append(SearchResults.Info.ViewModel.Profile(offset: index,
                                                                  name: model[index].name,
                                                                  ocupation: model[index].ocupation,
                                                                  image: model[index].image))
        }
        return viewModel
    }
    
    private func mapProjects(_ model: [SearchResults.Info.Model.Project]) -> [SearchResults.Info.ViewModel.Project] {
        var viewModel = [SearchResults.Info.ViewModel.Project]()
        for index in 0..<model.count {
            var secondCathegory: String
            if let secondCathegoryStr = model[index].secondCathegory {
                secondCathegory = .space + .comma + .space + secondCathegoryStr
            } else {
                secondCathegory = .empty
            }
            viewModel.append(SearchResults.Info.ViewModel.Project(offset: index,
                                                                  title: model[index].title,
                                                                  cathegories: model[index].firstCathegory + secondCathegory,
                                                                  progress: "\(model[index].progress)  %", image: model[index].image))
        }
        return viewModel
    }
}
