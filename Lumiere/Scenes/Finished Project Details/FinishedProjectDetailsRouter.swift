//
//  FinishedProjectDetailsRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 08/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

typealias FinishedProjectDetailsRouterProtocol = NSObject & FinishedProjectDetailsRoutingLogic & FinishedProjectDetailsDataTransfer

protocol FinishedProjectDetailsRoutingLogic {
    func routeToWatchVideo()
    func routeToProjectInvites()
    func dismiss()
}

protocol FinishedProjectDetailsDataTransfer {
    var dataStore: FinishedProjectDetailsDataStore? { get set }
}

class FinishedProjectDetailsRouter: NSObject, FinishedProjectDetailsDataTransfer {
    
    var routingMethod: RoutingMethod {
        return dataStore?.routingModel?.routingMethod ?? .push
    }
    
    var dataStore: FinishedProjectDetailsDataStore?
    weak var viewController: UIViewController?
    
    private func transferDataToWatchVideo(from source: FinishedProjectDetailsDataStore,
                                          to destination: inout WatchVideoDataStore) {
        destination.receivedData = WatchVideo.Info.Received.Project(id: source.projectData?.id ?? .empty)
    }
    
    private func transferDataToProjectInvites(from source: FinishedProjectDetailsDataStore,
                                              to destination: inout ProjectInvitesDataStore) {
        destination.projectReceivedModel = ProjectInvites.Info.Received.Project(projectId: source.projectData?.id ?? .empty)
        destination.receivedContext = .finished
    }
}

extension FinishedProjectDetailsRouter: BaseRouterProtocol {

    func routeTo(nextVC: UIViewController) {
        if nextVC is WatchVideoController {
            viewController?.present(nextVC, animated: true, completion: nil)
        } else if nextVC is ProjectInvitesController {
            viewController?.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}

extension FinishedProjectDetailsRouter: FinishedProjectDetailsRoutingLogic {
    
    func dismiss() {
        switch routingMethod {
        case .modal:
            viewController?.dismiss(animated: true, completion: nil)
        case .push:
            viewController?.navigationController?.popToRootViewController(animated: true)
            viewController?.navigationController?.tabBarController?.selectedIndex = 0
        }
    }
    
    func routeToProjectInvites() {
        let vc = ProjectInvitesController()
        guard let source = dataStore,
              var destination = vc.router?.dataStore else { return }
        transferDataToProjectInvites(from: source, to: &destination)
        routeTo(nextVC: vc)
    }
    
    func routeToWatchVideo() {
        let vc = WatchVideoController()
        vc.modalPresentationStyle = .fullScreen
        guard let source = dataStore,
              var destination = vc.router?.dataStore else { return }
        transferDataToWatchVideo(from: source, to: &destination)
        routeTo(nextVC: vc)
    }
}
