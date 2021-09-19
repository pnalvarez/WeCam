//
//  EditProfileDetailsRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 23/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit
import WCUIKit

typealias EditProfileDetailsRouterProtocol = NSObject & EditProfileDetailsRoutingLogic & EditProfileDetailsDataTransfer

protocol EditProfileDetailsRoutingLogic {
    func routeBack()
    func routeBackSuccess()
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
    
    func routeBack() {
        viewController?.dismiss(animated: true, completion: nil)
    }
    
    func routeBackSuccess() {
        guard let navigationController = viewController?.navigationController else { return }
        navigationController.popViewController(animated: true)
        if let view = navigationController.viewControllers.last?.view {
            WCToastView().show(withTitle: EditProfileDetails.Constants.Texts.editDetailsSuccessTitle, status: .success, in: view)
        }
    }
}
