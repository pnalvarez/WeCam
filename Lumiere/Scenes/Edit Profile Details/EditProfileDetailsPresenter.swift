//
//  EditProfileDetailsPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 23/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol EditProfileDetailsPresentationLogic {
    func presentUserData(_ response: EditProfileDetails.Info.Model.User)
    func didUpdateUser()
    func presentLoading(_ loading: Bool)
    func presentServerError(_ response: Error)
    func presentInputError(_ response: EditProfileDetails.Errors.InputErrors)
    func presentCathegories(_ response: EditProfileDetails.Info.Model.InterestCathegories)
}

class EditProfileDetailsPresenter: EditProfileDetailsPresentationLogic {
    
    private unowned var viewController: EditProfileDetailsDisplayLogic
    
    init(viewController: EditProfileDetailsDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentUserData(_ response: EditProfileDetails.Info.Model.User) {
        let viewModel = EditProfileDetails.Info.ViewModel.User(image: response.image,
                                                               name: response.name,
                                                               cellphone: response.cellphone,
                                                               ocupation: response.ocupation)
        let cathegories = EditProfileDetails.Info.ViewModel.Cathegories(cathegories: response.interestCathegories)
        viewController.displayUserData(viewModel, cathegories: cathegories)
        
    }
    
    func didUpdateUser() {
        viewController.displayProfileDetails()
    }
    
    func presentLoading(_ loading: Bool) {
        viewController.displayLoading(loading)
    }
    
    func presentServerError(_ response: Error) {
        viewController.displayError(response.localizedDescription)
    }
    
    func presentInputError(_ response: EditProfileDetails.Errors.InputErrors) {
        viewController.displayError(response.rawValue)
    }
    
    func presentCathegories(_ response: EditProfileDetails.Info.Model.InterestCathegories) {
        let viewModel = EditProfileDetails.Info.ViewModel.Cathegories(cathegories: response)
        viewController.displayInterestCathegories(viewModel)
    }
}
