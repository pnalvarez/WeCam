//
//  SelectProjectImagePresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 16/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

protocol SelectProjectImagePresentationLogic {
    func presentCathegories()
    func presentError(_ response: String)
}

class SelectProjectImagePresenter: SelectProjectImagePresentationLogic {
    
    private unowned var viewController: SelectProjectImageDisplayLogic
    
    init(viewController: SelectProjectImageDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentCathegories() {
        viewController.displaySelectCathegory()
    }
    
    func presentError(_ response: String) {
        viewController.displayErrorState()
        viewController.showAlertError(description: response)
    }
}
