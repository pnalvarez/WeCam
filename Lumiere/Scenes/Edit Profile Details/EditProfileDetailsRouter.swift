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
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func routeBackSuccess() {
        guard let navigationController = viewController?.navigationController else { return }
               navigationController.popViewController(animated: true)
               UIAlertController.displayAlert(in: navigationController,
                                              title: EditProfileDetails.Constants.Texts.editDetailsSuccessTitle,
                                              message: EditProfileDetails.Constants.Texts.editDetailsSucessMessage)
    }
}
