//
//  ProjectStepsInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 14/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol ProjectStepBusinessLogic {
    func fetchSliderChanged()
    func fetchAvance()
}

protocol ProjectStepDataStore {
    
}

class ProjectStepInteractor: ProjectStepDataStore {
    
    private var presenter: ProjectStepPresentationLogic
    private var worker: ProjectStepWorkerProtocol
    
    init(viewController: ProjectStepsDisplayLogic) {
        self.presenter = ProjectStepPresenter(viewController: viewController)
        self.worker = ProjectStepWorker()
    }
}

extension ProjectStepInteractor: ProjectStepBusinessLogic {
    
    func fetchSliderChanged() {
        presenter.didFetchValueChanged()
    }
    
    func fetchAvance() {
        
    }
}
