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
    func presentProjectDetails()
    func presentError(_ response: SearchResults.Info.Model.ResultError)
}

class SearchResultsPresenter: SearchResultsPresentationLogic {
    
    private unowned var viewController: SearchResultsDisplayLogic
    
    init(viewController: SearchResultsDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentLoading(_ loading: Bool) {
        viewController.displayLoading(loading)
    }
    
    func presentResults(_ response: SearchResults.Info.Model.Results) {
        let viewModel = SearchResults.Info.ViewModel.UpcomingResults(users: mapUsers(response.users), projects: mapProjects(response.projects))
        viewController.displaySearchResults(viewModel)
    }
    
    func presentProfileDetails() {
        viewController.displayProfileDetails()
    }
    
    func presentProjectDetails() {
        viewController.displayProjectDetails()
    }
    
    func presentError(_ response: SearchResults.Info.Model.ResultError) {
        let viewModel = SearchResults.Info.ViewModel.ResultError(error: response.error.localizedDescription)
        viewController.displayError(viewModel)
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
                                                                  progress: "\(model[index].progress) %", image: model[index].image))
        }
        return viewModel
    }
}
