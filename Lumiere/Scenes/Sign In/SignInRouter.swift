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
    
    private func transferDataToNotifications(from source: SignInDataStore,
                                             to destination: inout NotificationsDataStore) {
        guard let id = source.loggedUser?.id else { return }
        destination.currentUser = Notifications.Info.Received.CurrentUser(userId: id)
    }
    
    private func transferDataToProfileDetails(from source: SignInDataStore,
                                              to destination: inout ProfileDetailsDataStore) {
        guard let loggedUser = source.loggedUser else { return }
        destination.userData = ProfileDetails.Info.Received.User(connectionType: .logged,
                                                                 id: loggedUser.id,
                                                                 image: loggedUser.image,
                                                                 name: loggedUser.name,
                                                                 ocupation: loggedUser.ocupation,
                                                                 email: loggedUser.email,
                                                                 phoneNumber: loggedUser.phoneNumber,
                                                                 connectionsCount: loggedUser.connectionsCount,
                                                                 progressingProjectsIds: [],
                                                                 finishedProjectsIds: [])
    }
}

extension SignInRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        viewController?.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension SignInRouter: SignInRoutingLogic {
    
    func routeToSignUp() {
        let signUpController = SignUpController()
        routeTo(nextVC: signUpController)
    }
    
    func routeToHome() {
        guard let source = dataStore else { return }
        
        let selectProjectImageVc = SelectProjectImageController()
        selectProjectImageVc.tabBarItem = UITabBarItem(title: nil,
                                                       image: SelectProjectImage.Constants.Images.tabBarImage,
                                                       selectedImage: SelectProjectImage.Constants.Images.tabBarSelectedImage)
        
        let notificationsVc = NotificationsController()
        notificationsVc.tabBarItem = UITabBarItem(title: nil,
                                                  image: Notifications.Constants.Images.tabBarDefaultImage,
                                                  selectedImage: Notifications.Constants.Images.tabBarSelectedImage)
        guard var notificationsDataStore = notificationsVc.router?.dataStore else {
            return
        }
        transferDataToNotifications(from: source, to: &notificationsDataStore)
        
        let profileDetailsVc = ProfileDetailsController()
        profileDetailsVc.tabBarItem = UITabBarItem(title: nil,
                                                   image: ProfileDetails.Constants.Images.tabBarDefaultImage,
                                                   selectedImage: ProfileDetails.Constants.Images.tabBarSelectedImage)
        guard var profileDetailsDataStore = profileDetailsVc.router?.dataStore else {
            return
        }
        transferDataToProfileDetails(from: source, to: &profileDetailsDataStore)
        
        let projectDetailsVc = OnGoingProjectDetailsController()
        profileDetailsVc.tabBarItem = UITabBarItem(title: nil,
                                                   image: ProfileDetails.Constants.Images.tabBarDefaultImage,
                                                   selectedImage: ProfileDetails.Constants.Images.tabBarSelectedImage)
        projectDetailsVc.router?.dataStore?.receivedData = OnGoingProjectDetails.Info.Received.Project(projectId: "-MFItlhEHI3aram2mV-v")
        
        let tabController = UITabBarController()
        tabController.viewControllers = [UINavigationController(rootViewController: projectDetailsVc),
                                         UINavigationController(rootViewController: notificationsVc),
                                         UINavigationController(rootViewController: profileDetailsVc)]

//        FirebaseAuthHelper().fetchSendConnectionRequest(request: ["userId": "NHTOCGn3SLPyLq7Nsfj2Y4yqkMl2"]) {
//            response in
//        }
        /////*****
//        let float: Float = 0.8
//        let headers: [String : Any] = ["payload": ["image": ProjectProgress.Constants.Images.logo?.jpegData(compressionQuality: 0.5),
//                                                   "cathegories": ["Animação"],
//                                                   "sinopsis": "Sinopse Teste",
//                                                   "needing": "Needing Teste",
//                                                   "percentage": float],
//                                       "participants": ["oqfulYH9jIRiUjHoYGTesByfUtb2",
//                                                        "vb0dzg25PqSyD1SkwsZ5CsZmKq23"]]
//        FirebaseAuthHelper().fetchCreateProject(request: headers) { response in
//
//        }
        routeTo(nextVC: tabController)
    }
}
