//
//  ProjectParticipantsListRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 05/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

typealias ProjectParticipantsListRouterProtocol = NSObject & ProjectParticipantsListRoutingLogic & ProjectParticipantsListDataTransfer

protocol ProjectParticipantsListRoutingLogic {
    func routeToProfileDetails()
    func routeBack()
}

protocol ProjectParticipantsListDataTransfer {
    var dataStore: ProjectParticipantsListDataStore? { get set }
}

class ProjectParticipantsListRouter: NSObject, ProjectParticipantsListDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: ProjectParticipantsListDataStore?
    
    private func transferDataToProfileDetails(from source: ProjectParticipantsListDataStore,
                                              to destination: inout ProfileDetailsDataStore) {
        destination.receivedUserData = ProfileDetails
            .Info
            .Received
            .User(userId: source.selectedParticipant?.id ?? .empty)
    }
}

extension ProjectParticipantsListRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        viewController?.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension ProjectParticipantsListRouter: ProjectParticipantsListRoutingLogic {
    
    func routeToProfileDetails() {
        let vc = ProfileDetailsController()
        guard let source = dataStore,
            var destination = vc.router?.dataStore else { return }
        transferDataToProfileDetails(from: source, to: &destination)
        routeTo(nextVC: vc)
    }
    
    func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
