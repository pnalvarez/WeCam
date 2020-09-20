//
//  MainFeedPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol MainFeedPresentationLogic {
    
}

class MainFeedPresenter: MainFeedPresentationLogic {
    
    private unowned var viewController: MainFeedDisplayLogic
    
    init(viewController: MainFeedDisplayLogic) {
        self.viewController = viewController
    }
}
