//
//  SelectProjectImageRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 16/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

typealias SelectProjectImageRouterProtocol = NSObject & SelectProjectImageRoutingLogic & SelectProjectImageDataTransfer

protocol SelectProjectImageRoutingLogic {
    
}

protocol SelectProjectImageDataTransfer {
    var dataStore: SelectProjectImageDataStore? { get set }
}

class SelectProjectImageRouter: NSObject, SelectProjectImageDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: SelectProjectImageDataStore?
}

extension SelectProjectImageRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        viewController?.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension SelectProjectImageRouter: SelectProjectImageRoutingLogic {
    
}


