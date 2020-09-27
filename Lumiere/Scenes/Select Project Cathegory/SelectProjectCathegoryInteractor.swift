//
//  SelectProjectCathegoryInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol SelectProjectCathegoryBusinessLogic {
    func fetchAllCathegories(_ request: SelectProjectCathegory.Request.AllCathegories)
    func fetchSelectCathegory(_ request: SelectProjectCathegory.Request.SelectCathegory)
    func fetchAdvance(_ request: SelectProjectCathegory.Request.Advance)
}

protocol SelectProjectCathegoryDataStore {
    var projectData: SelectProjectCathegory.Info.Received.Project? { get set }
    var selectedCathegories: SelectProjectCathegory.Info.Model.SelectedCathegories? { get set }
    var allCathegories: SelectProjectCathegory.Info.Model.InterestCathegories? { get set }
}

class SelectProjectCathegoryInteractor: SelectProjectCathegoryDataStore {
    
    private let worker: SelectProjectCathegoryWorkerProtocol
    private let presenter: SelectProjectCathegoryPresentationLogic
    
    var projectData: SelectProjectCathegory.Info.Received.Project?
    var selectedCathegories: SelectProjectCathegory.Info.Model.SelectedCathegories?
    var allCathegories: SelectProjectCathegory.Info.Model.InterestCathegories?
    
    init(worker: SelectProjectCathegoryWorkerProtocol = SelectProjectCathegoryWorker(),
         presenter: SelectProjectCathegoryPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
        self.selectedCathegories = SelectProjectCathegory.Info.Model.SelectedCathegories(firstCathegory: nil,
                                                                                         secondCathegory: nil)
    }
}

extension SelectProjectCathegoryInteractor: SelectProjectCathegoryBusinessLogic {
    
    func fetchAllCathegories(_ request: SelectProjectCathegory.Request.AllCathegories) {
        allCathegories = SelectProjectCathegory
            .Info
            .Model
            .InterestCathegories(cathegories: MovieStyle.toArray().map({ SelectProjectCathegory.Info.Model.Cathegory(cathegory: $0, selected: false)}))
        guard let cathegories = allCathegories else { return }
        presenter.presentAllCathegories(cathegories)
    }
    
    func fetchSelectCathegory(_ request: SelectProjectCathegory.Request.SelectCathegory) {
        if selectedCathegories?.firstCathegory == request.cathegory ||
            selectedCathegories?.secondCathegory == request.cathegory {
            guard let index = allCathegories?.cathegories.firstIndex(where: { $0.cathegory == request.cathegory }) else {
                return
            }
            allCathegories?.cathegories[index].selected = false
            if selectedCathegories?.firstCathegory == request.cathegory {
                selectedCathegories?.firstCathegory = nil
            } else{
                selectedCathegories?.secondCathegory = nil
            }
        } else if selectedCathegories?.firstCathegory != nil && selectedCathegories?.secondCathegory != nil {
            presenter.presentError(SelectProjectCathegory
                .Info
                .Errors
                .SelectionError(title: SelectProjectCathegory.Constants.Texts.defaultErrorTitle,
                                message: SelectProjectCathegory.Constants.Texts.failureToSelectMessage))
        } else {
            guard let index = allCathegories?.cathegories.firstIndex(where: { $0.cathegory == request.cathegory }) else {
                return
            }
            allCathegories?.cathegories[index].selected = true
            if selectedCathegories?.firstCathegory == nil {
                selectedCathegories?.firstCathegory = request.cathegory
            } else if selectedCathegories?.secondCathegory == nil {
                selectedCathegories?.secondCathegory = request.cathegory
            }
        }
        guard let cathegories = allCathegories else { return }
        presenter.presentAllCathegories(cathegories)
    }
    
    func fetchAdvance(_ request: SelectProjectCathegory.Request.Advance) {
        guard selectedCathegories?.firstCathegory != nil ||
            selectedCathegories?.secondCathegory != nil else {
                presenter.presentError(SelectProjectCathegory
                    .Info
                    .Errors
                    .SelectionError(title: SelectProjectCathegory.Constants.Texts.defaultErrorTitle,
                                    message: SelectProjectCathegory.Constants.Texts.noCathegorySelectedErrorMessage))
                return 
        }
        presenter.presentProjectProgress()
    }
}
