//
//  ProjectStepsController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 14/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

protocol ProjectStepsDisplayLogic: class {
    func displayRotateSliderThumbImage()
    func displayAdvance()
}

class ProjectStepsController: BaseViewController {
    
    private lazy var stepSlider: ProjectSlider = {
        let view = ProjectSlider(frame: .zero)
        view.addTarget(self, action: #selector(didStepSliderChanged), for: .valueChanged)
        view.setValue(0.0, animated: true)
        return view
    }()
    
    private lazy var advanceButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapAdvanceButton), for: .touchUpInside)
        return view
    }()
    
    private lazy var mainView: ProjectStepsView = {
        return ProjectStepsView(frame: .zero,
                                stepSlider: stepSlider,
                                advanceButton: advanceButton)
    }()
    
    private var interactor: ProjectStepBusinessLogic?
    var router: ProjectStepRouterProtocol?
    
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
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    private func setup() {
        let viewController = self
        let interactor = ProjectStepInteractor(viewController: viewController)
        let router = ProjectStepRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.dataStore = interactor
        router.viewController = viewController
    }
}

extension ProjectStepsController {
    
    @objc
    private func didTapAdvanceButton() {
        interactor?.fetchAvance()
    }
    
    @objc
    private func didStepSliderChanged() {
        interactor?.fetchSliderChanged()
    }
}

extension ProjectStepsController: ProjectStepsDisplayLogic {
    
    func displayRotateSliderThumbImage() {
        stepSlider.currentThumbImage?.rotate(radians: .pi / 10)
    }
    
    func displayAdvance() {

    }
}
