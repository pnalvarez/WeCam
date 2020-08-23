//
//  EditProfileDetailsInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 23/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol EditProfileDetailsBusinessLogic {
    
}

protocol EditProfileDetailsDataStore {
    
}

class EditProfileDetailsInteractor: EditProfileDetailsDataStore {
    
    private let worker: EditProfileDetailsWorkerProtocol
    var presenter: EditProfileDetailsPresentationLogic
    
    init(worker: EditProfileDetailsWorkerProtocol = EditProfileDetailsWorker(),
         viewController: EditProfileDetailsDisplayLogic) {
        self.worker = worker
        self.presenter = EditProfileDetailsPresenter(viewController: viewController)
    }
}

extension EditProfileDetailsInteractor: EditProfileDetailsBusinessLogic {
    
}
