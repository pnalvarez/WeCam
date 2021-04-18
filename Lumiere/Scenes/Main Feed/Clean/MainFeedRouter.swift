//
//  MainFeedRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

typealias MainFeedRouterProtocol = NSObject & MainFeedRoutingLogic & MainFeedDataTransfer

protocol MainFeedRoutingLogic {
    func routeToRecentSearches()
    func routeToProfileDetails()
    func routeToProfileSuggestions()
    func routeToOnGoingProjectDetails()
    func routeToFinishedProjectDetails()
    func routeToFilterCathegories()
}

protocol MainFeedDataTransfer {
    var dataStore: MainFeedDataStore? { get set }
}

class MainFeedRouter: NSObject, MainFeedDataTransfer {
    
    var dataStore: MainFeedDataStore?
    weak var viewController: UIViewController?
    
    private func transferDataToSearchResults(from source: MainFeedDataStore,
                                             to destination: inout SearchResultsDataStore) {
        destination.searchKey = SearchResults.Info.Received.SearchKey(key: source.searchKey?.key ?? .empty)
    }
    
    private func transferDataToProfileDetails(from source: MainFeedDataStore,
                                              to destination: inout ProfileDetailsDataStore) {
        destination.receivedUserData = ProfileDetails.Info.Received.User(userId: source.selectedProfile ?? .empty)
    }
    
    private func transferDataToOnGoingProjectDetails(from source: MainFeedDataStore,
                                                     to destination: inout OnGoingProjectDetailsDataStore) {
        destination.receivedData = OnGoingProjectDetails.Info.Received.Project(projectId: source.selectedProject ?? .empty,
                                                                               notInvitedUsers: .empty)
        destination.routingContext = OnGoingProjectDetails.Info.Received.RoutingContext(context: .checkingProject)
    }
    
    private func transferDataToFinishedProjectDetails(from source: MainFeedDataStore,
                                                      to destination: inout FinishedProjectDetailsDataStore) {
        destination.receivedData = FinishedProjectDetails.Info.Received.Project(id: source.selectedProject ?? .empty, userIdsNotInvited: .empty)
        destination.routingModel = FinishedProjectDetails.Info.Received.Routing(context: .checking, routingMethod: .push)
    }
}

extension MainFeedRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        viewController?.navigationController?.pushViewController(nextVC, animated: !(nextVC is RecentSearchController))
    }
}

extension MainFeedRouter: MainFeedRoutingLogic {
    
    func routeToRecentSearches() {
        let recentSearcVc = RecentSearchController()
        recentSearcVc.modalPresentationStyle = .fullScreen
        routeTo(nextVC: recentSearcVc)
    }
    
    func routeToProfileDetails() {
        let vc = ProfileDetailsController()
        guard let source = dataStore,
              var destination = vc.router?.dataStore else { return }
        transferDataToProfileDetails(from: source, to: &destination)
        routeTo(nextVC: vc)
    }
    
    func routeToProfileSuggestions() {
        let vc = ProfileSuggestionsController()
        routeTo(nextVC: vc)
    }
    
    func routeToOnGoingProjectDetails() {
        let vc = OnGoingProjectDetailsController()
        guard let source = dataStore,
              var destination = vc.router?.dataStore else { return }
        transferDataToOnGoingProjectDetails(from: source, to: &destination)
        routeTo(nextVC: vc)
    }
    
    func routeToFinishedProjectDetails() {
        let vc = FinishedProjectDetailsController()
        guard let source = dataStore,
              var destination = vc.router?.dataStore else { return }
        transferDataToFinishedProjectDetails(from: source, to: &destination)
        routeTo(nextVC: vc)
    }
    
    func routeToFilterCathegories() {
        let vc = FilterCathegoriesController()
        routeTo(nextVC: vc)
    }
}
