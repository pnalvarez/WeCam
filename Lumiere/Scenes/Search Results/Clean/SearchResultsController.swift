//
//  SearchResultsController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 29/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

protocol SearchResultsDisplayLogic: ViewInterface {
    func displaySearchResults(_ viewModel: SearchResults.Info.ViewModel.UpcomingResults)
    func displayProfileDetails()
    func displayOnGoingProjectDetails()
    func displayFinishedProjectDetails()
    func displayResultTypes(_ viewModel: SearchResults.Info.ViewModel.UpcomingTypes)
}

class SearchResultsController: BaseViewController, HasTabBar {
    
    private lazy var resultTypeOptionsToolbar: WCOptionsToolbar = {
        let view = WCOptionsToolbar(frame: .zero)
        view.delegate = self
        return view
    }()
    
    private lazy var resultsQuantityLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.textColor = SearchResults.Constants.Colors.resultsQuantityLbl
        view.font = SearchResults.Constants.Fonts.resultsQuantityLbl
        view.textAlignment = .center
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.registerCell(cellType: ProfileResultTableViewCell.self)
        view.registerCell(cellType: OnGoingProjectResultTableViewCell.self)
        view.assignProtocols(to: self)
        view.bounces = false
        view.alwaysBounceVertical = false
        view.separatorStyle = .none
        return view
    }()
    
    private lazy var mainView: SearchResultsView = {
        let view = SearchResultsView(frame: .zero,
                                     resultTypesOptionsToolbar: resultTypeOptionsToolbar,
                                     resultsQuantityLbl: resultsQuantityLbl,
                                     tableView: tableView)
        return view
    }()
    
    private var viewModel: SearchResults.Info.ViewModel.UpcomingResults? {
        didSet {
            setupUI()
            refreshList()
        }
    }
    
    private var selectedResultTypeIndex: Int = 0 {
        didSet {
            didChangeSelectedType()
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
        interactor?.fetchResultTypes(SearchResults.Request.FetchResultTypes())
        factory = SearchResultsFactory(tableView: tableView)
        refreshList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    private func refreshList() {
        guard let results = viewModel,
              let factory = factory as? SearchResultsFactory else { return }
        factory.viewModel = results
        sections = factory.buildSections()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func setupUI() {
        if selectedResultTypeIndex == 0 {
            resultsQuantityLbl.text = String(viewModel?.users.count ?? 0) + SearchResults.Constants.Texts.resultsQuantityLbl
        } else {
            resultsQuantityLbl.text = String(viewModel?.projects.count ?? 0) + SearchResults.Constants.Texts.resultsQuantityLbl
        }
    }
    
    private func checkEmptyList(withType type: SearchResults.Info.ViewModel.SelectedType) {
        switch type {
        case .profile:
            tableView.backgroundView = viewModel?.users.isEmpty ?? true ? WCEmptyListView(frame: .zero, text: SearchResults.Constants.Texts.emptyListResult) : nil
        case .project:
            tableView.backgroundView = viewModel?.projects.isEmpty ?? true ? WCEmptyListView(frame: .zero, text: SearchResults.Constants.Texts.emptyListResult) : nil
        }
    }
    
    private func didChangeSelectedType() {
        guard let factory = factory as? SearchResultsFactory else {
            return
        }
        var selectedType: SearchResults.Info.ViewModel.SelectedType
        if selectedResultTypeIndex == 0 {
            selectedType = .profile
            resultsQuantityLbl.text = String(viewModel?.users.count ?? 0) + SearchResults.Constants.Texts.resultsQuantityLbl
            checkEmptyList(withType: .profile)
        } else {
            selectedType = .project
            resultsQuantityLbl.text = String(viewModel?.projects.count ?? 0) + SearchResults.Constants.Texts.resultsQuantityLbl
            checkEmptyList(withType: .project)
        }
        factory.selectedType = selectedType
        sections = factory.buildSections()
        refreshList()
    }
}

extension SearchResultsController: WCOptionsToolbarDelegate {
    
    func optionsToolbar(selectedButton index: Int, optionsToolbar: WCOptionsToolbar) {
        selectedResultTypeIndex = index
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
        return sections?[indexPath.section].cellAt(indexPath: indexPath, tableView: tableView) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections?[indexPath.section].cellHeightFor(indexPath: indexPath) ?? 0
    }
}

extension SearchResultsController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var resultType: SearchResults.Request.ResultType
        if selectedResultTypeIndex == 0 {
            resultType = .profile
        } else {
            resultType = .project
        }
        let request = SearchResults.Request.SelectItem(index: indexPath.row, type: resultType)
        interactor?.fetchSelectItem(request)
    }
}

extension SearchResultsController: SearchResultsDisplayLogic {
    
    func displaySearchResults(_ viewModel: SearchResults.Info.ViewModel.UpcomingResults) {
        self.viewModel = viewModel
        if selectedResultTypeIndex == 0 {
            checkEmptyList(withType: .profile)
        } else {
            checkEmptyList(withType: .project)
        }
    }
    
    func displayProfileDetails() {
        router?.routeToProfileDetails()
    }
    
    func displayOnGoingProjectDetails() {
        router?.routeToOnGoingProjectDetails()
    }
    
    func displayFinishedProjectDetails() {
        router?.routeToFinishedProjectDetails()
    }
    
    func displayResultTypes(_ viewModel: SearchResults.Info.ViewModel.UpcomingTypes) {
        resultTypeOptionsToolbar.setupToolbarLayout(optionNames: viewModel.types.map({ $0.text }),
                                                    fixedWidth: true)
        checkEmptyList(withType: .profile)
    }
}
