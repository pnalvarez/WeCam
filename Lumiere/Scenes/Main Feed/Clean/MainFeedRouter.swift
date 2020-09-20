//
//  MainFeedRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

typealias MainFeedRouterProtocol = NSObject & MainFeedRoutingLogic & MainFeedDataTransfer

protocol MainFeedRoutingLogic {
    
}

protocol MainFeedDataTransfer {
    var dataStore: MainFeedDataStore? { get set }
}

class MainFeedRouter: NSObject, MainFeedDataTransfer {
    
    var dataStore: MainFeedDataStore?
    weak var viewController: UIViewController?
}

extension MainFeedRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        
    }
}

extension MainFeedRouter: MainFeedRoutingLogic {
    
}
