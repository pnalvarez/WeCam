//
//  SignUpRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 03/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

typealias SignUpRouterProtocol = NSObject & SignUpRoutingLogic & SignUpDataTransfer

protocol SignUpRoutingLogic {
    func routeToHome()
    func routeBack()
    func routeBackSuccess()
    func routeBack(withError error: SignUp.Info.ViewModel.Error)
}

protocol SignUpDataTransfer {
    var dataStore: SignUpDataStore? { get set }
}

class SignUpRouter: NSObject, SignUpDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: SignUpDataStore?
}

extension SignUpRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        viewController?.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension SignUpRouter: SignUpRoutingLogic {
    
    func routeToHome() {
        //ROUTE TO HOME
    }
    
    func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func routeBackSuccess() {
        guard let navigationController = viewController?.navigationController else { return }
        navigationController.popViewController(animated: true)
        UIAlertController.displayAlert(in: navigationController,
                                       title: SignUp.Constants.Texts.signUpSuccess,
                                       message: SignUp.Constants.Texts.successMessage)
    }
    
    func routeBack(withError error: SignUp.Info.ViewModel.Error) {
        guard let navigationController = viewController?.navigationController else { return }
        navigationController.popViewController(animated: true)
        UIAlertController.displayAlert(in: navigationController,
                                       title: SignUp.Constants.Texts.signUpError,
                                       message: error.description)
    }
}
