//
//  FilterCathegoriesWorker.swift
//  WeCam
//
//  Created by Pedro Alvarez on 17/04/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

protocol FilterCathegoriesWorkerProtocol {
    func fetchSelectedCathegories(_ request: FilterCathegories.Request.FetchSelectedCathegories,
                                  completion: @escaping (BaseResponse<FilterCathegories.Info.Response.SelectedCathegories>) -> Void)
    func filterCathegories(_ request: FilterCathegories.Request.FilterCathegories,
                           completion: @escaping (EmptyResponse) -> Void)
}

class FilterCathegoriesWorker: FilterCathegoriesWorkerProtocol {
    
    private let builder: FirebaseManagerProtocol
    
    init(builder: FirebaseManagerProtocol = FirebaseManager()) {
        self.builder = builder
    }
    
    func fetchSelectedCathegories(_ request: FilterCathegories.Request.FetchSelectedCathegories,
                                  completion: @escaping (BaseResponse<FilterCathegories.Info.Response.SelectedCathegories>) -> Void) {
        
    }
    
    func filterCathegories(_ request: FilterCathegories.Request.FilterCathegories,
                           completion: @escaping (EmptyResponse) -> Void) {
        
    }
}
