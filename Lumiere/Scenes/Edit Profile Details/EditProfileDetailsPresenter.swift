//
//  EditProfileDetailsPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 23/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol EditProfileDetailsPresentationLogic: PresenterInterface {
    func presentUserData(_ response: EditProfileDetails.Info.Model.User)
    func didUpdateUser()
    func presentLoading(_ loading: Bool)
    func presentServerError(_ response: WCError)
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
        viewController.fullScreenLoading(!loading)
    }
    
    func presentServerError(_ response: WCError) {
        viewController.showAlertError(title: WCConstants.Strings.errorTitle,
                                      description: response.description,
                                      doneText: WCConstants.Strings.ok)
    }
    
    func presentInputError(_ response: EditProfileDetails.Errors.InputErrors) {
        viewController.showAlertError(title: WCConstants.Strings.errorTitle,
                                      description: response.rawValue,
                                      doneText: WCConstants.Strings.ok)
    }
    
    func presentCathegories(_ response: EditProfileDetails.Info.Model.InterestCathegories) {
        let viewModel = EditProfileDetails.Info.ViewModel.Cathegories(cathegories: response)
        viewController.displayInterestCathegories(viewModel)
    }
}
