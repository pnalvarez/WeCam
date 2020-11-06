//
//  InsertMediaController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 04/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView

protocol InsertMediaDisplayLogic: class {
    func displayYoutubeVideo(_ viewModel: InsertMedia.Info.ViewModel.Media)
    func displayVideoError()
    func displayFinishedProjectDetails()
    func displayLoading(_ loading: Bool)
}

class InsertMediaController: BaseViewController {
    
    private lazy var activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.startAnimating()
        view.color = ThemeColors.mainRedColor.rawValue
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var backButton: DefaultBackButton = {
        let view = DefaultBackButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        return view
    }()
    
    private lazy var inputTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.addTarget(self, action: #selector(didChangeInputTextField), for: .valueChanged)
        view.layer.borderWidth = 1
        view.layer.borderColor = InsertMedia.Constants.Colors.inputTextFieldLayer
        view.layer.cornerRadius = 4
        view.backgroundColor = InsertMedia.Constants.Colors.inputTextFieldBackground
        view.textColor = InsertMedia.Constants.Colors.inputTextFieldText
        view.font = InsertMedia.Constants.Fonts.inputTextField
        return view
    }()
    
    private lazy var urlErrorView: EmptyListView = {
        let view = EmptyListView(frame: .zero, text: InsertMedia.Constants.Texts.urlNotFound)
        view.isHidden = true
        return view
    }()
    
    private lazy var playerView: WKYTPlayerView = {
        let view = WKYTPlayerView(frame: .zero)
        view.delegate = self
        return view
    }()
    
    private lazy var submitButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapSubmit), for: .touchUpInside)
        view.backgroundColor = InsertMedia.Constants.Colors.submitButtonBackgroundDisabled
        view.layer.cornerRadius = 4
        view.setTitle(InsertMedia.Constants.Texts.submitButton, for: .normal)
        view.setTitleColor(InsertMedia.Constants.Colors.submitButtonText, for: .normal)
        view.titleLabel?.font = InsertMedia.Constants.Fonts.submitButton
        return view
    }()
    
    private lazy var mainView: InsertMediaView = {
        let view = InsertMediaView(frame: .zero,
                                   activityView: activityView,
                                   backButton: backButton,
                                   inputTextField: inputTextField,
                                   urlErrorView: urlErrorView,
                                   playerView: playerView,
                                   submitButton: submitButton)
        view.backgroundColor = .white
        return view
    }()
    
    var submitEnabled: Bool = false {
        didSet {
            submitButton.backgroundColor = submitEnabled ? InsertMedia.Constants.Colors.submitButtonBackgroundEnabled : InsertMedia.Constants.Colors.submitButtonBackgroundDisabled
            submitButton.isEnabled = submitEnabled
        }
    }
    
    private var interactor: InsertMediaBusinessLogic?
    var router: InsertMediaRouterProtocol?
    
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        playerView.stopVideo()
    }
    
    private func setup() {
        let viewController = self
        let presenter = InsertMediaPresenter(viewController: viewController)
        let interactor = InsertMediaInteractor(presenter: presenter)
        let router = InsertMediaRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension InsertMediaController {

    private func showVideoError() {
        playerView.isHidden = true
        urlErrorView.isHidden = false
        submitEnabled = false
    }
}

extension InsertMediaController {
    
    @objc
    private func didTapBack() {
        router?.routeBack()
    }
    
    @objc
    private func didChangeInputTextField() {
        interactor?.fetchYoutubeVideoId(InsertMedia.Request.FetchVideo(url: inputTextField.text ?? .empty))
    }
    
    @objc
    private func didTapSubmit() {
        interactor?.fetchPublishVideo(InsertMedia.Request.Publish())
    }
}

extension InsertMediaController: WKYTPlayerViewDelegate {
    
    func playerView(_ playerView: WKYTPlayerView, receivedError error: WKYTPlayerError) {
        showVideoError()
    }
}

extension InsertMediaController: InsertMediaDisplayLogic {
    
    func displayYoutubeVideo(_ viewModel: InsertMedia.Info.ViewModel.Media) {
        playerView.load(withVideoId: viewModel.videoId)
    }
    
    func displayVideoError() {
        showVideoError()
    }
    
    func displayFinishedProjectDetails() {
        router?.routeToFinishedProjectDetails()
    }
    
    func displayLoading(_ loading: Bool) {
        activityView.isHidden = !loading
    }
}
