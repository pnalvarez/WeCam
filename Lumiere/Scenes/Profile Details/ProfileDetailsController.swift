//
//  ProfileDetailsController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol ProfileDetailsDisplayLogic: class {
    func displayUserInfo(_ viewModel: ProfileDetails.Info.ViewModel.User)
    func displayAddedConnection()
    func displayError(_ viewModel: String)
}

class ProfileDetailsController: BaseViewController {
    
    private lazy var backButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.setImage(ProfileDetails.Constants.Images.backButton, for: .normal)
        return view
    }()
    
    private lazy var addConnectionButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapAddConnectionButton), for: .touchUpInside)
        return view
    }()
    
    private lazy var allConnectionsButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapAllConnectionsButton), for: .touchUpInside)
        view.layer.cornerRadius = 4
        view.backgroundColor = ProfileDetails.Constants.Colors.allConnectionsButton
        return view
    }()
    
    private lazy var mainView: ProfileDetailsView = {
        let view = ProfileDetailsView(frame: .zero,
                                  backButton: backButton,
                                  addConnectionButton: addConnectionButton,
                                  allConnectionsButton: allConnectionsButton)
        return view
    }()
    
    private var interactor: ProfileDetailsBusinessLogic?
    var router: ProfileDetailsRouterProtocol?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        interactor?.fetchUserData(ProfileDetails.Request.UserData())
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    private func setup() {
        let viewController = self
        let interactor = ProfileDetailsInteractor(viewController: viewController)
        let router = ProfileDetailsRouter()
        viewController.router = router
        router.dataStore = interactor
        router.viewController = viewController
        viewController.interactor = interactor
    }
}

extension ProfileDetailsController {
    
    @objc
    private func didTapBackButton() {
        router?.routeBack()
    }
    
    @objc
    private func didTapAddConnectionButton() {
        interactor?.fetchAddConnection(ProfileDetails.Request.AddConnection())
    }
    
    @objc
    private func didTapAllConnectionsButton() {
        interactor?.fetchAllConnections(ProfileDetails.Request.AllConnections())
    }
}

extension ProfileDetailsController: ProfileDetailsDisplayLogic {
    
    func displayUserInfo(_ viewModel: ProfileDetails.Info.ViewModel.User) {
        mainView.setup(viewModel: viewModel)
    }
    
    func displayAddedConnection() {
        //TO DO
    }
    
    func displayError(_ viewModel: String) {
        let alertController = UIAlertController(title: ProfileDetails
            .Constants
            .Texts
            .addConnectionError,
                                                message: viewModel,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
