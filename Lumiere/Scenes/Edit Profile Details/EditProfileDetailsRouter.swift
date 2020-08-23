//
//  EditProfileDetailsRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 23/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

typealias EditProfileDetailsRouterProtocol = NSObject & EditProfileDetailsRoutingLogic & EditProfileDetailsDataTransfer

protocol EditProfileDetailsRoutingLogic {
    
}

protocol EditProfileDetailsDataTransfer {
    var dataStore: EditProfileDetailsDataStore? { get set }
}

class EditProfileDetailsRouter: NSObject, EditProfileDetailsDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: EditProfileDetailsDataStore?
}

extension EditProfileDetailsRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        
    }
}

extension EditProfileDetailsRouter: EditProfileDetailsRoutingLogic {
    
}
