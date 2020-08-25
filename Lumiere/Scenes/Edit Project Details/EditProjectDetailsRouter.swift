//
//  EditProjectDetailsRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 21/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

typealias EditProjectDetailsRouterProtocol = NSObject & EditProjectDetailsRoutingLogic & EditProjectDetailsDataTransfer

protocol EditProjectDetailsRoutingLogic {
    func routeBack()
    func routeToInviteList()
    func routeToPublishedProjectDetails()
}

protocol EditProjectDetailsDataTransfer {
    var dataStore: EditProjectDetailsDataStore? { get set }
    var inviteListDelegate: InviteListDelegate? { get set }
}

class EditProjectDetailsRouter: NSObject, EditProjectDetailsDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: EditProjectDetailsDataStore?
    var inviteListDelegate: InviteListDelegate?
    
    private func transferDataToInviteList(from source: EditProjectDetailsDataStore,
                                          to destination: inout InviteListDataStore) {
        guard let invitedUsers = source.invitedUsers?.users else {
            return
        }
        destination.receivedInvites = InviteList.Info.Received.InvitedUsers(users: invitedUsers.map({InviteList.Info.Received.User(id: $0.id)}))
        destination.delegate = inviteListDelegate
    }
}

extension EditProjectDetailsRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        viewController?.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension EditProjectDetailsRouter: EditProjectDetailsRoutingLogic {
    
    func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func routeToInviteList() {
        let vc = InviteListController()
        guard let source = dataStore,
            var destination = vc.router?.dataStore else { return }
        transferDataToInviteList(from: source, to: &destination)
        routeTo(nextVC: vc)
    }
    
    func routeToPublishedProjectDetails() {
        
    }
}
