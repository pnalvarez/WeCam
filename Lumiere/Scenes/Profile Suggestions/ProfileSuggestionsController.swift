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
}

class ProfileSuggestionsController: BaseViewController {
    
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
    
    private var viewModel: ProfileSuggestions.Info.ViewModel.UpcomingSuggestions? {
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
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
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
}

extension ProfileSuggestionsController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.profiles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath, type: ProfileSuggestionsTableViewCell.self)
        guard let profile = viewModel?.profiles[indexPath.row] else { return UITableViewCell() }
        cell.setup(index: indexPath.row,
                   delegate: self,
                   viewModel: profile)
        return cell
    }
}

extension ProfileSuggestionsController: UITableViewDelegate { }

extension ProfileSuggestionsController: ProfileSuggestionsTableViewCellDelegate {
    
    func didTapAdd(index: Int) {
        
    }
    
    func didTapRemove(index: Int) {
        
    }
}

extension ProfileSuggestionsController: ProfileSuggestionsDisplayLogic {
    
    func displayProfileSuggestions(_ viewModel: ProfileSuggestions.Info.ViewModel.UpcomingSuggestions) {
        self.viewModel = viewModel
    }
    
    func fadeProfileItem(_ viewModel: ProfileSuggestions.Info.ViewModel.ProfileItemToFade) {
        //TO DO
    }
}
