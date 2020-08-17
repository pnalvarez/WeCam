//
//  SelectProjectImageInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 16/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol SelectProjectImageBusinessLogic {
    
}

protocol SelectProjectImageDataStore {
    
}

class SelectProjectImageInteractor: SelectProjectImageDataStore {
    
    var presenter: SelectProjectImagePresentationLogic
    var worker: SelectProjectImageWorkerProtocol
    
    init(viewController: SelectProjectImageDisplayLogic,
         worker: SelectProjectImageWorkerProtocol = SelectProjectImageWorker()) {
        self.presenter = SelectProjectImagePresenter(viewController: viewController)
        self.worker = worker
    }
}

extension SelectProjectImageInteractor: SelectProjectImageBusinessLogic {
    
}
