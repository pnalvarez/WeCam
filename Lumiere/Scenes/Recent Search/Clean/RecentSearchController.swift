//
//  RecentSearchIController.swift
//  WeCam
//
//  Created by Pedro Alvarez on 11/03/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

protocol RecentSearchDisplayLogic: ViewInterface {
    func displayRecentSearches(_ viewModel: RecentSearch.Info.ViewModel.UpcomingResults)
    func displayProfileDetails()
    func displayOnGoingProjectDetails()
    func displayFinishedProjectDetails()
    func displaySearchResults()
}

class RecentSearchController: BaseViewController {

    private lazy var searchTextField: WCSearchTextField = {
        let view = WCSearchTextField(frame: .zero)
        view.searchDelegate = self
        return view
    }()
    
    private lazy var resultsTableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.separatorStyle = .none
        view.backgroundColor = ThemeColors.whiteThemeColor.rawValue
        view.registerCell(cellType: RecentSearchTableViewCell.self)
        view.bounces = false
        view.alwaysBounceVertical = false
        view.assignProtocols(to: self)
        return view
    }()
    
    private lazy var mainView: RecentSearchView = {
        let view = RecentSearchView(frame: .zero,
                                    searchTextField: searchTextField,
                                    resultsTableView: resultsTableView)
        return view
    }()
    
    private var interactor: RecentSearchBusinessLogic?
    var router: RecentSearchRouterProtocol?
    
    private var viewModel: RecentSearch.Info.ViewModel.UpcomingResults? {
        didSet {
            DispatchQueue.main.async {
                self.resultsTableView.reloadData()
            }
        }
    }
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.fetchRecentSearches(RecentSearch.Request.FetchRecentSearches())
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    private func setup() {
        let viewController = self
        let presenter = RecentSearchPresenter(viewController: viewController)
        let interactor = RecentSearchInteractor(presenter: presenter)
        let router = RecentSearchRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.dataStore = interactor
        router.viewController = viewController
    }
}

extension RecentSearchController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.searches.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let search = viewModel?.searches[indexPath.row] else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(indexPath: indexPath, type: RecentSearchTableViewCell.self)
        cell.setup(viewModel: search)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.didSelectSearch(RecentSearch.Request.SelectSearch(index: indexPath.row))
    }
}

extension RecentSearchController: WCSearchTextFieldDelegate {
    
    func didTapSearch(searchTextField: WCSearchTextField) {
        interactor?.didTapSearchAction(RecentSearch.Request.SearchAction(text: searchTextField.text ?? .empty))
    }
}

extension RecentSearchController: RecentSearchDisplayLogic {
    
    func displayRecentSearches(_ viewModel: RecentSearch.Info.ViewModel.UpcomingResults) {
        self.viewModel = viewModel
    }
    
    func displayProfileDetails() {
        router?.routeToProfileDetails()
    }
    
    func displayOnGoingProjectDetails() {
        router?.routeToOngoingProjectDetails()
    }
    
    func displayFinishedProjectDetails() {
        router?.routeToFinishedProjectDetails()
    }
    
    func displaySearchResults() {
        router?.routeToSearchResults()
    }
}
