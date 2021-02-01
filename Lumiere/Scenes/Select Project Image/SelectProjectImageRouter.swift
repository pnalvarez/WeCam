//
//  SelectProjectImageRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 16/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

typealias SelectProjectImageRouterProtocol = NSObject & SelectProjectImageRoutingLogic & SelectProjectImageDataTransfer

protocol SelectProjectImageRoutingLogic {
    func routeToCategories()
}

protocol SelectProjectImageDataTransfer {
    var dataStore: SelectProjectImageDataStore? { get set }
}

class SelectProjectImageRouter: NSObject, SelectProjectImageDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: SelectProjectImageDataStore?
    
    private func transferDataToCathegories(from source: SelectProjectImageDataStore,
                                           to destination: inout SelectProjectCathegoryDataStore) {
        destination.projectData = SelectProjectCathegory.Info.Received.Project(image: source.projectModel?.image)
    }
}

extension SelectProjectImageRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        viewController?.present(nextVC, animated: true, completion: {
            if let selectImageVC = self.viewController as? SelectProjectImageController {
                selectImageVC.clearImage()
            }
        })
    }
}

extension SelectProjectImageRouter: SelectProjectImageRoutingLogic {
    
    func routeToCategories() {
        let vc = SelectProjectCathegoryController()
        guard let source = dataStore,
            var destination = vc.router?.dataStore else {
                return
        }
        transferDataToCathegories(from: source, to: &destination)
        vc.modalPresentationStyle = .fullScreen
        routeTo(nextVC: vc)
    }
}


