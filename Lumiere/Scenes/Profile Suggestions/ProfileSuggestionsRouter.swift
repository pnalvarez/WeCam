//
//  ProfileSuggestionsRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 10/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

typealias ProfileSuggestionsRouterProtocol = NSObject & ProfileSuggestionsRoutingLogic & ProfileSuggestionsDataTransfer

protocol ProfileSuggestionsRoutingLogic {
    func routeToProfileDetails()
    func routeBack()
}

protocol ProfileSuggestionsDataTransfer {
    var dataStore: ProfileSuggestionsDataStore? { get set }
}

class ProfileSuggestionsRouter: NSObject, ProfileSuggestionsDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: ProfileSuggestionsDataStore?
    
    private func transferDataToProfileDetails(from source: ProfileSuggestionsDataStore,
                                              to destination: inout ProfileDetailsDataStore) {
        destination.receivedUserData = ProfileDetails.Info.Received.User(userId: source.selectedProfile ?? .empty)
    }
}

extension ProfileSuggestionsRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        viewController?.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension ProfileSuggestionsRouter: ProfileSuggestionsRoutingLogic {
    
    func routeToProfileDetails() {
        let vc = ProfileDetailsController()
        guard let source = dataStore,
              var destination = vc.router?.dataStore else { return }
        transferDataToProfileDetails(from: source, to: &destination)
        routeTo(nextVC: vc)
    }
    
    func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
