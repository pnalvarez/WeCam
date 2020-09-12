//
//  SelectProjectCathegoryController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol SelectProjectCathegoryDisplayLogic: class {
    func displayAllCathegories(_ viewModel: SelectProjectCathegory.Info.Model.InterestCathegories)
    func displayProjectProgress()
    func displayError(_ viewModel: SelectProjectCathegory.Info.Errors.SelectionError)
}

class SelectProjectCathegoryController: BaseViewController {
    
    private lazy var backButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        view.setImage(SelectProjectCathegory.Constants.Images.backButton, for: .normal)
        return view
    }()
    
    private lazy var advanceButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapAdvance), for: .touchUpInside)
        view.setTitle(SelectProjectCathegory.Constants.Texts.advanceButton, for: .normal)
        view.setTitleColor(SelectProjectCathegory.Constants.Colors.advanceButton, for: .normal)
        view.titleLabel?.font = SelectProjectCathegory.Constants.Fonts.advanceButton
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
                                              backButton: backButton,
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
        navigationController?.isNavigationBarHidden = true
        interactor?.fetchAllCathegories(SelectProjectCathegory.Request.AllCathegories())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.tabBarController?.tabBar.isHidden = true
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    private func setup() {
        let viewController = self
        let interactor = SelectProjectCathegoryInteractor(viewController: viewController)
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
        navigationController?.tabBarController?.tabBar.isHidden = false
        router?.routeBack()
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
        cell.setup(movieStyle: cathegory.cathegory)
        cell.state = cathegory.selected ? .enable : .disable
        return cell
    }
}

extension SelectProjectCathegoryController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.width / 4, height: view.frame.height * 0.13)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 26, bottom: 0, right: 26)
    }
}

extension SelectProjectCathegoryController: SelectProjectCathegoryDisplayLogic {
    
    func displayAllCathegories(_ viewModel: SelectProjectCathegory.Info.Model.InterestCathegories) {
        self.cathegories = viewModel
    }
    
    func displayProjectProgress() {
        router?.routeToProjectProgress()
    }
    
    func displayError(_ viewModel: SelectProjectCathegory.Info.Errors.SelectionError) {
        UIAlertController.displayAlert(in: self,
                                       title: viewModel.title,
                                       message: viewModel.message)
    }
}
