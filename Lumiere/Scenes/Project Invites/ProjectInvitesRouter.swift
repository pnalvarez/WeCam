//
//  OnGoingProjectInvitesRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 12/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

typealias ProjectInvitesRouterProtocol = NSObject & ProjectInvitesRoutingLogic & ProjectInvitesDataTransfer

protocol ProjectInvitesRoutingLogic {
    func routeBack()
    func routeToProfileDetails()
}

protocol ProjectInvitesDataTransfer {
    var dataStore: ProjectInvitesDataStore? { get set }
}

class ProjectInvitesRouter: NSObject, ProjectInvitesDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: ProjectInvitesDataStore?
    
    private func transferDataToProfileDetails(from source: ProjectInvitesDataStore,
                                              to destination: inout ProfileDetailsDataStore) {
        destination.receivedUserData = ProfileDetails
            .Info
            .Received
            .User(userId: source.selectedUser?.userId ?? .empty)
    }
}

extension ProjectInvitesRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        viewController?.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension ProjectInvitesRouter: ProjectInvitesRoutingLogic {
    
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
