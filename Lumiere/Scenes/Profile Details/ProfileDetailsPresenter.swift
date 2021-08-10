//
//  ProfileDetailsPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit
import WCUIKit

protocol ProfileDetailsPresentationLogic {
    func presentUserInfo(_ response: ProfileDetails.Info.Model.User)
    func presentError(_ response: ProfileDetails.Errors.ProfileDetailsError)
    func presentNewInteractionIcon(_ response: ProfileDetails.Info.Model.NewConnectionType)
    func didEndRequest()
    func presentLoading(_ loading: Bool)
    func didSignOut()
    func presentConfirmationAlert(_ response: ProfileDetails.Info.Model.IneractionConfirmation)
    func presentOngoingProjectDetails()
    func presentFinishedProjectDetails()
}

class ProfileDetailsPresenter: ProfileDetailsPresentationLogic {
    
    private unowned var viewController: ProfileDetailsDisplayLogic
    
    init(viewController: ProfileDetailsDisplayLogic) {
        self.viewController = viewController
    }

    func presentUserInfo(_ response: ProfileDetails.Info.Model.User) {
        let progressingProjects = response.progressingProjects.map({ ProfileDetails.Info.ViewModel.Project(image: $0.image)})
        let finishedProjects = response.finishedProjects.map({ ProfileDetails.Info.ViewModel.Project(image: $0.image)})
        var connectionType: WCProfileHeaderView.RelationState
        switch response.connectionType {
        case .contact:
            connectionType = .connected
        case .pending:
            connectionType = .userReceivedRequest
        case .sent:
            connectionType = .userSentRequest
        case .logged:
            connectionType = .loggedUser
        case .nothing:
            connectionType = .nothing
        case .none:
            connectionType = .nothing
        }
        let viewModel = ProfileDetails
            .Info
            .ViewModel
            .User(connectionType: connectionType,
                  image: response.image,
                  name: response.name,
                  occupation: response.occupation,
                  email: response.email,
                  phoneNumber: response.phoneNumber,
                  connectionsCount: response.connectionsCount,
                  progressingProjects: progressingProjects,
                  finishedProjects: finishedProjects)
        viewController.displayUserInfo(viewModel)
    }
    
    func presentError(_ response: ProfileDetails.Errors.ProfileDetailsError) {
        viewController.showErrorToast(withText: response.description)
    }
    
    func presentNewInteractionIcon(_ response: ProfileDetails.Info.Model.NewConnectionType) {
        var connectionType: WCProfileHeaderView.RelationState
        switch response.connectionType {
        case .contact:
            connectionType = .connected
        case .pending:
            connectionType = .userReceivedRequest
        case .sent:
            connectionType = .userSentRequest
        case .logged:
            connectionType = .loggedUser
        case .nothing:
            connectionType = .nothing
        }
        let viewModel = ProfileDetails.Info.ViewModel.NewConnectionType(type: connectionType)
        viewController.displayNewConnectionType(viewModel)
    }
    
    func didEndRequest() {
        viewController.displayEndRequest()
    }
    
    func presentLoading(_ loading: Bool) {
        viewController.defaultScreenLoading(!loading)
    }
    
    func didSignOut() {
        viewController.displaySignOut()
    }
    
    func presentConfirmationAlert(_ response: ProfileDetails.Info.Model.IneractionConfirmation) {
        var viewModel: ProfileDetails.Info.ViewModel.InteractionConfirmation
        switch response.connectionType {
        case .contact:
            viewModel = ProfileDetails.Info.ViewModel.InteractionConfirmation(text: "Tem certeza que deseja remover esta conexão?")
            break
        case .pending:
            viewModel = ProfileDetails.Info.ViewModel.InteractionConfirmation(text: "Tem certeza que deseja remover esta solicitação?")
            break
        case .nothing:
             viewModel = ProfileDetails.Info.ViewModel.InteractionConfirmation(text: "Tem certeza que deseja recusar este usuário?")
            break
        case .sent:
            viewModel = ProfileDetails.Info.ViewModel.InteractionConfirmation(text: "Tem certeza que deseja aceitar este usuário?")
            break
        case .logged:
            viewModel = ProfileDetails.Info.ViewModel.InteractionConfirmation(text: "Tem certeza que deseja sair?")
        }
        viewController.displayConfirmation(viewModel)
    }
    
    func presentOngoingProjectDetails() {
        viewController.displayProjectDetails()
    }
    
    func presentFinishedProjectDetails() {
        viewController.displayFinishedProjectDetails()
    }
}
