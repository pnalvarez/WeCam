//
//  OnGoingProjectInvitesRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 12/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

typealias OnGoingProjectInvitesRouterProtocol = NSObject & OnGoingProjectInvitesRoutingLogic & OnGoingProjectInvitesDataTransfer

protocol OnGoingProjectInvitesRoutingLogic {
    func routeBack()
    func routeToProfileDetails()
}

protocol OnGoingProjectInvitesDataTransfer {
    var dataStore: OnGoingProjectInvitesDataStore? { get set }
}

class OnGoingProjectInvitesRouter: NSObject, OnGoingProjectInvitesDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: OnGoingProjectInvitesDataStore?
    
    private func transferDataToProfileDetails(from source: OnGoingProjectInvitesDataStore,
                                              to destination: inout ProfileDetailsDataStore) {
        destination.receivedUserData = ProfileDetails
            .Info
            .Received
            .User(userId: source.selectedUser?.userId ?? .empty)
    }
}

extension OnGoingProjectInvitesRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        viewController?.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension OnGoingProjectInvitesRouter: OnGoingProjectInvitesRoutingLogic {
    
    func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func routeToProfileDetails() {
        let vc = ProfileDetailsController()
        guard let source = dataStore,
            var destination = vc.router?.dataStore else { return }
        transferDataToProfileDetails(from: source, to: &destination)
        routeTo(nextVC: vc)
    }
}
