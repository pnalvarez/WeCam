//
//  InviteListController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 24/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol InviteListDisplayLogic: class {
    func displayConnections(_ viewModel: InviteList.Info.ViewModel.Connections)
    func displayLoading(_ loading: Bool)
}

class InviteListController: BaseViewController {
    
    private lazy var loadingView: LoadingView = {
        let view = LoadingView(frame: .zero)
        view.animateRotate()
        view.isHidden = true
        return view
    }()
    
    private lazy var activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.startAnimating()
        view.color = .black
        view.backgroundColor = .white
        view.isHidden = true
        return view
    }()
    
    private lazy var searchTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.addTarget(self, action: #selector(didChangeSearchValue), for: .valueChanged)
        view.layer.borderWidth = 1
        view.layer.borderColor = InviteList.Constants.Colors.searchTextFieldLayer
        view.backgroundColor = InviteList.Constants.Colors.searchTextFieldBackground
        view.textColor = InviteList.Constants.Colors.searchTextFieldText
        view.font = InviteList.Constants.Fonts.searchTextField
        view.layer.cornerRadius = 4
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        view.setImage(InviteList.Constants.Images.closeButton, for: .normal)
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.assignProtocols(to: self)
        view.registerCell(cellType: InviteListTableViewCell.self)
        view.bounces = false
        view.alwaysBounceVertical = false
        view.separatorStyle = .none
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var mainView: InviteListView = {
        let view = InviteListView(frame: .zero,
                                  loadingView: loadingView,
                                  activityView: activityView,
                                  closeButton: closeButton,
                                  searchTextField: searchTextField,
                                  tableView: tableView)
        return view
    }()
    
    private var indicatedView: UIView?
    
    private var connectionsViewModel: InviteList.Info.ViewModel.Connections? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private var interactor: InviteListBusinessLogic?
    var router: InviteListRouterProtocol?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicatedView = activityView
        navigationController?.isNavigationBarHidden = true
        interactor?.fetchConnections(InviteList.Request.FetchConnections())
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    private func setup() {
        let viewController = self
        let presenter = InviteListPresenter(viewController: viewController)
        let interactor = InviteListInteractor(presenter: presenter)
        let router = InviteListRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.dataStore = interactor
        router.viewController = viewController
    }
}

extension InviteListController: UITableViewDelegate {
    
}

extension InviteListController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return connectionsViewModel?.users.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath, type: InviteListTableViewCell.self)
        guard let viewModel = connectionsViewModel?.users[indexPath.row] else { return UITableViewCell() }
        cell.setup(viewModel: viewModel,
                   index: indexPath.row,
                   delegate: self)
        return cell
    }
}

extension InviteListController: InviteListTableViewCellDelegate {
    
    func didSelectCell(index: Int) {
        interactor?.fetchSelectUser(InviteList.Request.SelectUser(index: index))
    }
}

extension InviteListController {
    
    @objc
    private func didChangeSearchValue() {
        interactor?.fetchSearch(InviteList.Request.Search(preffix: searchTextField.text ?? .empty))
    }
    
    @objc
    private func didTapClose() {
        router?.routeBack()
    }
}
extension InviteListController: InviteListDisplayLogic {
    
    func displayConnections(_ viewModel: InviteList.Info.ViewModel.Connections) {
        self.connectionsViewModel = viewModel
    }
    
    func displayLoading(_ loading: Bool) {
        activityView.isHidden = !loading
    }
}
