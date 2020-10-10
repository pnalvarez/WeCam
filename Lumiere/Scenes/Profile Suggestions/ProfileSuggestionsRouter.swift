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
    
}

protocol ProfileSuggestionsDataTransfer {
    var dataStore: ProfileSuggestionsDataStore? { get set }
}

class ProfileSuggestionsRouter: NSObject, ProfileSuggestionsDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: ProfileSuggestionsDataStore?
}

extension ProfileSuggestionsRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        
    }
}

extension ProfileSuggestionsRouter: ProfileSuggestionsRoutingLogic {
    
}
