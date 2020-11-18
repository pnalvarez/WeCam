//
//  InsertMediaRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 04/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

typealias InsertMediaRouterProtocol = NSObject & InsertMediaRoutingLogic & InsertMediaDataTransfer

protocol InsertMediaRoutingLogic {
    func routeToFinishedProjectDetails()
    func routeBack()
}

protocol InsertMediaDataTransfer {
    var dataStore: InsertMediaDataStore? { get }
}

class InsertMediaRouter: NSObject, InsertMediaDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: InsertMediaDataStore?
    
    private func transferDataToFinishedProjectDetails(from source: InsertMediaDataStore, to destination: inout FinishedProjectDetailsDataStore) {
        destination.receivedData = FinishedProjectDetails.Info.Received.Project(id: source.finishedProject?.id ?? .empty)
        destination.routingModel = FinishedProjectDetails.Info.Received.Routing(routingMethod: .push)
    }
}

extension InsertMediaRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        viewController?.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension InsertMediaRouter: InsertMediaRoutingLogic {
    
    func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func routeToFinishedProjectDetails() {
        let vc = FinishedProjectDetailsController()
        guard let source = dataStore,
              var destination = vc.router?.dataStore else { return }
        transferDataToFinishedProjectDetails(from: source,
                                             to: &destination)
        routeTo(nextVC: vc)
    }
}
