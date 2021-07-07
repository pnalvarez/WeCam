//
//  FilterCathegoriesInteractor.swift
//  WeCam
//
//  Created by Pedro Alvarez on 18/04/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

protocol FilterCathegoriesBusinessLogic {
    func fetchInterestCathegories(_ request: FilterCathegories.Request.FetchInterestCathegories)
    func selectCathegory(_ request: FilterCathegories.Request.SelectCathegory)
    func filterCathegories(_ request: FilterCathegories.Request.Filter)
}

protocol FilterCathegoriesDataStore {
    var interestCathegories: FilterCathegories.Info.Model.CathegoryList? { get }
    var selectedCathegories: FilterCathegories.Info.Model.CathegoryList? { get }
}

class FilterCathegoriesInteractor: FilterCathegoriesDataStore {
    
    private let worker: FilterCathegoriesWorkerProtocol
    private let presenter: FilterCathegoriesPresentationLogic
    
    var interestCathegories: FilterCathegories.Info.Model.CathegoryList?
    var selectedCathegories: FilterCathegories.Info.Model.CathegoryList?
    
    private var initialSelectedCathegories: FilterCathegories.Info.Model.CathegoryList?
    
    init(worker: FilterCathegoriesWorkerProtocol = FilterCathegoriesWorker(),
         presenter: FilterCathegoriesPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
    
    private func fetchSelectedCathegories() {
        worker.fetchSelectedCathegories(FilterCathegories.Request.FetchSelectedCathegories()) { response in
            self.presenter.presentLoading(false)
            switch response {
            case .success(let data):
                guard let cathegories = data.cathegories else { return }
                let parsedCathegories = FilterCathegories.Info.Model.CathegoryList(cathegories: cathegories.map({ (WCMovieStyle(rawValue: $0) ?? .action)}))
                self.selectedCathegories = parsedCathegories
                self.initialSelectedCathegories = parsedCathegories
                guard let selectedCathegories = self.selectedCathegories else { return }
                self.presenter.presentSelectedCathegories(selectedCathegories)
            case .error(let error):
                self.presenter.presentAlert(FilterCathegories.Info.Model.Alert(title: "Erro",
                                                                               description: error.description))
            }
        }
    }
}

extension FilterCathegoriesInteractor: FilterCathegoriesBusinessLogic {
    
    func fetchInterestCathegories(_ request: FilterCathegories.Request.FetchInterestCathegories) {
        presenter.presentLoading(true)
        worker.fetchInterestCathegories(request) { response in
            switch response {
            case .success(let data):
                guard let cathegories = data.cathegories else { return }
                self.interestCathegories = FilterCathegories.Info.Model.CathegoryList(cathegories: cathegories.map({ (WCMovieStyle(rawValue: $0) ?? .action)}))
                guard let allCathegories = self.interestCathegories else { return }
                self.presenter.presentAllCathegories(allCathegories)
                self.fetchSelectedCathegories()
            case .error(let error):
                self.presenter.presentLoading(false)
                self.presenter.presentAlert(FilterCathegories.Info.Model.Alert(title: "Erro",
                                                                               description: error.description))
            }
        }
    }
    
    func selectCathegory(_ request: FilterCathegories.Request.SelectCathegory) {
        guard let interestCathegories = interestCathegories,
              let selectedCathegories = selectedCathegories else { return }
        let cathegory = interestCathegories.cathegories[request.index]
        if selectedCathegories.cathegories.contains(cathegory) {
            self.selectedCathegories?.cathegories.removeAll(where: { $0 == cathegory })
        } else {
            self.selectedCathegories?.cathegories.append(cathegory)
        }
        self.initialSelectedCathegories?.cathegories.sort(by: { $0.rawValue > $1.rawValue })
        self.selectedCathegories?.cathegories.sort(by: { $0.rawValue > $1.rawValue })
        presenter.presentLayoutFilterButton(self.selectedCathegories != self.initialSelectedCathegories)
    }
    
    func filterCathegories(_ request: FilterCathegories.Request.Filter) {
        presenter.presentLoading(true)
        guard let selectedCathegories = selectedCathegories else { return }
        worker.filterCathegories(FilterCathegories.Request.FilterCathegories(cathegories: selectedCathegories.cathegories.map({ $0.rawValue }))) { response in
            self.presenter.presentLoading(false)
            switch response {
            case .success:
                self.presenter.presentMainFeed()
            case .error(let error):
                self.presenter.presentAlert(FilterCathegories.Info.Model.Alert(title: "Erro",
                                                                               description: error.description))
            }
        }
    }
}
