//
//  ProjectStepsPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 14/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol ProjectStepPresentationLogic {
    func didFetchValueChanged()
    func didFetchAdvance()
}

class ProjectStepPresenter: ProjectStepPresentationLogic {
    
    private unowned var viewController: ProjectStepsDisplayLogic
    
    init(viewController: ProjectStepsDisplayLogic) {
        self.viewController = viewController
    }
    
    func didFetchValueChanged() {
        viewController.displayRotateSliderThumbImage()
    }
    
    func didFetchAdvance() {
        viewController.displayAdvance()
    }
}
