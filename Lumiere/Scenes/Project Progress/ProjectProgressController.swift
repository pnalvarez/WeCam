//
//  ProjectProgressController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 20/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

protocol ProjectProgressDisplayLogic: ViewInterface {
    func displayEditProjectDetails()
    func displayFinishConfirmationDialog()
}

class ProjectProgressController: BaseViewController {
    
    private lazy var advanceButton: WCPrimaryActionButton = {
        let view = WCPrimaryActionButton(frame: .zero)
        view.text = ProjectProgress.Constants.Texts.advanceButton
        view.addTarget(self, action: #selector(didTapAdvanceButton), for: .touchUpInside)
        return view
    }()
    
    private lazy var progressView: WCProgressView = {
        let view = WCProgressView(frame: .zero)
        return view
    }()
    
    private lazy var mainView: ProjectProgressView = {
        return ProjectProgressView(frame: .zero,
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
        WCDialogView().show(dialogType: .interaction(confirmText: WCConstants.Strings.yesAnswer, cancelText: WCConstants.Strings.noAnswer), in: self, title: ProjectProgress.Constants.Texts.finishConfirmationTitle, description: ProjectProgress.Constants.Texts.finishConfirmationMessage, doneAction: {
            self.interactor?.fetchConfirmFinished(ProjectProgress.Request.ConfirmFinishedStatus())
        }, cancelAction: {
            self.interactor?.fetchConfirmPercentage(ProjectProgress.Request.ConfirmPercentage())
        })
    }
}
