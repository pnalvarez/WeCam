//
//  FinishedProjectDetailsPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 08/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol FinishedProjectDetailsPresentationLogic {
    func presentProjectData(_ response: FinishedProjectDetails.Info.Model.Project)
    func presentProfileDetails()
    func presentInviteUsers()
    func presentLoading(_ loading: Bool)
    func presentRelationUI(_ response: FinishedProjectDetails.Info.Model.Relation)
    func presentAllParticipants()
    func presentProjectInvites()
    func presentInteractionConfirmationModal(forRelation relation: FinishedProjectDetails.Info.Model.Relation)
    func presentRoutingUI(_ response: FinishedProjectDetails.Info.Model.Routing)
    func presentNotInvitedUsersErrorAlert(_ response: FinishedProjectDetails.Info.Model.NotInvitedUsers)
    func presentAlert(_ response: FinishedProjectDetails.Info.Model.Alert)
}

class FinishedProjectDetailsPresenter: FinishedProjectDetailsPresentationLogic {
    
    private unowned var viewController: FinishedProjectDetailsDisplayLogic
    
    init(viewController: FinishedProjectDetailsDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentProjectData(_ response: FinishedProjectDetails.Info.Model.Project) {
        let viewModel = FinishedProjectDetails
            .Info
            .ViewModel
            .Project(image: response.image,
                     title: response.title,
                     sinopsis: response.sinopsis,
                     participants: response.participants.map({ FinishedProjectDetails.Info.ViewModel.TeamMember(id: $0.id, image: $0.image, name: $0.name, ocupation: $0.ocupation)}))
        viewController.displayProjectData(viewModel)
    }
    
    func presentProfileDetails() {
        viewController.displayProfileDetails()
    }
    
    func presentInviteUsers() {
        viewController.displayInviteUsers()
    }
    
    func presentLoading(_ loading: Bool) {
        viewController.defaultScreenLoading(!loading)
    }
    
    func presentRelationUI(_ response: FinishedProjectDetails.Info.Model.Relation) {
        let viewModel = FinishedProjectDetails.Info.ViewModel.Relation(relation: response.relation)
        viewController.displayRelationUI(viewModel)
    }
    
    func presentAllParticipants() {
        viewController.displayAllParticipants()
    }
    
    func presentProjectInvites() {
        viewController.displayProjectInvites()
    }
    
    func presentInteractionConfirmationModal(forRelation relation: FinishedProjectDetails.Info.Model.Relation) {
        let viewModel = FinishedProjectDetails.Info.ViewModel.Relation(relation: relation.relation)
        viewController.displayInteractionConfirmationModal(forRelation: viewModel)
    }
    
    func presentRoutingUI(_ response: FinishedProjectDetails.Info.Model.Routing) {
        let viewModel = FinishedProjectDetails.Info.ViewModel.Routing(backButtonVisible: response.context == .checking && response.method == .push, closeButtonVisible: response.context == .justCreated || response.method == .modal, method: response.method)
        viewController.displayRoutingUI(viewModel)
    }
    
    func presentNotInvitedUsersErrorAlert(_ response: FinishedProjectDetails.Info.Model.NotInvitedUsers) {
        
    }
    
    func presentAlert(_ response: FinishedProjectDetails.Info.Model.Alert) {
        let viewModel = FinishedProjectDetails.Info.ViewModel.Alert(title: response.title, description: response.description)
        viewController.displayAlert(viewModel)
    }
}
