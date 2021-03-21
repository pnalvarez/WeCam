//
//  OnGoingProjectInvitesPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 12/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol ProjectInvitesPresentationLogic {
    func presentUsers(_ response: ProjectInvites.Info.Model.UpcomingUsers)
    func presentProject(_ response: ProjectInvites.Info.Model.Project)
    func presentModalAlert(_ response: ProjectInvites.Info.Model.Alert)
    func hideModalAlert()
    func presentLoading(_ loading: Bool)
    func presentProfileDetails()
    func presentError(_ response: WCError)
    func presentRelationUpdate(_ response: ProjectInvites.Info.Model.RelationUpdate)
}

class ProjectInvitesPresenter: ProjectInvitesPresentationLogic {
    
    private unowned var viewController: ProjectInvitesDisplayLogic
    
    init(viewController: ProjectInvitesDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentUsers(_ response: ProjectInvites.Info.Model.UpcomingUsers) {
        let viewModel = ProjectInvites.Info.ViewModel.UpcomingUsers(users: response.users.map({
            var image: UIImage?
            switch $0.relation ?? .nothing {
            case .simpleParticipant:
                image = ProjectInvites.Constants.Images.member
            case .sentRequest:
                image = ProjectInvites.Constants.Images.sentRequest
            case .receivedRequest:
                image = ProjectInvites.Constants.Images.receivedRequest
            case .nothing:
                image = ProjectInvites.Constants.Images.invite
            }
            return ProjectInvites
            .Info
            .ViewModel
            .User(image: $0.image,
                  name: $0.name,
                  ocupation: $0.ocupation,
                  email: NSAttributedString(string: $0.email,
                                            attributes: [NSAttributedString.Key.font: ProjectInvites.Constants.Fonts.emailLbl,
                                                         NSAttributedString.Key.foregroundColor: ProjectInvites.Constants.Colors.emailLbl,
                                                         NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]),
                  relation: image) }))
        viewController.displayUsers(viewModel)
    }
    
    func presentProject(_ response: ProjectInvites.Info.Model.Project) {
        let viewModel = ProjectInvites.Info.ViewModel.Project(title: response.title)
        viewController.displayProjectInfo(viewModel)
    }
    
    func presentModalAlert(_ response: ProjectInvites.Info.Model.Alert) {
        viewController.displayConfirmationView(ProjectInvites
            .Info
            .ViewModel
            .Alert(text: response.text))
    }
    
    func hideModalAlert() {
        viewController.hideConfirmationView()
    }
    
    func presentLoading(_ loading: Bool) {
        viewController.displayLoading(loading)
    }
    
    func presentProfileDetails() {
        viewController.displayProfileDetails()
    }
    
    func presentError(_ response: WCError) {
        viewController.displayError(ProjectInvites.Info.ViewModel.ErrorViewModel(title: "Erro", message: response.description))
    }
    
    func presentRelationUpdate(_ response: ProjectInvites.Info.Model.RelationUpdate) {
        var image: UIImage?
        switch  response.relation {
        case .simpleParticipant:
            image = ProjectInvites.Constants.Images.member
        case .sentRequest:
            image = ProjectInvites.Constants.Images.sentRequest
        case .receivedRequest:
            image = ProjectInvites.Constants.Images.receivedRequest
        case .nothing:
            image = ProjectInvites.Constants.Images.invite
        }
        let viewModel = ProjectInvites.Info.ViewModel.RelationUpdate(index: response.index, relation: image)
        viewController.displayRelationUpdate(viewModel)
    }
}

