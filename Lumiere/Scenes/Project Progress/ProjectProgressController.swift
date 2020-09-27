//
//  ProjectProgressController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 20/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol ProjectProgressDisplayLogic: class {
    func displayEditProjectDetails()
}

class ProjectProgressController: BaseViewController {
    
    private lazy var backButton: DefaultBackButton = {
        let view = DefaultBackButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        return view
    }()
    
    private lazy var advanceButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle(ProjectProgress.Constants.Texts.advanceButton, for: .normal)
        view.setTitleColor(ProjectProgress.Constants.Colors.advanceButton, for: .normal)
        view.addTarget(self, action: #selector(didTapAdvanceButton), for: .touchUpInside)
        view.titleLabel?.font = ProjectProgress.Constants.Fonts.advanceButton
        return view
    }()
    
    private lazy var progressSlider: UISlider = {
        let view = UISlider(frame: .zero)
        view.setThumbImage(ProjectProgress.Constants.Images.logo?.alpha(0.4), for: .normal)
        view.setThumbImage(ProjectProgress.Constants.Images.logo, for: .highlighted)
        view.backgroundColor = ProjectProgress.Constants.Colors.progressSliderBackground
        view.tintColor = ProjectProgress.Constants.Colors.progressSliderBackground
        view.addTarget(self, action: #selector(didChangeSliderValue), for: .valueChanged)
        return view
    }()
    
    private lazy var mainView: ProjectProgressView = {
        return ProjectProgressView(frame: .zero,
                                   backButton: backButton,
                                   advanceButton: advanceButton,
                                   progressSlider: progressSlider)
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
}

extension ProjectProgressController {
    
    @objc
    private func didTapBackButton() {
        router?.routeBack()
    }
    
    @objc
    private func didTapAdvanceButton() {
        let percentage = progressSlider.value / progressSlider.maximumValue
        interactor?.fetchAdvance(ProjectProgress.Request.Advance(percentage: percentage))
    }
    
    @objc
    private func didChangeSliderValue() {
        var newImage = progressSlider.currentThumbImage?.rotate(radians: progressSlider.value * 2 * Float.pi / progressSlider.maximumValue)
        let percentage = progressSlider.value / progressSlider.maximumValue
        if percentage >= 0.8 {
            newImage = newImage?.alpha(1.0)
        } else if percentage >= 0.6 {
            newImage = newImage?.alpha(0.8)
        } else if percentage >= 0.4 {
            newImage = newImage?.alpha(0.6)
        } else {
            newImage = newImage?.alpha(0.4)
        }
        progressSlider.setThumbImage(newImage, for: .normal)
    }
}

extension ProjectProgressController: ProjectProgressDisplayLogic {
    
    func displayEditProjectDetails() {
        router?.routeToEditProjectDetails()
    }
}
