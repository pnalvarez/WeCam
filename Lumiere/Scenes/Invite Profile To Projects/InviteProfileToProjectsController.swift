//
//  InviteProfileToProjectsController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 13/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol InviteProfileToProjectsDisplayLogic: class {
    
}

class InviteProfileToProjectsController: BaseViewController {
    
    private var interactor: InviteProfileToProjectsBusinessLogic?
    var router: InviteProfileToProjectsRouterProtocol?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
    }
    
    private func setup() {
        let viewController = self
        let presenter = InviteProfileToProjectsPresenter(viewController: viewController)
        let interactor = InviteProfileToProjectsInteractor(presenter: presenter)
        let router = InviteProfileToProjectsRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.dataStore = interactor
        router.viewController = viewController
    }
}

extension InviteProfileToProjectsController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension InviteProfileToProjectsController: UITableViewDelegate {
    
}

extension InviteProfileToProjectsController {
    
}

extension InviteProfileToProjectsController: InviteProfileToProjectsDisplayLogic {
    
}
