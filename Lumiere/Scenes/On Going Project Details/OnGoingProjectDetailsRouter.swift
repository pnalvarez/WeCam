//
//  OnGoingProjectDetailsRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 22/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

typealias OnGoingProjectDetailsRouterProtocol = NSObject & OnGoingProjectDetailsRoutingLogic & OnGoingProjectDetailsDataTransfer

protocol OnGoingProjectDetailsRoutingLogic {
    func routeToEndOfFlow()
    func routeToUserDetails()
    func routeToProjectParticipantsList()
    func routeToProjectInvites()
}

protocol OnGoingProjectDetailsDataTransfer {
    var dataStore: OnGoingProjectDetailsDataStore? { get set }
}

class OnGoingProjectDetailsRouter: NSObject, OnGoingProjectDetailsDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: OnGoingProjectDetailsDataStore?
    
    private func transferDataToProfileDetails(source: OnGoingProjectDetailsDataStore,
                                              destination: inout ProfileDetailsDataStore) {
        destination.receivedUserData = ProfileDetails
            .Info
            .Received
            .User(userId: source.selectedTeamMeberId ?? .empty)
    }
    
    private func transferDataToProjectParticipantsList(from source: OnGoingProjectDetailsDataStore,
                                                       to destination: inout ProjectParticipantsListDataStore) {
        destination.project = ProjectParticipantsList
            .Info
            .Received
            .Project(projectId: source.projectData?.id ?? .empty)
    }
    
    private func transferDataToProjectInvites(from source: OnGoingProjectDetailsDataStore,
                                              to destination: inout OnGoingProjectInvitesDataStore) {
        destination.projectModel = OnGoingProjectInvites.Info.Received.Project(projectId: source.projectData?.id ?? .empty)
    }
}

extension OnGoingProjectDetailsRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        viewController?.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension OnGoingProjectDetailsRouter: OnGoingProjectDetailsRoutingLogic {
    
    func routeToEndOfFlow() {
        viewController?.navigationController?.popToRootViewController(animated: true)
    }
    
    func routeToUserDetails() {
        let vc = ProfileDetailsController()
        guard let source = dataStore,
            var destination = vc.router?.dataStore else { return }
        transferDataToProfileDetails(source: source, destination: &destination)
        routeTo(nextVC: vc)
    }
    
    func routeToProjectParticipantsList() {
        let vc = ProjectParticipantsListController()
        guard let source = dataStore,
            var destination = vc.router?.dataStore else { return }
        transferDataToProjectParticipantsList(from: source, to: &destination)
        routeTo(nextVC: vc)
    }
    
    func routeToProjectInvites() {
        let vc = OnGoingProjectInvitesController()
        guard let source = dataStore,
            var destination = vc.router?.dataStore else { return }
        transferDataToProjectInvites(from: source, to: &destination)
        routeTo(nextVC: vc)
    }
}
