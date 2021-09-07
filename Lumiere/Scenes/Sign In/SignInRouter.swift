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
    func routeToAccountRecovery()
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
        destination.receivedUserData = ProfileDetails.Info.Received.User(userId: loggedUser.id)
    }
    
    private func transferDataToMainFeed(from source: SignInDataStore,
                                        to destination: inout MainFeedDataStore) {
        destination.currentUserId = MainFeed.Info.Received.CurrentUser(currentUserId: source.loggedUser?.id ?? .empty)
    }
}

extension SignInRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        if nextVC is AccountRecoveryController {
            viewController?.navigationController?.present(nextVC, animated: true, completion: nil)
        } else {
            viewController?.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}

extension SignInRouter: SignInRoutingLogic {
    
    func routeToSignUp() {
        let signUpController = SignUpController()
        routeTo(nextVC: signUpController)
    }
    
    func routeToHome() {
        guard let source = dataStore else { return }
        
        let mainFeedVc = MainFeedController()
        let mainFeedTabItem = UITabBarItem(title: nil,
                                           image: MainFeed.Constants.Images.tabBarImage,
                                           selectedImage: MainFeed.Constants.Images.tabBarSelectedImage)
        mainFeedTabItem.tag = 0
        mainFeedVc.tabBarItem = mainFeedTabItem
        guard var destination = mainFeedVc.router?.dataStore else { return }
        transferDataToMainFeed(from: source, to: &destination)
        
        let selectProjectImageVc = SelectProjectImageController()
        let selectProjectImageTabItem = UITabBarItem(title: nil,
                                                     image: SelectProjectImage.Constants.Images.tabBarImage,
                                                     selectedImage: SelectProjectImage.Constants.Images.tabBarSelectedImage)
        selectProjectImageTabItem.tag = 1
        selectProjectImageVc.tabBarItem = selectProjectImageTabItem
        
        let notificationsVc = NotificationsController()
        let notificationsTabItem = UITabBarItem(title: nil,
                                                image: Notifications.Constants.Images.tabBarDefaultImage,
                                                selectedImage: Notifications.Constants.Images.tabBarSelectedImage)
        notificationsTabItem.tag = 2
        notificationsVc.tabBarItem = notificationsTabItem
        
        guard var notificationsDataStore = notificationsVc.router?.dataStore else {
            return
        }
        transferDataToNotifications(from: source, to: &notificationsDataStore)
        
        let profileDetailsVc = ProfileDetailsController()
        let profileDetailsTabItem = UITabBarItem(title: nil,
                                                 image: ProfileDetails.Constants.Images.tabBarDefaultImage,
                                                 selectedImage: ProfileDetails.Constants.Images.tabBarSelectedImage)
        profileDetailsTabItem.tag = 3
        profileDetailsVc.tabBarItem = profileDetailsTabItem
        
        guard var profileDetailsDataStore = profileDetailsVc.router?.dataStore else {
            return
        }
        transferDataToProfileDetails(from: source, to: &profileDetailsDataStore)
        
        let tabController = MainTabBarController()
        tabController.viewControllers = [UINavigationController(rootViewController:                                            mainFeedVc),
                                         UINavigationController(rootViewController: selectProjectImageVc),
                                         UINavigationController(rootViewController: notificationsVc),
                                         UINavigationController(rootViewController: profileDetailsVc)]
        routeTo(nextVC: tabController)
    }
    
    func routeToAccountRecovery() {
        let accountRecoveryController = AccountRecoveryController()
        accountRecoveryController.modalPresentationStyle = .fullScreen
        routeTo(nextVC: accountRecoveryController)
    }
}
