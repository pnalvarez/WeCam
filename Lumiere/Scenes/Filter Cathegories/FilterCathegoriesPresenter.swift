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
    func presentAlert(_ response: FilterCathegories.Info.Model.Alert)
    func presentAllCathegories(_ response: FilterCathegories.Info.Model.CathegoryList)
    func presentSelectedCathegories(_ response: FilterCathegories.Info.Model.CathegoryList)
    func presentMainFeed()
}

class FilterCathegoriesPresenter: FilterCathegoriesPresentationLogic {
    
    private unowned var viewController: FilterCathegoriesDisplayLogic
    
    private var allInterestCathegories: FilterCathegories.Info.Model.CathegoryList?
    
    init(viewController: FilterCathegoriesDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentLoading(_ loading: Bool) {
        
    }
    
    func presentAlert(_ response: FilterCathegories.Info.Model.Alert) {
        
    }
    
    func presentAllCathegories(_ response: FilterCathegories.Info.Model.CathegoryList) {
        
    }
    
    func presentSelectedCathegories(_ response: FilterCathegories.Info.Model.CathegoryList) {
        
    }
    
    func presentMainFeed() {
        
    }
}
