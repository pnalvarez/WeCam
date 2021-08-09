//
//  FilterCathegoriesPresenter.swift
//  WeCam
//
//  Created by Pedro Alvarez on 18/04/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol FilterCathegoriesPresentationLogic {
    func presentLoading(_ loading: Bool)
    func presentError(_ response: FilterCathegories.Info.Model.Alert)
    func presentAllCathegories(_ response: FilterCathegories.Info.Model.CathegoryList)
    func presentSelectedCathegories(_ response: FilterCathegories.Info.Model.CathegoryList)
    func presentMainFeed()
    func presentLayoutFilterButton(_ enabled: Bool)
}

class FilterCathegoriesPresenter: FilterCathegoriesPresentationLogic {
    
    private unowned var viewController: FilterCathegoriesDisplayLogic
    
    private var allInterestCathegories: FilterCathegories.Info.Model.CathegoryList?
    
    init(viewController: FilterCathegoriesDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentLoading(_ loading: Bool) {
        viewController.defaultScreenLoading(!loading)
    }
    
    func presentError(_ response: FilterCathegories.Info.Model.Alert) {
        viewController.showAlertError(title: response.title,
                                      description: response.description,
                                      doneText: WCConstants.Strings.ok)
    }
    
    func presentAllCathegories(_ response: FilterCathegories.Info.Model.CathegoryList) {
        self.allInterestCathegories = response
        let viewModel = FilterCathegories.Info.ViewModel.InterestCathegoryList(cathegories: response.cathegories.map({ $0.rawValue }))
        viewController.displayAllCathegories(viewModel)
    }
    
    func presentSelectedCathegories(_ response: FilterCathegories.Info.Model.CathegoryList) {
        var indexes = [Int]()
        for cathegory in response.cathegories {
            if let index = allInterestCathegories?.cathegories.firstIndex(where: { $0 == cathegory}) {
                indexes.append(index)
            }
        }
        let viewModel = FilterCathegories.Info.ViewModel.SelectedCathegoryList(indexes: indexes)
        viewController.displaySelectedCathegories(viewModel)
    }
    
    func presentMainFeed() {
        viewController.displayMainFeed()
    }
    
    func presentLayoutFilterButton(_ enabled: Bool) {
        viewController.displayLayoutFilterButton(enabled)
    }
}
