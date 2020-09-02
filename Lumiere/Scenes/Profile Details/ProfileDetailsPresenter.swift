//
//  ProfileDetailsPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

protocol ProfileDetailsPresentationLogic {
    func presentUserInfo(_ response: ProfileDetails.Info.Model.User)
    func presentError(_ response: ProfileDetails.Errors.ProfileDetailsError)
    func presentNewInteractionIcon(_ response: ProfileDetails.Info.Model.NewConnectionType)
    func presentAllConnections()
    func didEndRequest()
    func presentInterfaceForLogged()
    func presentLoading(_ loading: Bool)
    func didSignOut()
    func presentConfirmationAlert(_ response: ProfileDetails.Info.Model.IneractionConfirmation)
}

class ProfileDetailsPresenter: ProfileDetailsPresentationLogic {
    
    private unowned var viewController: ProfileDetailsDisplayLogic
    
    init(viewController: ProfileDetailsDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentUserInfo(_ response: ProfileDetails.Info.Model.User) {
        let progressingProjects = buildProjectsViewModel(from: response.progressingProjects)
        let finishedProjects = buildProjectsViewModel(from: response.finishedProjects)
        var connectionTypeImage: UIImage?
        switch response.connectionType {
        case .contact:
            connectionTypeImage = ProfileDetails.Constants.Images.isConnection
            break
        case .pending:
            connectionTypeImage = ProfileDetails.Constants.Images.pending
            break
        case .sent:
            connectionTypeImage = ProfileDetails.Constants.Images.sent
            break
        case .logged:
            connectionTypeImage = ProfileDetails.Constants.Images.logout
            break
        case .nothing:
            connectionTypeImage = ProfileDetails.Constants.Images.addConnection
        case .none:
            connectionTypeImage = ProfileDetails.Constants.Images.addConnection
        }
        let viewModel = ProfileDetails
            .Info
            .ViewModel
            .User(connectionTypeImage: connectionTypeImage,
                  image: response.image,
                  name: NSAttributedString(string: response.name,
                                           attributes: [NSAttributedString
                                            .Key
                                            .font: ProfileDetails
                                                .Constants
                                                .Fonts
                                                .nameLbl,
                                                        NSAttributedString.Key.foregroundColor: ProfileDetails
                                                            .Constants
                                                            .Colors
                                                            .nameLbl]),
                  occupation: NSAttributedString(string: response.occupation,
                                                 attributes: [NSAttributedString.Key.font: ProfileDetails
                                                    .Constants.Fonts.ocupationLbl, NSAttributedString.Key.foregroundColor: ProfileDetails
                                                        .Constants.Colors.ocupationLbl]),
                  email: NSAttributedString(string: response.email, attributes: [NSAttributedString.Key.font: ProfileDetails
                    .Constants
                    .Fonts
                    .emailLbl, NSAttributedString.Key.foregroundColor: ProfileDetails
                        .Constants
                        .Colors
                        .emailLbl, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]),
                  phoneNumber: NSAttributedString(string: response.phoneNumber,
                                                  attributes: [NSAttributedString.Key.font: ProfileDetails
                                                    .Constants
                                                    .Fonts
                                                    .phoneNumberLbl, NSAttributedString.Key.foregroundColor: ProfileDetails
                                                        .Constants
                                                        .Colors
                                                        .phoneNumberLbl]),
                  connectionsCount: NSAttributedString(string: response.connectionsCount != "1" ?
                    "\(response.connectionsCount) Conexões" : "\(response.connectionsCount) Conexão",
                    attributes: [NSAttributedString.Key.font: ProfileDetails
                        .Constants
                        .Fonts
                        .allConnectionsButton, NSAttributedString.Key.foregroundColor: ProfileDetails.Constants.Colors.allConnectionsButtonText]),
                  progressingProjects: progressingProjects,
                  finishedProjects: finishedProjects)
        viewController.displayUserInfo(viewModel)
    }
    
    func presentError(_ response: ProfileDetails.Errors.ProfileDetailsError) {
        // TO DO
        viewController.displayEndRequest()
    }
    
    func presentNewInteractionIcon(_ response: ProfileDetails.Info.Model.NewConnectionType) {
        var image: UIImage?
        switch response.connectionType {
        case .contact:
            image = ProfileDetails.Constants.Images.isConnection
            break
        case .pending:
            image = ProfileDetails.Constants.Images.pending
            break
        case .sent:
            image = ProfileDetails.Constants.Images.sent
            break
        case .logged:
            image = ProfileDetails.Constants.Images.logout
            break
        case .nothing:
            image = ProfileDetails.Constants.Images.addConnection
        }
        let viewModel = ProfileDetails.Info.ViewModel.NewConnectionType(image: image)
        viewController.displayNewConnectionType(viewModel)
    }
    
    func presentAllConnections() {
        viewController.displayAllConnections()
    }
    
    func didEndRequest() {
        viewController.displayEndRequest()
    }
    
    func presentInterfaceForLogged() {
        viewController.displayInterfaceForLogged()
    }
    
    func presentLoading(_ loading: Bool) {
        viewController.displayLoading(loading)
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
            viewModel = ProfileDetails.Info.ViewModel.InteractionConfirmation(text: "Tem certeza que deseja remover esta solicitação")
            break
        case .nothing:
             viewModel = ProfileDetails.Info.ViewModel.InteractionConfirmation(text: "Tem certeza que deseja recusar este usuário?")
            break
        case .sent:
            viewModel = ProfileDetails.Info.ViewModel.InteractionConfirmation(text: "Tem certeza que deseja recusar este usuário?")
            break
        case .logged:
            viewModel = ProfileDetails.Info.ViewModel.InteractionConfirmation(text: "Tem certeza que deseja sair?")
        }
        viewController.displayConfirmation(viewModel)
    }
}

extension ProfileDetailsPresenter {
    
    private func buildProjectsViewModel(from projectsModels: [ProfileDetails.Info.Model.Project]) -> [ProfileDetails.Info.ViewModel.Project] {
        return .empty
    }
}
