//
//  ProjectProgressController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 20/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

protocol ProjectProgressDisplayLogic: class {
    func displayEditProjectDetails()
    func displayFinishConfirmationDialog()
}

class ProjectProgressController: BaseViewController {
    
    private lazy var advanceButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle(ProjectProgress.Constants.Texts.advanceButton, for: .normal)
        view.setTitleColor(ProjectProgress.Constants.Colors.advanceButton, for: .normal)
        view.addTarget(self, action: #selector(didTapAdvanceButton), for: .touchUpInside)
        view.titleLabel?.font = ProjectProgress.Constants.Fonts.advanceButton
        return view
    }()
    
    private lazy var progressView: WCProgressView = {
        let view = WCProgressView(frame: .zero)
        return view
    }()
    
    private lazy var mainView: ProjectProgressView = {
        return ProjectProgressView(frame: .zero,
                                   backButton: backButton,
                                   advanceButton: advanceButton,
                                   progressView: progressView)
    }()
    
    private var interactor: ProjectProgressBusinessLogic?
    var router: ProjectProgressRouterProtocol?
    
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
        self.view = mainView
    }
    
    private func setup() {
        let viewController = self
        let presenter = ProjectProgressPresenter(viewController: viewController)
        let interactor = ProjectProgressInteractor(presenter: presenter)
        let router = ProjectProgressRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.dataStore = interactor
        router.viewController = viewController
    }
    
    @objc
    private func didTapAdvanceButton() {
        interactor?.fetchAdvance(ProjectProgress.Request.Advance(percentage: progressView.percentage))
    }
}

extension ProjectProgressController: ProjectProgressDisplayLogic {
    
    func displayEditProjectDetails() {
        router?.routeToEditProjectDetails()
    }
    
    func displayFinishConfirmationDialog() {
        UIAlertController.displayConfirmationDialog(in: self,title: ProjectProgress.Constants.Texts.finishConfirmationTitle, message: ProjectProgress.Constants.Texts.finishConfirmationMessage, confirmationCallback: { self.interactor?.fetchConfirmFinished(ProjectProgress.Request.ConfirmFinishedStatus())}, refuseCallback: { self.interactor?.fetchConfirmPercentage(ProjectProgress.Request.ConfirmPercentage()) }, animated: true)
    }
}
