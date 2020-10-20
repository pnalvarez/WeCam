//
//  MainFeedController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol MainFeedDisplayLogic: class {
    func displaySearchResults()
    func displayProfileSuggestions(_ viewModel: MainFeed.Info.ViewModel.UpcomingProfiles)
    func displayProfileDetails()
    func displayOnGoingProjectsFeed(_ viewModel: MainFeed.Info.ViewModel.UpcomingProjects)
    func displayOnGoingProjectDetails()
    func displayOnGoingProjectsCriterias(_ viewModel: MainFeed.Info.ViewModel.UpcomingOnGoingProjectsCriterias)
}

class MainFeedController: BaseViewController {
    
    private lazy var tableView: MainFeedTableView = {
        let view = MainFeedTableView(frame: .zero)
        view.assignProtocols(to: self)
        return view
    }()
    
    private var sections: [TableViewSectionProtocol]?
    
    private var factory: MainFeedTableViewFactory?
    private var interactor: MainFeedBusinessLogic?
    var router: MainFeedRouterProtocol?
    
    private var profileSuggestionsViewModel: MainFeed.Info.ViewModel.UpcomingProfiles?
    private var ongoingProjectsFeedViewModel: MainFeed.Info.ViewModel.UpcomingProjects?
    private var ongoingProjectsCriteriaViewModel: MainFeed.Info.ViewModel.UpcomingOnGoingProjectsCriterias?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.fetchSuggestedProfiles(MainFeed.Request.FetchSuggestedProfiles())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        flushProfileSuggestions()
        flushOnGoingProjectsFeed()
    }
    
    private func setup() {
        let viewController = self
        let presenter = MainFeedPresenter(viewController: viewController)
        let interactor = MainFeedInteractor(presenter: presenter)
        let router = MainFeedRouter()
        viewController.interactor = interactor
        viewController.router = router
        viewController.factory = factory
        router.dataStore = interactor
        router.viewController = viewController
    }
}

extension MainFeedController {
    
    private func refreshTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func flushProfileSuggestions() {
        profileSuggestionsViewModel = nil
        let cell = tableView.cellForRow(at: IndexPath(row: MainFeed.Constants.BusinessLogic.CellIndexes.profileSuggestions.rawValue,
                                                      section: MainFeed.Constants.BusinessLogic.Sections.defaultFeed.rawValue),
                                        type: ProfileSuggestionsFeedTableViewCell.self)
        cell.flushItems()
    }
    
    private func flushOnGoingProjectsFeed() {
        ongoingProjectsFeedViewModel = nil
        let cell = tableView.cellForRow(at: IndexPath(row: MainFeed.Constants.BusinessLogic.CellIndexes.ongoingProjectsSuggestions.rawValue, section: MainFeed.Constants.BusinessLogic.Sections.defaultFeed.rawValue),
                                        type: OnGoingProjectsFeedTableViewCell.self)
        cell.flushItems()
    }
}

extension MainFeedController: SearchHeaderTableViewCellDelegate {
    
    func didTapSearch(withText text: String) {
        interactor?.fetchSearch(MainFeed.Request.Search(key: text))
    }
}

extension MainFeedController: ProfileSuggestionsFeedTableViewCellDelegate {
    
    func didTapProfileSuggestion(index: Int) {
        interactor?.didSelectSuggestedProfile(MainFeed.Request.SelectSuggestedProfile(index: index))
    }
    
    func didTapSeeAll() {
        router?.routeToProfileSuggestions()
    }
}

extension MainFeedController: OnGoingProjectsFeedTableViewCellDelegate {
    
    func didSelectProject(index: Int) {
        interactor?.didSelectOnGoingProject(MainFeed.Request.SelectOnGoingProject(index: index))
    }
    
    func didSelectedNewCriteria(text: String) {
        interactor?.didSelectOnGoingProjectCathegory(MainFeed.Request.SelectOnGoingProjectCathegory(text: text))
    }
}

extension MainFeedController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections?[section].numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = sections?[indexPath.section].builders[indexPath.row].cellAt(indexPath: indexPath, tableView: tableView) else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sections?[section].headerView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sections?[section].heightForHeader() ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections?[indexPath.section].cellHeightFor(indexPath: indexPath) ?? 0
    }
}

extension MainFeedController: UITableViewDelegate { }

extension MainFeedController: MainFeedDisplayLogic {
    
    func displaySearchResults() {
        router?.routeToSearchResults()
    }
    
    func displayProfileSuggestions(_ viewModel: MainFeed.Info.ViewModel.UpcomingProfiles) {
        self.profileSuggestionsViewModel = viewModel
        interactor?.fetchOnGoingProjectsFeed(MainFeed.Request.RequestOnGoingProjectsFeed(item: "Todos"))
    }
    
    func displayProfileDetails() {
        router?.routeToProfileDetails()
    }
    
    func displayOnGoingProjectsFeed(_ viewModel: MainFeed.Info.ViewModel.UpcomingProjects) {
        self.ongoingProjectsFeedViewModel = viewModel
        interactor?.fetchInterestCathegories(MainFeed.Request.FetchInterestCathegories())
    }
    
    func displayOnGoingProjectDetails() {
        router?.routeToOnGoingProjectDetails()
    }
    
    func displayOnGoingProjectsCriterias(_ viewModel: MainFeed.Info.ViewModel.UpcomingOnGoingProjectsCriterias) {
        self.ongoingProjectsCriteriaViewModel = viewModel
        factory = MainFeedTableViewFactory(tableView: tableView,
                                           profileSuggestionsViewModel: profileSuggestionsViewModel,
                                           ongoingProjectsViewModel: ongoingProjectsFeedViewModel,
                                           ongoingProjectsCriterias: ongoingProjectsCriteriaViewModel,
                                           searchDelegate: self,
                                           profileSuggestionsDelegate: self,
                                           ongoingProjectsFeedDelegate: self)
        sections = factory?.buildSections()
        refreshTableView()
    }
}
