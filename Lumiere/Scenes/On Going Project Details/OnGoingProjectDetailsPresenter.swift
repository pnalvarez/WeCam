//
//  OnGoingProjectDetailsPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 22/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol OnGoingProjectDetailsPresentationLogic {
    func presentProject(_ response: OnGoingProjectDetails.Info.Model.ProjectData)
    func presentAlertError(_ response: String)
    func presentToastError(_ response: String)
    func presentLoading(_ loading: Bool)
    func presentSuccessAlert(_ response: OnGoingProjectDetails.Info.Model.Alert)
    func presentUserDetails()
    func presentConfirmationModal(forRelation relation: OnGoingProjectDetails.Info.Model.RelationModel)
    func presentInteractionEffectivated()
    func presentEditProgressModal(withProgress response: OnGoingProjectDetails.Info.Model.Progress)
    func presentConfirmFinishedProjectAlert()
    func presentInsertMediaScreen()
    func presentRoutingContextUI(_ response: OnGoingProjectDetails.Info.Model.RoutingContext)
    func presentProjectProgressUpdateSuccessMessage()
}

class OnGoingProjectDetailsPresenter: OnGoingProjectDetailsPresentationLogic {
    
    private unowned var viewController: OnGoingProjectDetailsDisplayLogic
    
    init(viewController: OnGoingProjectDetailsDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentProject(_ response: OnGoingProjectDetails.Info.Model.ProjectData) {
        var teamMembers: [OnGoingProjectDetails.Info.ViewModel.TeamMember] = []
        for member in response.project.teamMembers {
            teamMembers.append(OnGoingProjectDetails.Info.ViewModel.TeamMember(id: member.id,
                                                                               image: member.image,
                                                                               name: member.name,
                                                                               ocupation: member.ocupation))
        }
        var suffix: String
        if let secondCathegory = response.project.secondCathegory {
            suffix = " / " + secondCathegory
        } else {
            suffix = .empty
        }
        let projectViewModel = OnGoingProjectDetails
            .Info
            .ViewModel
            .Project(image: response.project.image,
                     cathegories: NSAttributedString(string: response.project.firstCathegory + suffix, attributes: [NSAttributedString.Key.font: OnGoingProjectDetails.Constants.Fonts.cathegoryLbl, NSAttributedString.Key.foregroundColor: OnGoingProjectDetails.Constants.Colors.cathegoryLbl, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]),
                     title: response.project.title,
                     progress: NSAttributedString(string: "\(response.project.progress)%", attributes: [NSAttributedString.Key.font: OnGoingProjectDetails.Constants.Fonts.progressButton, NSAttributedString.Key.foregroundColor: OnGoingProjectDetails.Constants.Colors.progressButton, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]),
                     sinopsis: response.project.sinopsis,
                     teamMembers: teamMembers,
                     needing: response.project.needing)
        let relationViewModel = OnGoingProjectDetails.Info.ViewModel.RelationModel(relation: response.relation.relation)
        let viewModel = OnGoingProjectDetails.Info.ViewModel.ProjectData(project: projectViewModel, relation: relationViewModel)
        viewController.displayProject(viewModel)
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
    
    func presentSuccessAlert(_ response: OnGoingProjectDetails.Info.Model.Alert) {
        viewController.showAlertSuccess(title: response.title,
                                        description: response.message)
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
    
    func presentEditProgressModal(withProgress response: OnGoingProjectDetails.Info.Model.Progress) {
        let viewModel = OnGoingProjectDetails.Info.ViewModel.Progress(percentage: Float(response.percentage) / WCConstants.Floats.hundredPercent)
        viewController.displayEditProgressModal(viewModel)
    }
    
    func presentConfirmFinishedProjectAlert() {
        viewController.displayConfirmFinishedProjectAlert()
    }
    
    func presentInsertMediaScreen() {
        viewController.displayInsertMediaScreen()
    }
    
    func presentRoutingContextUI(_ response: OnGoingProjectDetails.Info.Model.RoutingContext) {
        let viewModel = OnGoingProjectDetails.Info.ViewModel.RoutingContext(context: response)
        viewController.displayRoutingContextUI(viewModel)
    }
    
    func presentProjectProgressUpdateSuccessMessage() {
        viewController.dispayProjectProgressUpdateSuccessMessage()
    }
}
