//
//  ConnectionsListRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 09/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

typealias ConnectionsListRouterProtocol = NSObject & ConnectionsListRoutingLogic & ConnectionsListDataTransfer

protocol ConnectionsListRoutingLogic {
    func routeToProfileDetails()
    func routeBack()
}

protocol ConnectionsListDataTransfer {
    var dataStore: ConnectionsListDataStore? { get set }
}

class ConnectionsListRouter: NSObject, ConnectionsListDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: ConnectionsListDataStore?
    
    private func transferDataToProfileDetails(from source: ConnectionsListDataStore,
                                         to destination: inout ProfileDetailsDataStore) {
        let data = ProfileDetails.Info.Received.User(connectionType: .contact,
                                                     id: source.selectedUserData?.userId ?? .empty,
                                                     image: source.selectedUserData?.image,
                                                     name: source.selectedUserData?.name ?? .empty,
                                                     ocupation: source.selectedUserData?.ocupation ?? .empty,
                                                     email: source.selectedUserData?.email ?? .empty,
                                                     phoneNumber: source.selectedUserData?.phoneNumber ?? .empty,
                                                     connectionsCount: "\(source.selectedUserData?.connectionsCount ?? 0)" ?? .empty,
                                                     progressingProjectsIds: [],
                                                     finishedProjectsIds: [])
        destination.userData = data
    }
}

extension ConnectionsListRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        viewController?.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension ConnectionsListRouter: ConnectionsListRoutingLogic {
    
    func routeToProfileDetails() {
        let vc = ProfileDetailsController()
        guard let source = dataStore,
            var destination = vc.router?.dataStore else {
                return
        }
        transferDataToProfileDetails(from: source, to: &destination)
        routeTo(nextVC: vc)
    }
    
    func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}

