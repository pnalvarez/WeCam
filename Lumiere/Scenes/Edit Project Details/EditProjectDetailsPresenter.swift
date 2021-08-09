//
//  EditProjectDetailsPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 21/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol EditProjectDetailsPresentationLogic {
    func presentPublishedProjectDetails()
    func presentInvitedUsers(_ response: EditProjectDetails.Info.Model.InvitedUsers)
    func presentLoading(_ loading: Bool)
    func presentServerError(_ response: EditProjectDetails.Info.Model.ServerError)
    func presentLocalError(_ response: EditProjectDetails.Info.Model.LocalError)
    func presentFinishedProjectContextUI()
    func presentInsertVideo()
}

class EditProjectDetailsPresenter: EditProjectDetailsPresentationLogic {
    
    private unowned var viewController: EditProjectDetailsDisplayLogic
    
    init(viewController: EditProjectDetailsDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentPublishedProjectDetails() {
        viewController.displayPublishedProjectDetails()
    }
    
    func presentInvitedUsers(_ response: EditProjectDetails.Info.Model.InvitedUsers) {
        let viewModel = EditProjectDetails
            .Info
            .ViewModel
            .InvitedUsers(users: response.users.map({EditProjectDetails.Info.ViewModel.User(name: $0.name,
                                                                                            ocupation: $0.ocupation,
                                                                                            image: $0.image)}))
        viewController.displayInvitedUsers(viewModel)
    }
    
    func presentLoading(_ loading: Bool) {
        viewController.fullScreenLoading(!loading)
    }
    
    func presentServerError(_ response: EditProjectDetails.Info.Model.ServerError) {
        viewController.showErrorToast(withText: response.error.description)
    }
    
    func presentLocalError(_ response: EditProjectDetails.Info.Model.LocalError) {
        viewController.showErrorToast(withText: response.description)
    }
    
    func presentFinishedProjectContextUI() {
        viewController.displayUpdatedProjectContextUI()
    }
    
    func presentInsertVideo() {
        viewController.displayInsertVideo()
    }
}
