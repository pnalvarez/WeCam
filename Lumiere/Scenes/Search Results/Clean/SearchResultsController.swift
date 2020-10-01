//
//  SearchResultsController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 29/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol SearchResultsDisplayLogic: class {
    
}

class SearchResultsController: BaseViewController {
    
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
    }
    
    override func loadView() {
        super.loadView()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension SearchResultsController: UITableViewDelegate {
    
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
                                    .Search(preffix: searchTextField.text ?? .empty))
    }
}

extension SearchResultsController: SearchResultsDisplayLogic {
    
}
