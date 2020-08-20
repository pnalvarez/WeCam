//
//  SelectProjectCathegoryPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol SelectProjectCathegoryPresentationLogic {
    func presentAllCathegories(_ response: SelectProjectCathegory.Info.Model.InterestCathegories)
    func presentProjectProgress()
    func presentFailureToSelect()
}

class SelectProjectCathegoryPresenter: SelectProjectCathegoryPresentationLogic {
    
    private unowned var viewController: SelectProjectCathegoryDisplayLogic
    
    init(viewController: SelectProjectCathegoryDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentAllCathegories(_ response: SelectProjectCathegory.Info.Model.InterestCathegories) {
        viewController.displayAllCathegories(response)
    }
    
    func presentProjectProgress() {
        
    }
    
    func presentFailureToSelect() {
        viewController.displayFailureToSelect()
    }
}
