//
//  FilterCathegoriesController.swift
//  WeCam
//
//  Created by Pedro Alvarez on 18/04/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

protocol FilterCathegoriesDisplayLogic: ViewInterface {
    func displayAllCathegories(_ viewModel: FilterCathegories.Info.ViewModel.InterestCathegoryList)
    func displaySelectedCathegories(_ viewModel: FilterCathegories.Info.ViewModel.SelectedCathegoryList)
    func displayMainFeed()
    func displayLayoutFilterButton(_ enabled: Bool)
}

class FilterCathegoriesController: BaseViewController, HasNoTabBar {
    
    private lazy var cathegoryListView: WCCathegoryListView = {
        let view = WCCathegoryListView(frame: .zero)
        view.delegate = self
        return view
    }()
    
    private lazy var filterButton: WCPrimaryActionButton = {
        let view = WCPrimaryActionButton(frame: .zero)
        view.text = FilterCathegories.Constants.Texts.filterButton
        view.enableState = .disabled
        view.addTarget(self, action: #selector(didTapFilter), for: .touchUpInside)
        return view
    }()
    
    private lazy var mainView: FilterCathegoriesView = {
        let view = FilterCathegoriesView(frame: .zero,
                                         cathegoryListView: cathegoryListView,
                                         filterButton: filterButton)
        return view
    }()
    
    private var interactor: FilterCathegoriesBusinessLogic?
    var router: FilterCathegoriesRouterProtocol?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchInterestCathegories(FilterCathegories.Request.FetchInterestCathegories())
    }
    
    private func setup() {
        let viewController = self
        let presenter = FilterCathegoriesPresenter(viewController: viewController)
        let interactor = FilterCathegoriesInteractor(presenter: presenter)
        let router = FilterCathegoriesRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.dataStore = interactor
        router.viewController = viewController
    }
    
    @objc
    private func didTapFilter() {
        interactor?.filterCathegories(FilterCathegories.Request.Filter())
    }
}

extension FilterCathegoriesController: WCCathegoryListViewDelegate {
    
    func didSelectCathegory(atIndex index: Int) {
        interactor?.selectCathegory(FilterCathegories.Request.SelectCathegory(index: index))
    }
}

extension FilterCathegoriesController: FilterCathegoriesDisplayLogic {

    func displayAllCathegories(_ viewModel: FilterCathegories.Info.ViewModel.InterestCathegoryList) {
        cathegoryListView.setup(cathegories: viewModel.cathegories)
    }
    
    func displaySelectedCathegories(_ viewModel: FilterCathegories.Info.ViewModel.SelectedCathegoryList) {
        cathegoryListView.setSelectedCells(atPositions: viewModel.indexes)
    }
    
    func displayMainFeed() {
        router?.routeToMainFeed()
    }
    
    func displayLayoutFilterButton(_ enabled: Bool) {
        if enabled {
            filterButton.enableState = .enabled
        } else {
            filterButton.enableState = .disabled
        }
    }
}
