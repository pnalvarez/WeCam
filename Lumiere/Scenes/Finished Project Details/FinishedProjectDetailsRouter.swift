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
}

protocol FinishedProjectDetailsDataTransfer {
    var dataStore: FinishedProjectDetailsDataStore? { get set }
}

class FinishedProjectDetailsRouter: NSObject, FinishedProjectDetailsDataTransfer {
    
    var dataStore: FinishedProjectDetailsDataStore?
    weak var viewController: UIViewController?
    
    private func transferDataToWatchVideo(from source: FinishedProjectDetailsDataStore,
                                          to destination: inout WatchVideoDataStore) {
        destination.receivedData = WatchVideo.Info.Received.Project(id: source.projectData?.id ?? .empty)
    }
}

extension FinishedProjectDetailsRouter: BaseRouterProtocol {

    func routeTo(nextVC: UIViewController) {
        if nextVC is WatchVideoController {
            viewController?.present(nextVC, animated: true, completion: nil)
        }
    }
}

extension FinishedProjectDetailsRouter: FinishedProjectDetailsRoutingLogic {
    
    func routeToWatchVideo() {
        let vc = WatchVideoController()
        vc.modalPresentationStyle = .fullScreen
        guard let source = dataStore,
              var destination = vc.router?.dataStore else { return }
        transferDataToWatchVideo(from: source, to: &destination)
        routeTo(nextVC: vc)
    }
}
