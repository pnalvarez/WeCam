//
//  EditProjectDetailsController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 21/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol EditProjectDetailsDisplayLogic: class {
    
}

class EditProjectDetailsController: BaseViewController {
    
    private lazy var backButton: DefaultBackButton = {
        let view = DefaultBackButton(frame: .zero)
        return view
    }()

    private lazy var teamValueLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.backgroundColor = EditProjectDetails.Constants.Colors.teamValueLblBackground
        view.textColor = EditProjectDetails.Constants.Colors.teamValueLblFieldText
        view.layer.borderWidth = 1
        view.layer.borderColor = EditProjectDetails.Constants.Colors.teamValueLblFieldLayer
        view.layer.cornerRadius = 4
        view.text = EditProjectDetails.Constants.Texts.teamValueLblEmpty
        return view
    }()
    
    private lazy var publishButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapPublish), for: .touchUpInside)
        view.setTitle(EditProjectDetails.Constants.Texts.publishButton, for: .normal)
        view.setTitleColor(EditProjectDetails.Constants.Colors.publishButtonText, for: .normal)
        view.backgroundColor = EditProjectDetails.Constants.Colors.publishButtonBackground
        view.titleLabel?.font = EditProjectDetails.Constants.Fonts.publishButton
        view.layer.cornerRadius = 4
        return view
    }()
    
    private lazy var mainView: EditProjectDetailsView = {
        let view = EditProjectDetailsView(frame: .zero,
                                          backButton: backButton,
                                          teamValueLbl: teamValueLbl,
                                          publishButton: publishButton)
        return view
    }()
    
    private var interactor: EditProjectDetailsBusinessLogic?
    var router: EditProjectDetailsRouterProtocol?
    
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
        let interactor = EditProjectDetailsInteractor(viewController: viewController)
        let router = EditProjectDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.dataStore = interactor
        router.viewController = viewController
    }
}

extension EditProjectDetailsController {
    
    @objc
    private func didTapPublish() {
        
    }
}

extension EditProjectDetailsController: EditProjectDetailsDisplayLogic {
    
}
