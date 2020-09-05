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
}
