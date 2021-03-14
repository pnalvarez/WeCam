//
//  RecentSearchRouter.swift
//  WeCam
//
//  Created by Pedro Alvarez on 13/03/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit

typealias RecentSearchRouterProtocol = NSObject & RecentSearchRoutingLogic & RecentSearchDataTransfer

protocol RecentSearchRoutingLogic {
    func routeToProfileDetails()
    func routeToOngoingProjectDetails()
    func routeToFinishedProjectDetails()
    func routeToSearchResults()
}

protocol RecentSearchDataTransfer {
    var dataStore: RecentSearchDataStore? { get set }
}

class RecentSearchRouter: NSObject, RecentSearchDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: RecentSearchDataStore?
    
    private func transferDataToProfileDetails(from source: RecentSearchDataStore, to destination: inout ProfileDetailsDataStore) {
        let user = ProfileDetails.Info.Received.User(userId: source.selectedUser ?? .empty)
        destination.receivedUserData = user
    }
    
    private func transferDataToOngoingProjectDetails(from source: RecentSearchDataStore, to destination: inout OnGoingProjectDetailsDataStore) {
        let project = OnGoingProjectDetails.Info.Received.Project(projectId: source.selectedOngoingProject ?? .empty, notInvitedUsers: .empty)
        destination.receivedData = project
        destination.routingContext = .checkingProject
    }
    
    private func transferDataToFinishedProjectDetails(from source: RecentSearchDataStore, to destination: inout FinishedProjectDetailsDataStore) {
        let project = FinishedProjectDetails.Info.Received.Project(id: source.selectedFinishedProject ?? .empty, userIdsNotInvited: .empty)
        let routing = FinishedProjectDetails.Info.Received.Routing(context: .checking, routingMethod: .push)
        destination.receivedData = project
        destination.routingModel = routing
    }
    
    private func transferDataToSearchResults(from source: RecentSearchDataStore, to destination: inout SearchResultsDataStore) {
        let searchKey = SearchResults.Info.Received.SearchKey(key: source.searchKey ?? .empty)
        destination.searchKey = searchKey
    }
}

extension RecentSearchRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        viewController?.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension RecentSearchRouter: RecentSearchRoutingLogic {
    
    func routeToProfileDetails() {
        let profileDetailsVc = ProfileDetailsController()
        guard let source = dataStore,
              var destination = profileDetailsVc.router?.dataStore else {
            return
        }
        transferDataToProfileDetails(from: source, to: &destination)
        routeTo(nextVC: profileDetailsVc)
    }
    
    func routeToOngoingProjectDetails() {
        let ongoingProjectDetailsVc = OnGoingProjectDetailsController()
        guard let source = dataStore,
              var destination = ongoingProjectDetailsVc.router?.dataStore else {
            return
        }
        transferDataToOngoingProjectDetails(from: source, to: &destination)
        routeTo(nextVC: ongoingProjectDetailsVc)
    }
    
    func routeToFinishedProjectDetails() {
        let finishedProjectDetailsVc = FinishedProjectDetailsController()
        guard let source = dataStore,
              var destination = finishedProjectDetailsVc.router?.dataStore else {
            return
        }
        transferDataToFinishedProjectDetails(from: source, to: &destination)
        routeTo(nextVC: finishedProjectDetailsVc)
    }
    
    func routeToSearchResults() {
        let searchResultsVc = SearchResultsController()
        guard let source = dataStore,
              var destination = searchResultsVc.router?.dataStore else {
            return
        }
        transferDataToSearchResults(from: source, to: &destination)
        routeTo(nextVC: searchResultsVc)
    }
}


