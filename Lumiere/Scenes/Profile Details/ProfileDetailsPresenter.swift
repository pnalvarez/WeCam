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
    func presentLoading(_ loading: Bool)
    func didFetchAddConnection()
    func presentError(_ response: ProfileDetails.Errors.ProfileDetailsError)
}

class ProfileDetailsPresenter: ProfileDetailsPresentationLogic {
    
    private unowned var viewController: ProfileDetailsDisplayLogic
    
    init(viewController: ProfileDetailsDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentUserInfo(_ response: ProfileDetails.Info.Model.User) {
//        guard let image = response.image else { return }
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
        case .nothing:
            connectionTypeImage = ProfileDetails.Constants.Images.add
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
                  connectionsCount: NSAttributedString(string: "\(response.connectionsCount) Conexões",
                    attributes: [NSAttributedString.Key.font: ProfileDetails
                        .Constants
                        .Fonts
                        .allConnectionsButton, NSAttributedString.Key.foregroundColor: ProfileDetails.Constants.Colors.allConnectionsButtonText]),
                  progressingProjects: progressingProjects,
                  finishedProjects: finishedProjects)
        viewController.displayUserInfo(viewModel)
    }
    
    func presentLoading(_ loading: Bool) {
        viewController.displayLoading(loading)
    }
    
    func didFetchAddConnection() {
        
    }
    
    func presentError(_ response: ProfileDetails.Errors.ProfileDetailsError) {
        
    }
}

extension ProfileDetailsPresenter {
    
    private func buildProjectsViewModel(from projectsModels: [ProfileDetails.Info.Model.Project]) -> [ProfileDetails.Info.ViewModel.Project] {
        var projects: [ProfileDetails.Info.ViewModel.Project] = []
        for project in projectsModels {
            let viewModel = ProfileDetails.Info.ViewModel.Project(id: project.id,
                                                                  image: UIImage(data: project.image))
            projects.append(viewModel)
        }
        return projects
    }
}
