//
//  InsertVideoRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 04/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

typealias InsertVideoRouterProtocol = NSObject & InsertVideoRoutingLogic & InsertVideoDataTransfer

protocol InsertVideoRoutingLogic {
    func routeToFinishedProjectDetails()
    func routeBack()
}

protocol InsertVideoDataTransfer {
    var dataStore: InsertVideoDataStore? { get }
}

class InsertVideoRouter: NSObject, InsertVideoDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: InsertVideoDataStore?
    
    private func transferDataToFinishedProjectDetails(from source: InsertVideoDataStore, to destination: inout FinishedProjectDetailsDataStore) {
        switch source.finishedProject {
        case .finishing(let data):
            destination.receivedData = FinishedProjectDetails.Info.Received.Project(id: data.id)
            destination.routingModel = FinishedProjectDetails.Info.Received.Routing(routingMethod: .push)
        default:
            break
        }
    }
}

extension InsertVideoRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        viewController?.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension InsertVideoRouter: InsertVideoRoutingLogic {
    
    func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func routeToFinishedProjectDetails() {
        let vc = FinishedProjectDetailsController()
        vc.modalPresentationStyle = .fullScreen
        guard let source = dataStore,
              var destination = vc.router?.dataStore else { return }
        transferDataToFinishedProjectDetails(from: source,
                                             to: &destination)
        routeTo(nextVC: vc)
    }
}
