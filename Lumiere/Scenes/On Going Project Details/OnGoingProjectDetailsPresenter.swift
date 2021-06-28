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
    func presentAlertError(_ response: String)
    func presentToastError(_ response: String)
    func presentLoading(_ loading: Bool)
    func presentFeedback(_ response: OnGoingProjectDetails.Info.Model.Feedback)
    func presentUserDetails()
    func presentConfirmationModal(forRelation relation: OnGoingProjectDetails.Info.Model.RelationModel)
    func presentInteractionEffectivated()
    func presentRefusedInteraction()
    func presentEditProgressModal(withProgress response: OnGoingProjectDetails.Info.Model.Progress)
    func presentConfirmFinishedProjectAlert()
    func hideEditProgressModal()
    func presentInsertMediaScreen()
    func presentRoutingContextUI(_ response: OnGoingProjectDetails.Info.Model.RoutingContext)
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
        var suffix: String
        if let secondCathegory = response.secondCathegory {
            suffix = " / " + secondCathegory
        } else {
            suffix = .empty
        }
        let viewModel = OnGoingProjectDetails
            .Info
            .ViewModel
            .Project(image: response.image,
                     cathegories: NSAttributedString(string: response.firstCathegory + suffix, attributes: [NSAttributedString.Key.font: OnGoingProjectDetails.Constants.Fonts.cathegoryLbl, NSAttributedString.Key.foregroundColor: OnGoingProjectDetails.Constants.Colors.cathegoryLbl, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]),
                     title: response.title,
                     progress: NSAttributedString(string: "\(response.progress)%", attributes: [NSAttributedString.Key.font: OnGoingProjectDetails.Constants.Fonts.progressButton, NSAttributedString.Key.foregroundColor: OnGoingProjectDetails.Constants.Colors.progressButton, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]),
                     sinopsis: response.sinopsis,
                     teamMembers: teamMembers,
                     needing: response.needing)
        viewController.displayProjectDetails(viewModel)
    }
    
    func presentProjectRelationUI(_ response: OnGoingProjectDetails.Info.Model.RelationModel) {
        let viewModel = OnGoingProjectDetails.Info.ViewModel.RelationModel(relation: response.relation)
        viewController.displayUIForRelation(viewModel)
    }
    
    func presentAlertError(_ response: String) {
        viewController.showAlertError(title: WCConstants.Strings.errorTitle,
                                      description: response,
                                      doneText: WCConstants.Strings.ok)
    }
    
    func presentToastError(_ response: String) {
        viewController.showErrorToast(withText: response)
    }
    
    func presentLoading(_ loading: Bool) {
        viewController.defaultScreenLoading(!loading)
    }
    
    func presentFeedback(_ response: OnGoingProjectDetails.Info.Model.Feedback) {
        let viewModel = OnGoingProjectDetails.Info.ViewModel.Feedback(title: response.title, message: response.message)
        viewController.displayFeedback(viewModel)
    }
    
    func presentUserDetails() {
        viewController.displayUserDetails()
    }
    
    func presentConfirmationModal(forRelation relation: OnGoingProjectDetails.Info.Model.RelationModel) {
        let viewModel = OnGoingProjectDetails.Info.ViewModel.RelationModel(relation: relation.relation)
        viewController.displayConfirmationModal(viewModel)
    }
    
    func presentInteractionEffectivated() {
        viewController.displayInteractionEffectivated()
    }
    
    func presentRefusedInteraction() {
        viewController.displayRefusedInteraction()
    }
    
    func presentEditProgressModal(withProgress response: OnGoingProjectDetails.Info.Model.Progress) {
        let viewModel = OnGoingProjectDetails.Info.ViewModel.Progress(percentage: Float(response.percentage))
        viewController.displayEditProgressModal(viewModel)
    }
    
    func presentConfirmFinishedProjectAlert() {
        viewController.displayConfirmFinishedProjectAlert()
    }
    
    func hideEditProgressModal() {
        viewController.hideEditProgressModal()
    }
    
    func presentInsertMediaScreen() {
        viewController.displayInsertMediaScreen()
    }
    
    func presentRoutingContextUI(_ response: OnGoingProjectDetails.Info.Model.RoutingContext) {
        let viewModel = OnGoingProjectDetails.Info.ViewModel.RoutingContext(context: response)
        viewController.displayRoutingContextUI(viewModel)
    }
}
