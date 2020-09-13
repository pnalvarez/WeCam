//
//  OnGoingProjectInvitesPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 12/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol OnGoingProjectInvitesPresentationLogic {
    func presentUsers(_ response: OnGoingProjectInvites.Info.Model.UpcomingUsers)
    func presentProject(_ response: OnGoingProjectInvites.Info.Model.Project)
    func presentModalAlert(_ response: OnGoingProjectInvites.Info.Model.Alert)
    func hideModalAlert()
    func presentLoading(_ loading: Bool)
    func presentProfileDetails()
}

class OnGoingProjectInvitesPresenter: OnGoingProjectInvitesPresentationLogic {
    
    private unowned var viewController: OnGoingProjectInvitesDisplayLogic
    
    init(viewController: OnGoingProjectInvitesDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentUsers(_ response: OnGoingProjectInvites.Info.Model.UpcomingUsers) {
        let viewModel = OnGoingProjectInvites.Info.ViewModel.UpcomingUsers(users: response.users.map({
            var image: UIImage?
            switch $0.relation ?? .nothing {
            case .simpleParticipant:
                image = OnGoingProjectInvites.Constants.Images.member
            case .sentRequest:
                image = OnGoingProjectInvites.Constants.Images.sentRequest
            case .receivedRequest:
                image = OnGoingProjectInvites.Constants.Images.receivedRequest
            case .nothing:
                image = OnGoingProjectInvites.Constants.Images.invite
            }
            return OnGoingProjectInvites
            .Info
            .ViewModel
            .User(image: $0.image,
                  name: $0.name,
                  ocupation: $0.ocupation,
                  email: NSAttributedString(string: $0.email,
                                            attributes: [NSAttributedString.Key.font: OnGoingProjectInvites.Constants.Fonts.emailLbl,
                                                         NSAttributedString.Key.foregroundColor: OnGoingProjectInvites.Constants.Colors.emailLbl,
                                                         NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]),
                  relation: image) }))
        viewController.displayUsers(viewModel)
    }
    
    func presentProject(_ response: OnGoingProjectInvites.Info.Model.Project) {
        let viewModel = OnGoingProjectInvites.Info.ViewModel.Project(title: response.title)
        viewController.displayProjectInfo(viewModel)
    }
    
    func presentModalAlert(_ response: OnGoingProjectInvites.Info.Model.Alert) {
        viewController.displayConfirmationView(OnGoingProjectInvites
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
}

