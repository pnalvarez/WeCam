//
//  ProjectProgressRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 20/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

typealias ProjectProgressRouterProtocol = NSObject & ProjectProgressRoutingLogic & ProjectProgressDataTransfer

protocol ProjectProgressRoutingLogic {
    func routeBack()
    func routeToEditProjectDetails()
}

protocol ProjectProgressDataTransfer {
    var dataStore: ProjectProgressDataStore? { get set }
}

class ProjectProgressRouter: NSObject, ProjectProgressDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: ProjectProgressDataStore?
    
    private func transferDataToEditProjectDetails(from source: ProjectProgressDataStore,
                                                  to destination: inout EditProjectDetailsDataStore) {
        destination.receivedData = EditProjectDetails.Info.Received.Project(image: source.progressingProject?.image,
                                                                            cathegories: source.progressingProject?.cathegories ?? .empty,
                                                                            progress: source.progressingProject?.progress ?? 0.0)
    }
}

extension ProjectProgressRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        viewController?.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension ProjectProgressRouter: ProjectProgressRoutingLogic {
    
    func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func routeToEditProjectDetails() {
        let vc = EditProjectDetailsController()
        guard let source = dataStore,
            var destination = vc.router?.dataStore else { return }
        transferDataToEditProjectDetails(from: source, to: &destination)
        routeTo(nextVC: vc)
    }
}


