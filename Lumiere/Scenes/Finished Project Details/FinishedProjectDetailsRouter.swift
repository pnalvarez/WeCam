//
//  FinishedProjectDetailsRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 08/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

typealias FinishedProjectDetailsRouterProtocol = NSObject & FinishedProjectDetailsRoutingLogic & FinishedProjectDetailsDataTransfer

protocol FinishedProjectDetailsRoutingLogic {
    func routeToWatchVideo()
    func routeToProjectInvites()
    func routeToProfileDetails()
}

protocol FinishedProjectDetailsDataTransfer {
    var dataStore: FinishedProjectDetailsDataStore? { get set }
}

class FinishedProjectDetailsRouter: NSObject, FinishedProjectDetailsDataTransfer {
    
    var routingMethod: RoutingMethod {
        return dataStore?.routingModel?.routingMethod ?? .push
    }
    
    var routingContext: FinishedProjectDetails.Info.Model.RoutingContext {
        return dataStore?.routingModel?.context ?? .checking
    }
    
    var dataStore: FinishedProjectDetailsDataStore?
    weak var viewController: UIViewController?
    
    private func transferDataToWatchVideo(from source: FinishedProjectDetailsDataStore,
                                          to destination: inout WatchVideoDataStore) {
        destination.receivedData = WatchVideo.Info.Received.Project(id: source.projectData?.id ?? .empty)
    }
    
    private func transferDataToProjectInvites(from source: FinishedProjectDetailsDataStore,
                                              to destination: inout ProjectInvitesDataStore) {
        destination.projectReceivedModel = ProjectInvites.Info.Received.Project(projectId: source.projectData?.id ?? .empty)
        destination.receivedContext = .finished
    }
    
    private func transferDataToProfileDetails(from source: FinishedProjectDetailsDataStore, to destination: inout ProfileDetailsDataStore) {
        destination.receivedUserData = ProfileDetails.Info.Received.User(userId: source.selectedTeamMember ?? .empty)
    }
}

extension FinishedProjectDetailsRouter: BaseRouterProtocol {

    func routeTo(nextVC: UIViewController) {
        if nextVC is WatchVideoController {
            viewController?.present(nextVC, animated: true, completion: nil)
        } else {
            viewController?.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}

extension FinishedProjectDetailsRouter: FinishedProjectDetailsRoutingLogic {
    
    func routeToProjectInvites() {
        let vc = ProjectInvitesController()
        guard let source = dataStore,
              var destination = vc.router?.dataStore else { return }
        transferDataToProjectInvites(from: source, to: &destination)
        routeTo(nextVC: vc)
    }
    
    func routeToWatchVideo() {
        let vc = WatchVideoController()
        vc.modalPresentationStyle = .fullScreen
        guard let source = dataStore,
              var destination = vc.router?.dataStore else { return }
        transferDataToWatchVideo(from: source, to: &destination)
        routeTo(nextVC: vc)
    }
    
    func routeToProfileDetails() {
        let vc = ProfileDetailsController()
        guard let source = dataStore,
              var destination = vc.router?.dataStore else { return }
        transferDataToProfileDetails(from: source,
                                     to: &destination)
        routeTo(nextVC: vc)
    }
}
