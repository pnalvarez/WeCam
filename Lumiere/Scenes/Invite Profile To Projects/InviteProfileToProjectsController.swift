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
    
    private lazy var backButton: DefaultBackButton = {
        let view = DefaultBackButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        return view
    }()
    
    private lazy var mainLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = InviteProfileToProjects.Constants.Texts.mainLbl
        view.textColor = InviteProfileToProjects.Constants.Colors.mainLbl
        view.font = InviteProfileToProjects.Constants.Fonts.mainLbl
        view.textAlignment = .left
        return view
    }()
    
    private lazy var searchTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.addTarget(self, action: #selector(didSearchChange), for: .editingChanged)
        view.layer.cornerRadius = 4
        view.textColor = InviteProfileToProjects.Constants.Colors.searchTextFieldText
        view.layer.borderWidth = 1
        view.layer.borderColor = InviteProfileToProjects.Constants.Colors.searchTextFieldLayer
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.separatorStyle = .none
        view.bounces = false
        view.alwaysBounceVertical = false
        view.assignProtocols(to: self)
        view.registerCell(cellType: InviteProfileToProjectsTableViewCell.self)
        return view
    }()
    
    private var interactor: InviteProfileToProjectsBusinessLogic?
    var router: InviteProfileToProjectsRouterProtocol?
    
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
    
    @objc
    private func didSearchChange() {
        
    }
    
    @objc
    private func didTapBack() {
        
    }
}

extension InviteProfileToProjectsController: InviteProfileToProjectsDisplayLogic {
    
}
