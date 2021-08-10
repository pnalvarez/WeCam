//
//  ProjectParticipantsListPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 05/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol ProjectParticipantsListPresentationLogic {
    func presentParticipants(_ response: ProjectParticipantsList.Info.Model.UpcomingParticipants)
    func presentLoading(_ loading: Bool)
    func presentError(_ response: String)
    func presentProfileDetails()
}

class ProjectParticipantsListPresenter: ProjectParticipantsListPresentationLogic {
    
    private unowned var viewController: ProjectParticipantsListDisplayLogic
    
    init(viewController: ProjectParticipantsListDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentParticipants(_ response: ProjectParticipantsList.Info.Model.UpcomingParticipants) {
        let viewModel = ProjectParticipantsList.Info.ViewModel.UpcomingParticipants(participants: response.participants.map({ ProjectParticipantsList
            .Info
            .ViewModel
            .Participant(name: $0.name,
                         ocupation: $0.ocupation,
                         email: NSAttributedString(string: $0.email,
                                                   attributes: [NSAttributedString.Key.font: ProjectParticipantsList.Constants.Fonts.emailLbl,
                                                                NSAttributedString.Key.foregroundColor: ProjectParticipantsList.Constants.Colors.emailLbl,
                                                                NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]),
                         image: $0.image) }))
        viewController.displayParticipants(viewModel)
    }
    
    func presentLoading(_ loading: Bool) {
        viewController.defaultScreenLoading(!loading)
    }
    
    func presentError(_ response: String) {
        viewController.showAlertError(description: response)
    }
    
    func presentProfileDetails() {
        viewController.displayProfileDetails()
    }
}
