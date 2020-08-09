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
    
    private func transferDataToProfileDetails(from origin: NotificationsDataStore,
                                              to destination: inout ProfileDetailsDataStore) {
        guard let source = origin.selectedUser else { return }
        var relation: ProfileDetails.Info.ConnectionType
        switch source.relation {
        case .connected:
            relation = .contact
            break
        case .pending:
            relation = .pending
            break
        case .sent:
            relation = .sent
            break
        case .nothing:
            relation = .nothing
            break
        }
        destination.userData = ProfileDetails.Info.Received.User(connectionType: relation,
                                                                 id: source.id,
                                                                 image: source.image,
                                                                 name: source.name,
                                                                 occupation: source.ocupation,
                                                                 email: source.email,
                                                                 phoneNumber: source.phoneNumber,
                                                                 connectionsCount: "\(source.connectionsCount)",
                                                                 progressingProjectsIds: .empty,
                                                                 finishedProjectsIds: .empty)
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
}

