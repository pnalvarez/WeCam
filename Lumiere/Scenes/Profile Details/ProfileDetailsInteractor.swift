//
//  ProfileDetailsInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol ProfileDetailsBusinessLogic {
    
}

protocol ProfileDetailsDataStore {
    
}

class ProfileDetailsInteractor: ProfileDetailsDataStore {
    
    var presenter: ProfileDetailsPresentationLogic
    var worker: ProfileDetailsWorkerProtocol
    
    init(viewController: ProfileDetailsDisplayLogic,
         worker: ProfileDetailsWorkerProtocol = ProfileDetailsWorker()) {
        self.presenter = ProfileDetailsPresenter(viewController: viewController)
        self.worker = worker
    }
}

extension ProfileDetailsInteractor: ProfileDetailsBusinessLogic {
    
}

