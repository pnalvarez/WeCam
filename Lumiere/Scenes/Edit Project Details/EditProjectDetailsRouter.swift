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
    func routeToInsertVideo()
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
        if let delegate = dataStore as? InviteListDelegate{
            destination.delegate = delegate
        }
    }
    
    private func transferDataToOnGoingProjectDetails(from source: EditProjectDetailsDataStore,
                                                     to destination: inout OnGoingProjectDetailsDataStore) {
        guard let project = source.publishedProject else { return }
        destination.receivedData = OnGoingProjectDetails.Info.Received.Project(projectId: project.id,
                                                                               notInvitedUsers: project.userIdsNotInvited)
        destination.routingContext = .justCreatedProject
    }
    
    private func transferDataToInsertMedia(from source: EditProjectDetailsDataStore,
                                           to destination: inout InsertVideoDataStore) {
        let project = InsertVideo
            .Info
            .Received
            .NewProject(title: source.publishingProject?.title ?? .empty,
                        sinopsis: source.publishingProject?.sinopsis ?? .empty,
                        image: source.publishingProject?.image ?? Data(),
                        cathegories: source.publishingProject?.cathegories ?? .empty, invitedUsers: source.invitedUsers?.users.map({$0.id}) ?? .empty)
        destination.receivedData = InsertVideo
            .Info
            .Received
            .ReceivedProject
            .new(project)
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
        let vc = OnGoingProjectDetailsController()
        guard let source = dataStore,
              var destination = vc.router?.dataStore else { return }
        transferDataToOnGoingProjectDetails(from: source, to: &destination)
        routeTo(nextVC: vc)
    }
    
    func routeToInsertVideo() {
        let vc = InsertVideoController()
        guard let source = dataStore,
              var destination = vc.router?.dataStore else { return }
        transferDataToInsertMedia(from: source, to: &destination)
        routeTo(nextVC: vc)
    }
}
