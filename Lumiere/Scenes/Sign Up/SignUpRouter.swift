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
        guard let navigationController = viewController?.navigationController else { return }
        let alertController = UIAlertController(title: "Cadastro efetivado", message: "Usuário foi cadastrado com sucesso em nosso banco de dados", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        viewController?.navigationController?.popViewController(animated: true)
        alertController.addAction(defaultAction)
        navigationController.popViewController(animated: true)
        navigationController.present(alertController, animated: true, completion: nil)
    }
    
    func routeBack(withError error: SignUp.Info.ViewModel.Error) {
        guard let navigationController = viewController?.navigationController else { return }
        let alertController = UIAlertController(title: "Erro no Cadastro",
                                                message: error.description,
                                                preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        navigationController.popViewController(animated: true)
        navigationController.present(alertController, animated: true, completion: nil)
    }
}
