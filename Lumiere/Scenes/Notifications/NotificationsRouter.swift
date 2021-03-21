//
//  NotificationsRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

typealias NotificationsRouterProtocol = NSObject & NotificationsRoutingLogic & NotificationsDataTransfer

protocol NotificationsRoutingLogic {
    func routeToProfileDetails()
    func routeToProjectDetails()
}

protocol NotificationsDataTransfer {
    var dataStore: NotificationsDataStore? { get set }
}

class NotificationsRouter: NSObject, NotificationsDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: NotificationsDataStore?
    
    private func transferDataToProfileDetails(from origin: NotificationsDataStore,
                                              to destination: inout ProfileDetailsDataStore) {
        destination.receivedUserData = ProfileDetails.Info.Received.User(userId: origin.selectedUser?.userId ?? .empty)
    }
    
    private func transferDataToProjectDetails(from origin: NotificationsDataStore,
                                              to destination: inout OnGoingProjectDetailsDataStore) {
        destination.receivedData = OnGoingProjectDetails.Info.Received.Project(projectId: origin.selectedProject?.projectId ?? .empty, notInvitedUsers: .empty)
        destination.routingContext = OnGoingProjectDetails.Info.Received.RoutingContext(context: .checkingProject)
    }
}

extension NotificationsRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        viewController?.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension NotificationsRouter: NotificationsRoutingLogic {
    
    func routeToProfileDetails() {
        let newVc = ProfileDetailsController()
            guard let dataStore = dataStore,
                var destinationDataStore = newVc.router?.dataStore else {
                    return
            }
            transferDataToProfileDetails(from: dataStore, to: &destinationDataStore)
            routeTo(nextVC: newVc)
    }
    
    func routeToProjectDetails() {
        let vc = OnGoingProjectDetailsController()
        guard let source = dataStore,
            var destination = vc.router?.dataStore else { return }
        transferDataToProjectDetails(from: source, to: &destination)
        routeTo(nextVC: vc)
    }
}

