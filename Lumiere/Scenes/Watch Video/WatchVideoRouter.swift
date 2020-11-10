//
//  WatchVideoRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 09/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

typealias WatchVideoRouterProtocol = NSObject & WatchVideoRoutingLogic & WatchVideoDataTransfer

protocol WatchVideoRoutingLogic {
    func dismiss()
}

protocol WatchVideoDataTransfer {
    var dataStore: WatchVideoDataStore? { get }
}

class WatchVideoRouter: NSObject, WatchVideoDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: WatchVideoDataStore?
}

extension WatchVideoRouter: WatchVideoRoutingLogic {
    
    func dismiss() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
