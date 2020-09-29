//
//  SearchResultsPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 29/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol SearchResultsPresentationLogic {
    
}

class SearchResultsPresenter: SearchResultsPresentationLogic {
    
    private unowned var viewController: SearchResultsDisplayLogic
    
    init(viewController: SearchResultsDisplayLogic) {
        self.viewController = viewController
    }
}
