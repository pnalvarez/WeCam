//
//  ProfileDetailsRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

typealias ProfileDetailsRouterProtocol = NSObject & ProfileDetailsRoutingLogic & ProfileDetailsDataTransfer

protocol ProfileDetailsRoutingLogic {
    func routeBack()
    func routeToAllConnections()
    func routeToSignIn()
    func routeToEditProfileDetails()
    func routeToProjectDetails()
}

protocol ProfileDetailsDataTransfer {
    var dataStore: ProfileDetailsDataStore? { get set }
}

class ProfileDetailsRouter: NSObject, ProfileDetailsDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: ProfileDetailsDataStore?
    
    private func transferDataToConnectionsList(from source: ProfileDetailsDataStore,
                                               to destination: inout ConnectionsListDataStore) {
        guard let name = source.userDataModel?.name,
            let userId = source.userDataModel?.id else { return }
        let data = ConnectionsList.Info.Received.User(id: userId,
                                                      name: name,
                                                      userType: source.userDataModel?.connectionType == .logged ? .logged : .other)
        destination.userData = data
    }
    
    private func transferDataToProjectDetails(from source: ProfileDetailsDataStore,
                                              to destination: inout OnGoingProjectDetailsDataStore) {
        guard let projectId = source.selectedProject?.id else { return }
        destination.receivedData = OnGoingProjectDetails.Info.Received.Project(projectId: projectId, notInvitedUsers: .empty)
    }
}

extension ProfileDetailsRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        viewController?.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension ProfileDetailsRouter: ProfileDetailsRoutingLogic {
    
    func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func routeToAllConnections() {
        let vc = ConnectionsListController()
        guard let dataStore = dataStore,
            var destination = vc.router?.dataStore else {
                return
        }
        transferDataToConnectionsList(from: dataStore, to: &destination)
        routeTo(nextVC: vc)
    }
    
    func routeToSignIn() {
        viewController?.navigationController?.navigationController?.popToRootViewController(animated: true)
    }
    
    func routeToEditProfileDetails() {
        let vc = EditProfileDetailsController()
        viewController?.navigationController?.tabBarController?.tabBar.isHidden = true
        routeTo(nextVC: vc)
    }
    
    func routeToProjectDetails() {
        let vc = OnGoingProjectDetailsController()
        guard let source = dataStore,
            var destination = vc.router?.dataStore else { return }
        transferDataToProjectDetails(from: source, to: &destination)
        routeTo(nextVC: vc)
    }
}