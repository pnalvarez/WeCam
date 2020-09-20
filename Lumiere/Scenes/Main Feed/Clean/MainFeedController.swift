//
//  MainFeedController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol MainFeedDisplayLogic: class {
    
}

class MainFeedController: BaseViewController {
    
    private lazy var tableView: MainFeedTableView = {
        let view = MainFeedTableView(frame: .zero)
        view.assignProtocols(to: self)
        return view
    }()
    
    private var sections: [TableViewSectionProtocol]?
    
    private var factory: TableViewFactory?
    private var interactor: MainFeedBusinessLogic?
    var router: MainFeedRouterProtocol?
    
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
        refreshTableView()
    }
    
    private func setup() {
        let viewController = self
        let presenter = MainFeedPresenter(viewController: viewController)
        let interactor = MainFeedInteractor(presenter: presenter)
        let router = MainFeedRouter()
        let factory = MainFeedTableViewFactory(tableView: tableView)
        viewController.interactor = interactor
        viewController.router = router
        viewController.factory = factory
        router.dataStore = interactor
        router.viewController = viewController
        sections = factory.buildSections()
    }
}

extension MainFeedController {
    
    private func refreshTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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

extension MainFeedController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension MainFeedController: MainFeedDisplayLogic {
    
}
