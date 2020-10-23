//
//  ProfileSuggestionsController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 10/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol ProfileSuggestionsDisplayLogic: class {
    func displayProfileSuggestions(_ viewModel: ProfileSuggestions.Info.ViewModel.UpcomingSuggestions)
    func fadeProfileItem(_ viewModel: ProfileSuggestions.Info.ViewModel.ProfileItemToFade)
    func displayProfileDetails()
    func displayError(_ viewModel: ProfileSuggestions.Info.ViewModel.ProfileSuggestionsError)
    func displayLoading(_ loading: Bool)
    func displayCriterias(_ viewModel: ProfileSuggestions.Info.ViewModel.UpcomingCriteria)
}

class ProfileSuggestionsController: BaseViewController {
    
    private lazy var activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.backgroundColor = ThemeColors.whiteThemeColor.rawValue
        view.color = ThemeColors.mainRedColor.rawValue
        view.startAnimating()
        return view
    }()
    
    private lazy var backButton: DefaultBackButton = {
        let view = DefaultBackButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        return view
    }()
    
    private lazy var filterButton: SelectionFilterView = {
        let view = SelectionFilterView(frame: .zero,
                                       selectedItem: criteriaViewModel?.selectedCriteria ?? .empty,
                                       delegate: self)
        return view
    }()
    
    private lazy var optionsStackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.distribution = .fillEqually
        view.spacing = 0
        view.alignment = .center
        view.axis = .vertical
        view.isHidden = true
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
        return view
    }()
    
    private lazy var mainView: ProfileSuggestionsView = {
        let view = ProfileSuggestionsView(frame: .zero,
                                          activityView: activityView,
                                          backButton: backButton,
                                          filterButton: filterButton,
                                          optionsStackView: optionsStackView,
                                          tableView: tableView)
        return view
    }()
    
    private var criteriaViewModel: ProfileSuggestions.Info.ViewModel.UpcomingCriteria? {
        didSet {
            buildOptionFilters()
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
}

extension ProfileSuggestionsController {
    
    private func refreshList() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func buildOptionFilters() {
        guard let criterias = criteriaViewModel?.criterias else { return }
        let selectedIndex = criteriaViewModel?.criterias.firstIndex(where: { criteriaViewModel?.selectedCriteria == $0 })
        filterButton.selectedItem = criteriaViewModel?.selectedCriteria.description ?? .empty
        for index in 0..<criterias.count {
            let button = OptionFilterButton(frame: .zero, option: criterias[index])
            button.addTarget(self, action: #selector(didSelectOption(_:)), for: .touchUpInside)
            button.tag = index
            if selectedIndex == index {
                button.backgroundColor = ProfileSuggestions.Constants.Colors.optionButtonSelected
            }
            optionsStackView.addArrangedSubview(button)
            button.snp.makeConstraints { make in
                make.width.equalTo(filterButton)
                make.height.equalTo(20)
            }
        }
    }
}

extension ProfileSuggestionsController {
    
    @objc
    private func didTapBack() {
        router?.routeBack()
    }
    
    @objc
    private func didSelectOption(_ sender: UIButton) {
        guard let text = criteriaViewModel?.criterias[sender.tag] else { return }
        filterButton.selectedItem = text
        optionsStackView.isHidden = true
        optionsStackView.arrangedSubviews.forEach({
            if $0 == sender {
                $0.backgroundColor = ProfileSuggestions.Constants.Colors.optionButtonSelected
            } else {
                $0.backgroundColor = ProfileSuggestions.Constants.Colors.optionButtonUnselected
            }
        })
        interactor?.didChangeCriteria(ProfileSuggestions.Request.ChangeCriteria(criteria: text))
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

extension ProfileSuggestionsController: SelectionFilterViewDelegate {
    
    func didTapBottomSheetButton() {
        optionsStackView.isHidden = !optionsStackView.isHidden
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
    
    func displayLoading(_ loading: Bool) {
        activityView.isHidden = !loading
    }
    
    func displayCriterias(_ viewModel: ProfileSuggestions.Info.ViewModel.UpcomingCriteria) {
        self.criteriaViewModel = viewModel
        filterButton.selectedItem = viewModel.selectedCriteria
    }
}
