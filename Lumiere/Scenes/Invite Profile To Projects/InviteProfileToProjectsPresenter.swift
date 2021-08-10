//
//  InviteProfileToProjectsPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 13/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol InviteProfileToProjectsPresentationLogic {
    func presentProjects(_ response: InviteProfileToProjects.Info.Model.UpcomingProjects)
    func presentRelationUpdate(_ response: InviteProfileToProjects.Info.Model.RelationUpdate)
    func presentConfirmationAlert(_ response: InviteProfileToProjects.Info.Model.Alert)
    func presentLoading(_ loading: Bool)
    func presenterError(_ response: WCError)
}

class InviteProfileToProjectsPresenter: InviteProfileToProjectsPresentationLogic {
        
    private unowned var viewController: InviteProfileToProjectsDisplayLogic
    
    init(viewController: InviteProfileToProjectsDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentProjects(_ response: InviteProfileToProjects.Info.Model.UpcomingProjects) {
        let viewModel = InviteProfileToProjects
            .Info
            .ViewModel
            .UpcomingProjects(projects: response.projects.map({
                var image: UIImage?
                switch $0.relation ?? .nothing {
                case .participating:
                    image = InviteProfileToProjects.Constants.Images.participating
                case .receivedRequest:
                    image = InviteProfileToProjects.Constants.Images.receivedRequest
                case .sentRequest:
                    image = InviteProfileToProjects.Constants.Images.sentRequest
                case .nothing:
                    image = InviteProfileToProjects.Constants.Images.nothing
                }
                return InviteProfileToProjects
                    .Info
                    .ViewModel
                    .Project(name: $0.name,
                             image: $0.image, cathegories: NSAttributedString(string: $0.firstCathegory + .space + ($0.secondCathegory ?? .empty), attributes: [NSAttributedString.Key.font: InviteProfileToProjects.Constants.Fonts.cathegoriesLbl, NSAttributedString.Key.foregroundColor: InviteProfileToProjects.Constants.Colors.cathegoriesLbl, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]),
                             progress: $0.progress < 100 ? "\($0.progress)%" : "Concluído",
                                 relation: image)
            }))
        viewController.displayProjects(viewModel)
    }
    
    func presentRelationUpdate(_ response: InviteProfileToProjects.Info.Model.RelationUpdate) {
        var image: UIImage?
        switch response.relation {
        case .participating:
            image = InviteProfileToProjects.Constants.Images.participating
        case .receivedRequest:
            image = InviteProfileToProjects.Constants.Images.receivedRequest
        case .sentRequest:
            image = InviteProfileToProjects.Constants.Images.sentRequest
        case .nothing:
            image = InviteProfileToProjects.Constants.Images.nothing
        }
        let viewModel = InviteProfileToProjects.Info.ViewModel.RelationUpdate(index: response.index, relation: image)
        viewController.displayRelationUpdate(viewModel)
    }
    
    func presentConfirmationAlert(_ response: InviteProfileToProjects.Info.Model.Alert) {
        viewController.displayConfirmationAlert(InviteProfileToProjects.Info.ViewModel.Alert(text: response.text))
    }
    
    func presentLoading(_ loading: Bool) {
        viewController.defaultScreenLoading(!loading)
    }
    
    func presenterError(_ response: WCError) {
        viewController.showAlertError(title: WCConstants.Strings.errorTitle,
                                      description: response.description)
    }
}
