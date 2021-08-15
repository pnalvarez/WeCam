//
//  SelectProjectCathegoryController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

protocol SelectProjectCathegoryDisplayLogic: ViewInterface {
    func displayAllCathegories(_ viewModel: SelectProjectCathegory.Info.Model.InterestCathegories)
    func displayProjectProgress()
}

class SelectProjectCathegoryController: BaseViewController, HasNoTabBar {
    
    private lazy var advanceButton: WCPrimaryActionButton = {
        let view = WCPrimaryActionButton(frame: .zero)
        view.text = SelectProjectCathegory.Constants.Texts.advanceButton
        view.addTarget(self, action: #selector(didTapAdvance), for: .touchUpInside)
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.assignProtocols(to: self)
        view.registerCell(cellType: CathegoryCollectionViewCell.self)
        view.backgroundColor = .white
        view.bounces = false
        view.alwaysBounceVertical = false
        view.alwaysBounceHorizontal = false
        view.isScrollEnabled = false
        return view
    }()
    
    private lazy var mainView: SelectProjectCathegoryView = {
        let view = SelectProjectCathegoryView(frame: .zero,
                                              advanceButton: advanceButton,
                                              collectionView: collectionView)
        return view
    }()
    
    private var cathegories: SelectProjectCathegory.Info.Model.InterestCathegories? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private var interactor: SelectProjectCathegoryBusinessLogic?
    var router: SelectProjectCathegoryRouterProtocol?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchAllCathegories(SelectProjectCathegory.Request.AllCathegories())
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    private func setup() {
        let viewController = self
        let presenter = SelectProjectCathegoryPresenter(viewController: viewController)
        let interactor = SelectProjectCathegoryInteractor(presenter: presenter)
        let router = SelectProjectCathegoryRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension SelectProjectCathegoryController {
    
    @objc
    private func didTapBackButton() {
        router?.dismissFlow()
    }
    
    @objc
    private func didTapAdvance() {
        interactor?.fetchAdvance(SelectProjectCathegory.Request.Advance())
    }
}

extension SelectProjectCathegoryController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        guard let cathegory = cathegories?.cathegories[index] else { return }
        interactor?.fetchSelectCathegory(SelectProjectCathegory.Request.SelectCathegory(cathegory: cathegory.cathegory))
    }
}

extension SelectProjectCathegoryController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cathegories?.cathegories.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(indexPath: indexPath, type: CathegoryCollectionViewCell.self)
        guard let cathegory = cathegories?.cathegories[indexPath.row] else { return UICollectionViewCell() }
        cell.setup(movieStyle: cathegory.cathegory.rawValue)
        cell.state = cathegory.selected ? .enable : .disable
        return cell
    }
}

extension SelectProjectCathegoryController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.width / 3.7, height: 87)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 20)
    }
}

extension SelectProjectCathegoryController: SelectProjectCathegoryDisplayLogic {
    
    func displayAllCathegories(_ viewModel: SelectProjectCathegory.Info.Model.InterestCathegories) {
        self.cathegories = viewModel
    }
    
    func displayProjectProgress() {
        router?.routeToProjectProgress()
    }
}
