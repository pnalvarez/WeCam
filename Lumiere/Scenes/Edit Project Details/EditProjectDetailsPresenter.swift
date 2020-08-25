//
//  EditProjectDetailsPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 21/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol EditProjectDetailsPresentationLogic {
    func presentInviteList(_ delegate: InviteListDelegate)
    func presentPublishedProjectDetails()
    func presentInvitedUsers(_ response: EditProjectDetails.Info.Model.InvitedUsers)
    func presentLoading(_ loading: Bool)
    func presentServerError(_ response: EditProjectDetails.Info.Model.ServerError)
    func presentLocalError(_ response: EditProjectDetails.Info.Model.LocalError)
}

class EditProjectDetailsPresenter: EditProjectDetailsPresentationLogic {
    
    private unowned var viewController: EditProjectDetailsDisplayLogic
    
    init(viewController: EditProjectDetailsDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentInviteList(_ delegate: InviteListDelegate) {
        viewController.displayInviteList(delegate)
    }
    
    func presentPublishedProjectDetails() {
        viewController.displayPublishedProjectDetails()
    }
    
    func presentInvitedUsers(_ response: EditProjectDetails.Info.Model.InvitedUsers) {
        var text: String
        if response.users.isEmpty {
            text = "Nenhum usuário convidado"
        } else if response.users.count == 1 {
            text = "\(response.users[0].name)"
        } else if response.users.count == 2 {
            text = "\(response.users[0].name) e \(response.users[1].name)"
        } else {
            text = "\(response.users[0].name), \(response.users[1].name) e outros"
        }
        let viewModel = EditProjectDetails.Info.ViewModel.InvitedUsers(text: text)
        viewController.displayInvitedUsers(viewModel)
    }
    
    func presentLoading(_ loading: Bool) {
        viewController.displayLoading(loading)
    }
    
    func presentServerError(_ response: EditProjectDetails.Info.Model.ServerError) {
        let viewModel = EditProjectDetails.Info.ViewModel.DisplayError(description: response.error.localizedDescription)
        viewController.displayError(viewModel)
    }
    
    func presentLocalError(_ response: EditProjectDetails.Info.Model.LocalError) {
        let viewModel = EditProjectDetails.Info.ViewModel.DisplayError(description: response.description)
        viewController.displayError(viewModel)
    }
}
