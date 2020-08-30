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
    func presentProjectRelationUI(_ response: OnGoingProjectDetails.Info.Model.RelationModel)
    func presentError(_ response: String)
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
    
    func presentProjectRelationUI(_ response: OnGoingProjectDetails.Info.Model.RelationModel) {
        let viewModel = OnGoingProjectDetails.Info.ViewModel.RelationModel(relation: response.relation)
        viewController.displayUIForRelation(viewModel)
    }
    
    func presentError(_ response: String) {
        viewController.displayError(response)
    }
    
    func presentLoading(_ loading: Bool) {
        viewController.displayLoading(loading)
    }
}
