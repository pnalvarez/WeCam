//
//  SearchResultsController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 29/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol SearchResultsDisplayLogic: class {
    func displaySearchResults(_ viewModel: SearchResults.Info.ViewModel.UpcomingResults)
    func displayProfileDetails()
    func displayProjectDetails()
    func displayLoading(_ loading: Bool)
}

class SearchResultsController: BaseViewController {
    
    private lazy var activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.backgroundColor = .white
        view.color = .black
        view.startAnimating()
        view.isHidden = true
        return view
    }()
    
    private lazy var backButton: DefaultBackButton = {
        let view = DefaultBackButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        return view
    }()
    
    private lazy var searchTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.textColor = SearchResults.Constants.Colors.searchTextFieldText
        view.font = SearchResults.Constants.Fonts.searchTextField
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 1
        view.layer.borderColor = SearchResults.Constants.Colors.searchTextFieldLayer
        return view
    }()
    
    private lazy var searchButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapSearch), for: .touchUpInside)
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.assignProtocols(to: self)
        view.bounces = false
        view.alwaysBounceVertical = false
        view.separatorStyle = .none
        return view
    }()
    
    private lazy var mainView: SearchResultsView = {
        let view = SearchResultsView(frame: .zero,
                                     activityView: activityView,
                                     backButton: backButton,
                                     searchTextField: searchTextField,
                                     searchButton: searchButton,
                                     tableView: tableView)
        view.backgroundColor = .white
        return view
    }()
    
    private var viewModel: SearchResults.Info.ViewModel.UpcomingResults? {
        didSet {
            refreshList()
        }
    }
    
    private var sections: [TableViewSectionProtocol]?
    
    private var factory: TableViewFactory?
    private var interactor: SearchResultsBusinessLogic?
    var router: SearchResultsRouterProtocol?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        factory = SearchResultsFactory(tableView: tableView)
        refreshList()
        interactor?.fetchBeginSearch(SearchResults.Request.Search())
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    private func setup() {
        let viewController = self
        let presenter = SearchResultsPresenter(viewController: viewController)
        let interactor = SearchResultsInteractor(presenter: presenter)
        let router = SearchResultsRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.dataStore = interactor
        router.viewController = viewController
    }
}

extension SearchResultsController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections?[section].numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return sections?[indexPath.row].cellAt(indexPath: indexPath, tableView: tableView) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections?[indexPath.row].cellHeightFor(indexPath: indexPath) ?? 0
    }
}

extension SearchResultsController: UITableViewDelegate {
    
}

extension SearchResultsController {
    
    private func refreshList() {
        sections = factory?.buildSections()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension SearchResultsController {
    
    @objc
    private func didTapBack() {
        router?.routeBack()
    }
    
    @objc
    private func didTapSearch() {
        interactor?.fetchSearch(SearchResults
                                    .Request
                                    .SearchWithPreffix(preffix: searchTextField.text ?? .empty))
    }
}

extension SearchResultsController: SearchResultsDisplayLogic {
    
    func displaySearchResults(_ viewModel: SearchResults.Info.ViewModel.UpcomingResults) {
        self.viewModel = viewModel
    }
    
    func displayProfileDetails() {
        router?.routeToProfileDetails()
    }
    
    func displayProjectDetails() {
        router?.routeToProjectDetails()
    }
    
    func displayLoading(_ loading: Bool) {
        activityView.isHidden = !loading
    }
}
