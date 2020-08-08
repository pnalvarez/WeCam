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
}

protocol NotificationsDataTransfer {
    var dataStore: NotificationsDataStore? { get set }
}

class NotificationsRouter: NSObject, NotificationsDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: NotificationsDataStore?
    
    private func transferDataToProfileDetails(from origin: NotificationsController,
                                              to destination: inout ProfileDetailsController) {
        guard let source = dataStore?.selectedUser,
            var destinationSource = destination.router?.dataStore else {
                return
        }
        destinationSource.userData = ProfileDetails.Info.Received.User(connectionType: .nothing,
                                                                       id: source.id,
                                                                       image: source.image,
                                                                       name: source.name,
                                                                       occupation: source.ocupation,
                                                                       email: source.email,
                                                                       phoneNumber: source.phoneNumber,
                                                                       connectionsCount: "\(source.connectionsCount)",
                                                                       progressingProjectsIds: .empty, finishedProjectsIds: .empty)
    }
}

extension NotificationsRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        viewController?.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension NotificationsRouter: NotificationsRoutingLogic {
    
    func routeToProfileDetails() {
        var newVc = ProfileDetailsController()
        if let notificationsController = viewController as? NotificationsController {
            transferDataToProfileDetails(from: notificationsController, to: &newVc)
            routeTo(nextVC: newVc)
        }
    }
}
