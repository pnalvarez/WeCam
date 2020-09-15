//
//  InviteProfileToProjectsController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 13/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol InviteProfileToProjectsDisplayLogic: class {
    func displayProjects(_ viewModel: InviteProfileToProjects.Info.ViewModel.UpcomingProjects)
    func displayRelationUpdate(_ viewModel: InviteProfileToProjects.Info.ViewModel.RelationUpdate)
    func displayConfirmationAlert(_ viewModel: InviteProfileToProjects.Info.ViewModel.Alert)
    func hideConfirmationAlert()
}

class InviteProfileToProjectsController: BaseViewController {
    
    private lazy var modalAlert: ConfirmationAlertView = {
        let view = ConfirmationAlertView(frame: .zero,
                                         delegate: self,
                                         text: .empty)
        return view
    }()
    
    private lazy var translucentView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = InviteProfileToProjects.Constants.Colors.translucentView
        view.isHidden = true
        return view
    }()
    
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
    
    private lazy var mainView: InviteProfileToProjectsView = {
        let view = InviteProfileToProjectsView(frame: .zero,
                                               backButton: backButton,
                                               searchTextField: searchTextField,
                                               tableView: tableView,
                                               translucentView: translucentView,
                                               modalAlert: modalAlert)
        return view
    }()
    
    private var viewModel: InviteProfileToProjects.Info.ViewModel.UpcomingProjects? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
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
        self.view = mainView
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
        return viewModel?.projects.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath, type: InviteProfileToProjectsTableViewCell.self)
        guard let viewModel = viewModel?.projects[indexPath.row] else { return UITableViewCell() }
        cell.setup(delegate: self,
                   index: indexPath.row,
                   viewModel: viewModel)
        return cell
    }
}

extension InviteProfileToProjectsController: UITableViewDelegate { }

extension InviteProfileToProjectsController: InviteProfileToProjectsTableViewCellDelegate {
    
    func didTapInteraction(index: Int) {
        
    }
}

extension InviteProfileToProjectsController: ConfirmationAlertViewDelegate {
    
    func didTapAccept() {
        
    }
    
    func didTapRefuse() {
        
    }
}

extension InviteProfileToProjectsController {
    
    @objc
    private func didSearchChange() {
        
    }
    
    @objc
    private func didTapBack() {
        router?.routeBack()
    }
}

extension InviteProfileToProjectsController: InviteProfileToProjectsDisplayLogic {
    
    func displayProjects(_ viewModel: InviteProfileToProjects.Info.ViewModel.UpcomingProjects) {
        self.viewModel = viewModel
    }
    
    func displayRelationUpdate(_ viewModel: InviteProfileToProjects.Info.ViewModel.RelationUpdate) {
        let cell = tableView.cellForRow(at: IndexPath(row: viewModel.index, section: 0), type: InviteProfileToProjectsTableViewCell.self)
        cell.updateRelation(relation: viewModel.relation)
    }
    
    func displayConfirmationAlert(_ viewModel: InviteProfileToProjects.Info.ViewModel.Alert) {
        mainView.displayConfirmationAlert(withText: viewModel.text)
    }
    
    func hideConfirmationAlert() {
        mainView.hideConfirmationAlert()
    }
}
