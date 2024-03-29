//
//  SearchResultsRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 29/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

typealias SearchResultsRouterProtocol = NSObject & SearchResultsRoutingLogic & SearchResultsDataTransfer

protocol SearchResultsRoutingLogic {
    func routeBack()
    func routeToOnGoingProjectDetails()
    func routeToProfileDetails()
    func routeToFinishedProjectDetails()
}

protocol SearchResultsDataTransfer {
    var dataStore: SearchResultsDataStore? { get }
}

class SearchResultsRouter: NSObject, SearchResultsDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: SearchResultsDataStore?
    
    private func transferDataToProjectDetails(from source: SearchResultsDataStore,
                                              to destination: inout OnGoingProjectDetailsDataStore) {
        guard let project = source.selectedItem?.getRawValue() as? SearchResults.Info.Model.Project else { return }
        destination.receivedData = OnGoingProjectDetails.Info.Received.Project(projectId: project.id, notInvitedUsers: .empty)
        destination.routingContext = OnGoingProjectDetails.Info.Received.RoutingContext(context: .checkingProject)
    }
    
    private func transferDataToFinishedProjectDetails(from source: SearchResultsDataStore, to destination: inout FinishedProjectDetailsDataStore) {
        guard let project = source.selectedItem?.getRawValue() as? SearchResults.Info.Model.Project else { return }
        destination.receivedData = FinishedProjectDetails.Info.Received.Project(id: project.id)
        destination.routingModel = FinishedProjectDetails.Info.Received.Routing(context: .checking, routingMethod: .push)
    }
    
    private func transferDataToProfileDetails(from source: SearchResultsDataStore,
                                              to destination: inout ProfileDetailsDataStore) {
        guard let profile = source.selectedItem?.getRawValue() as? SearchResults.Info.Model.Profile else { return }
        destination.receivedUserData = ProfileDetails.Info.Received.User(userId: profile.id)
    }
}

extension SearchResultsRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        viewController?.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension SearchResultsRouter: SearchResultsRoutingLogic {
    
    func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func routeToOnGoingProjectDetails() {
        let vc = OnGoingProjectDetailsController()
        guard let source = dataStore,
              var destination = vc.router?.dataStore else { return }
        transferDataToProjectDetails(from: source, to: &destination)
        routeTo(nextVC: vc)
    }
    
    func routeToProfileDetails() {
        let vc = ProfileDetailsController()
        guard let source = dataStore,
              var destination = vc.router?.dataStore else { return }
        transferDataToProfileDetails(from: source, to: &destination)
        routeTo(nextVC: vc)
    }
    
    func routeToFinishedProjectDetails() {
        let vc = FinishedProjectDetailsController()
        guard let source = dataStore, var destination = vc.router?.dataStore else { return }
        transferDataToFinishedProjectDetails(from: source,
                                             to: &destination)
        routeTo(nextVC: vc)
    }
}
