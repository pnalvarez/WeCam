//
//  ProjectParticipantsListController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 05/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol ProjectParticipantsListDisplayLogic: class {
    
}

class ProjectParticipantsListController: BaseViewController {
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.bounces = false
        view.alwaysBounceVertical = false
        view.backgroundColor = .white
        view.assignProtocols(to: self)
        view.registerCell(cellType: ProjectParticipantsListTableViewCell.self)
        return view
    }()
    
    private lazy var closeButton: DefaultCloseButton = {
        let view = DefaultCloseButton(frame: .zero)
        return view
    }()
    
    private var interactor: ProjectParticipantsListInteractor?
    var router: ProjectParticipantsListRouterProtocol?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        let viewController = self
        let presenter = ProjectParticipantsListPresenter(viewController: viewController)
        let interactor = ProjectParticipantsListInteractor(presenter: presenter)
        let router = ProjectParticipantsListRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.dataStore = interactor
        router.viewController = viewController
    }
}

extension ProjectParticipantsListController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension ProjectParticipantsListController: UITableViewDelegate {
    
}

extension ProjectParticipantsListController: ProjectParticipantsListDisplayLogic {
    
}
