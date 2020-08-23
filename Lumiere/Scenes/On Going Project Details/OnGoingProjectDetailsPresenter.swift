//
//  OnGoingProjectDetailsPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 22/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol OnGoingProjectDetailsPresentationLogic {
    func presentProjectDetails(_ response: OnGoingProjectDetails.Info.Model.Project)
    func presentLoading(_ loading: Bool)
}

class OnGoingProjectDetailsPresenter: OnGoingProjectDetailsPresentationLogic {
    
    private unowned var viewController: OnGoingProjectDetailsDisplayLogic
    
    init(viewController: OnGoingProjectDetailsDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentProjectDetails(_ response: OnGoingProjectDetails.Info.Model.Project) {
        var teamMembers: [OnGoingProjectDetails.Info.ViewModel.TeamMember] = []
        for member in response.teamMembers {
            teamMembers.append(OnGoingProjectDetails.Info.ViewModel.TeamMember(id: member.id,
                                                                               image: member.image,
                                                                               name: member.name,
                                                                               ocupation: member.ocupation))
        }
        let viewModel = OnGoingProjectDetails.Info.ViewModel.Project(image: response.image,
                                                                     title: response.title,
                                                                     sinopsis: response.sinopsis,
                                                                     teamMembers: teamMembers,
                                                                     needing: response.needing)
        viewController.displayProjectDetails(viewModel)
    }
    
    func presentLoading(_ loading: Bool) {
        viewController.displayLoading(loading)
    }
}
