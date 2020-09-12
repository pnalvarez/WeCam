//
//  OnGoingProjectInvitesController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 12/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol OnGoingProjectInvitesDisplayLogic: class {
    
}

class OnGoingProjectInvitesController: BaseViewController {
    
    private lazy var closeButton: DefaultCloseButton = {
        let view = DefaultCloseButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        return view
    }()
    
    private lazy var searchTextField: UITextField = {
        let view = UITextField(frame: .zero)
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.assignProtocols(to: self)
        view.bounces = false
        view.alwaysBounceVertical = false
 //
        return view
    }()
    
    private var interactor: OnGoingProjectInvitesBusinessLogic?
    var router: OnGoingProjectInvitesRouterProtocol?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
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
        let presenter = OnGoingProjectInvitesPresenter(viewController: viewController)
        let interactor = OnGoingProjectInvitesInteractor(presenter: presenter)
        let router = OnGoingProjectInvitesRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.dataStore = interactor
        router.viewController = viewController
    }
}

extension OnGoingProjectInvitesController {
    
    @objc
    private func didTapClose() {
        
    }
}

extension OnGoingProjectInvitesController: UITableViewDelegate {
    
}

extension OnGoingProjectInvitesController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension OnGoingProjectInvitesController: OnGoingProjectInvitesDisplayLogic {
    
}