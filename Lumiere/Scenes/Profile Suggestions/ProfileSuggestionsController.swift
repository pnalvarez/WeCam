//
//  ProfileSuggestionsController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 10/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

protocol ProfileSuggestionsDisplayLogic: ViewInterface {
    func displayProfileSuggestions(_ viewModel: ProfileSuggestions.Info.ViewModel.UpcomingSuggestions)
    func fadeProfileItem(_ viewModel: ProfileSuggestions.Info.ViewModel.ProfileItemToFade)
    func displayProfileDetails()
    func displayError(_ viewModel: ProfileSuggestions.Info.ViewModel.ProfileSuggestionsError)
    func displayCriterias(_ viewModel: ProfileSuggestions.Info.ViewModel.UpcomingCriteria)
}

class ProfileSuggestionsController: BaseViewController {
    
    private lazy var optionsToolbar: WCOptionsToolbar = {
        let view = WCOptionsToolbar(frame: .zero)
        view.delegate = self
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.assignProtocols(to: self)
        view.alwaysBounceVertical = false
        view.bounces = false
        view.registerCell(cellType: ProfileSuggestionsTableViewCell.self)
        view.separatorStyle = .none 
        view.backgroundColor = .white
        view.accessibilityLabel = ProfileSuggestions.Constants.Texts.suggestionsTableViewId
        return view
    }()
    
    private lazy var mainView: ProfileSuggestionsView = {
        let view = ProfileSuggestionsView(frame: .zero,
                                          optionsToolbar: optionsToolbar,
                                          tableView: tableView)
        return view
    }()
    
    private var criteriaViewModel: ProfileSuggestions.Info.ViewModel.UpcomingCriteria? {
        didSet {
            optionsToolbar.setupToolbarLayout(optionNames: criteriaViewModel?.criterias ?? .empty, fixedWidth: true)
        }
    }
    
    private var suggestionsViewModel: ProfileSuggestions.Info.ViewModel.UpcomingSuggestions? {
        didSet {
            refreshList()
        }
    }
    
    private var interactor: ProfileSuggestionsInteractor?
    var router: ProfileSuggestionsRouter?

    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchCriterias(ProfileSuggestions.Request.FetchCriteria())
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.fetchProfileSuggestions(ProfileSuggestions.Request.FetchProfileSuggestions())
    }
    
    private func setup() {
        let viewController = self
        let presenter = ProfileSuggestionsPresenter(viewController: viewController)
        let interactor = ProfileSuggestionsInteractor(presenter: presenter)
        let router = ProfileSuggestionsRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.dataStore = interactor
        router.viewController = viewController
    }
    
    private func refreshList() {
        DispatchQueue.main.async {
            self.tableView.checkEmptyState(text: ProfileSuggestions.Constants.Texts.emptySuggestions,
                                           layout: .large)
            self.tableView.reloadData()
        }
    }
}

extension ProfileSuggestionsController: WCOptionsToolbarDelegate {
    
    func optionsToolbar(selectedButton index: Int, optionsToolbar: WCOptionsToolbar) {
        interactor?.didChangeCriteria(ProfileSuggestions.Request.ChangeCriteria(index: index))
    }
}

extension ProfileSuggestionsController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestionsViewModel?.profiles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath, type: ProfileSuggestionsTableViewCell.self)
        guard let profile = suggestionsViewModel?.profiles[indexPath.row] else { return UITableViewCell() }
        cell.setup(index: indexPath.row,
                   delegate: self,
                   viewModel: profile)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ProfileSuggestions.Constants.Dimensions.Heights.defaultCellHeight
    }
}

extension ProfileSuggestionsController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.didSelectProfile(ProfileSuggestions.Request.SelectProfile(index: indexPath.row))
    }
}

extension ProfileSuggestionsController: ProfileSuggestionsTableViewCellDelegate {
    
    func didTapAdd(index: Int) {
        interactor?.fetchAddUser(ProfileSuggestions.Request.AddUser(index: index))
    }
    
    func didTapRemove(index: Int) {
        interactor?.fetchRemoveUser(ProfileSuggestions.Request.RemoveUser(index: index))
    }
    
    func didEndFading(index: Int) {
        suggestionsViewModel?.profiles.remove(at: index)
        tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        refreshList()
    }
}

extension ProfileSuggestionsController: ProfileSuggestionsDisplayLogic {
    
    func displayProfileSuggestions(_ viewModel: ProfileSuggestions.Info.ViewModel.UpcomingSuggestions) {
        self.suggestionsViewModel = viewModel
    }
    
    func fadeProfileItem(_ viewModel: ProfileSuggestions.Info.ViewModel.ProfileItemToFade) {
        let cell = tableView.cellForRow(at: IndexPath(row: viewModel.index, section: 0), type: ProfileSuggestionsTableViewCell.self)
        cell.fade()
    }
    
    func displayProfileDetails() {
        router?.routeToProfileDetails()
    }
    
    func displayError(_ viewModel: ProfileSuggestions.Info.ViewModel.ProfileSuggestionsError) {
        UIAlertController.displayAlert(in: self, title: "Erro", message: viewModel.error)
    }
    
    func displayCriterias(_ viewModel: ProfileSuggestions.Info.ViewModel.UpcomingCriteria) {
        self.criteriaViewModel = viewModel
    }
}
