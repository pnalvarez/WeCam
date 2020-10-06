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
    func routeToSearchResults()
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
}

extension MainFeedRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        viewController?.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension MainFeedRouter: MainFeedRoutingLogic {
    
    func routeToSearchResults() {
        let vc = SearchResultsController()
        guard let source = dataStore,
              var destination = vc.router?.dataStore else { return }
        transferDataToSearchResults(from: source, to: &destination)
        routeTo(nextVC: vc)
    }
}
