//
//  SelectProjectCathegoryRouter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

typealias SelectProjectCathegoryRouterProtocol = NSObject & SelectProjectCathegoryRoutingLogic & SelectProjectCathegoryDataTransfer

protocol SelectProjectCathegoryRoutingLogic {
    func routeToProjectProgress()
    func routeBack()
}

protocol SelectProjectCathegoryDataTransfer {
    var dataStore: SelectProjectCathegoryDataStore? { get set }
}

class SelectProjectCathegoryRouter: NSObject, SelectProjectCathegoryDataTransfer {
    
    weak var viewController: UIViewController?
    var dataStore: SelectProjectCathegoryDataStore?

    private func transferDataToProjectProgress(from source: SelectProjectCathegoryDataStore,
                                               to destination: inout ProjectProgressDataStore) {
        var cathegories = [String]()
        if let firstCathegory = source.selectedCathegories?.firstCathegory {
            cathegories.append(firstCathegory.rawValue)
        }
        if let secondCathegory = source.selectedCathegories?.secondCathegory {
            cathegories.append(secondCathegory.rawValue)
        }
        destination.projectData = ProjectProgress.Info.Received.Project(image: source.projectData?.image,
                                                                        cathegories: cathegories)
    }
}

extension SelectProjectCathegoryRouter: BaseRouterProtocol {
    
    func routeTo(nextVC: UIViewController) {
        viewController?.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension SelectProjectCathegoryRouter: SelectProjectCathegoryRoutingLogic {
    
    func routeToProjectProgress() {
        let vc = ProjectProgressController()
        guard let source = dataStore,
            var destination = vc.router?.dataStore else { return }
        transferDataToProjectProgress(from: source,
                                      to: &destination)
        routeTo(nextVC: vc)
    }
    
    func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
