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
    func routeBack()
    func routeToUserDetails()
    func routeToProjectParticipantsList()
    func routeToProjectInvites()
    func routeToInsertMedia()
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
            .User(userId: source.selectedTeamMemberId ?? .empty)
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
        destination.projectReceivedModel = OnGoingProjectInvites.Info.Received.Project(projectId: source.projectData?.id ?? .empty)
        destination.context = OnGoingProjectInvites.Info.Received.Context(context: .ongoing)
    }
    
    private func transferDataToInsertMedia(from source: OnGoingProjectDetailsDataStore,
                                           to destination: inout InsertVideoDataStore) {
        destination.receivedData = InsertVideo.Info.Received.ReceivedProject.finishing(InsertVideo.Info.Received.FinishingProject(id: source.projectData?.id ?? .empty))
    }
}

extension OnGoingProjectDetailsRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        viewController?.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension OnGoingProjectDetailsRouter: OnGoingProjectDetailsRoutingLogic {
    
    func routeBack() {
        switch dataStore?.routingContext ?? .checkingProject {
        case .justCreatedProject:
            viewController?.navigationController?.popToRootViewController(animated: true)
        case .checkingProject:
            viewController?.navigationController?.popViewController(animated: true)
        }
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
    
    func routeToInsertMedia() {
        let vc = InsertVideoController()
        guard let source = dataStore,
              var destination = vc.router?.dataStore else { return }
        transferDataToInsertMedia(from: source, to: &destination)
        routeTo(nextVC: vc)
    }
}
