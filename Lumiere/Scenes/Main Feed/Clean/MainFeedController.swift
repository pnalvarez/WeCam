//
//  MainFeedController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol MainFeedDisplayLogic: class {
    func displayProfileDetails()
    func displayOnGoingProjectDetails()
    func displayFinishedProjectDetails()
    func displayError(_ viewModel: MainFeed.Info.ViewModel.Error)
    func displayFeedData(_ viewModel: MainFeed.Info.ViewModel.UpcomingFeedData)
    func displayGenericError()
}

class MainFeedController: BaseViewController {
    
    private lazy var errorView: EmptyListView = {
        let view = EmptyListView(frame: .zero, text: MainFeed.Constants.Texts.genericError)
        return view
    }()
    
    private lazy var tableView: MainFeedTableView = {
        let view = MainFeedTableView(frame: .zero, errorView: errorView)
        view.assignProtocols(to: self)
        return view
    }()
    
    private var sections: [TableViewSectionProtocol]?
    
    private var factory: MainFeedTableViewFactory?
    private var interactor: MainFeedBusinessLogic?
    var router: MainFeedRouterProtocol?
    
    private var viewModel: MainFeed.Info.ViewModel.UpcomingFeedData? {
        didSet {
            factory = MainFeedTableViewFactory(tableView: tableView,
                                               viewModel: viewModel,
                                               searchDelegate: self,
                                               profileSuggestionsDelegate: self,
                                               ongoingProjectsFeedDelegate: self,
                                               finishedProjectsFeedDelegate: self)
            sections = factory?.buildSections()
            refreshTableView()
        }
    }
    
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
        navigationController?.tabBarController?.tabBar.isHidden = false
        interactor?.fetchMainFeed(MainFeed.Request.MainFeed())
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
}

extension MainFeedController: SearchHeaderTableViewCellDelegate {
    
    func didTapSearch() {
        router?.routeToRecentSearches()
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

extension MainFeedController: FinishedProjectFeedTableViewCellDelegate {
    
    func didSelectFinishedProject(projectIndex: Int, cathegoryIndex: Int) {
        interactor?.didSelectFinishedProject(MainFeed.Request.SelectFinishedProject(projectIndex: projectIndex, catheghoryIndex: cathegoryIndex))
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
    
    func displayProfileDetails() {
        router?.routeToProfileDetails()
    }
    
    func displayOnGoingProjectDetails() {
        router?.routeToOnGoingProjectDetails()
    }
    
    func displayFinishedProjectDetails() {
        router?.routeToFinishedProjectDetails()
    }
    
    func displayError(_ viewModel: MainFeed.Info.ViewModel.Error) {
        UIAlertController.displayAlert(in: self,
                                       title: viewModel.title,
                                       message: viewModel.message)
    }
    
    func displayFeedData(_ viewModel: MainFeed.Info.ViewModel.UpcomingFeedData) {
        self.viewModel = viewModel
    }
    
    func displayGenericError() {
        
    }
}
 
