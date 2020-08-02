//
//  SignInRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 02/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

typealias SignInRouterProtocol = NSObject & SignInRoutingLogic & SignInDataTransfer

protocol SignInRoutingLogic {
    func routeToSignUp()
    func routeToHome()
}

protocol SignInDataTransfer {
    var dataStore: SignInDataStore? { get set }
}

class SignInRouter: NSObject, SignInDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: SignInDataStore?
}

extension SignInRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        viewController?.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension SignInRouter: SignInRoutingLogic {
    
    func routeToSignUp() {
           let signUpController = SignUpController()
           viewController?.navigationController?.pushViewController(signUpController, animated: true)
       }
    
    func routeToHome() {
        let vc = ProfileDetailsController()
        guard var dataStore = vc.router?.dataStore else { return }
        dataStore.userData = ProfileDetails.Info.Received.User(id: "TDPWhy2FadewBoNsm5yP7leuhJ03",
                                                               image: nil,
                                                               name: "User Test",
                                                               occupation: "Artist",
                                                               email: "user@hotmail.com",
                                                               phoneNumber: "(20) 2294-5711",
                                                               connectionsCount: 1020,
                                                               progressingProjectsIds: [],
                                                               finishedProjectsIds: [])
        routeTo(nextVC: vc)
    }
}
