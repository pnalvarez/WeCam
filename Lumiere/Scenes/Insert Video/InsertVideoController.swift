//
//  InsertVideoController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 04/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit
import YoutubePlayer_in_WKWebView

protocol InsertVideoDisplayLogic: class {
    func displayYoutubeVideo(_ viewModel: InsertVideo.Info.ViewModel.Video)
    func displayVideoError()
    func displayFinishedProjectDetails()
    func displayLoading(_ loading: Bool)
    func displayConfirmationAlert()
    func displayLongLoading(_ loading: Bool)
}

class InsertVideoController: BaseViewController {
    
    private lazy var loadingView: LoadingView = {
        let view = LoadingView(frame: .zero)
        view.isHidden = true
        return view
    }()
    
    private lazy var confirmationAlertView: ConfirmationAlertView = {
        let view = ConfirmationAlertView(frame: .zero,
                                         delegate: self,
                                         text: InsertVideo.Constants.Texts.confirmation)
        return view
    }()
    
    private lazy var translucentView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(rgb: 0xededed).withAlphaComponent(0.5)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                         action: #selector(hideConfirmationAlert)))
        view.isHidden = true
        return view
    }()
    
    private lazy var activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.startAnimating()
        view.color = ThemeColors.mainRedColor.rawValue
        view.backgroundColor = .white
        view.isHidden = true
        return view
    }()
    
    private lazy var backButton: DefaultBackButton = {
        let view = DefaultBackButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        return view
    }()
    
    private lazy var inputTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.addTarget(self, action: #selector(didChangeInputTextField), for: .editingChanged)
        view.layer.borderWidth = 1
        view.layer.borderColor = InsertVideo.Constants.Colors.inputTextFieldLayer
        view.layer.cornerRadius = 4
        view.backgroundColor = InsertVideo.Constants.Colors.inputTextFieldBackground
        view.textColor = InsertVideo.Constants.Colors.inputTextFieldText
        view.font = InsertVideo.Constants.Fonts.inputTextField
        view.delegate = self
        return view
    }()
    
    private lazy var urlErrorView: EmptyListView = {
        let view = EmptyListView(frame: .zero, text: InsertVideo.Constants.Texts.urlNotFound)
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
        view.backgroundColor = InsertVideo.Constants.Colors.submitButtonBackgroundDisabled
        view.layer.cornerRadius = 4
        view.setTitle(InsertVideo.Constants.Texts.submitButton, for: .normal)
        view.setTitleColor(InsertVideo.Constants.Colors.submitButtonText, for: .normal)
        view.titleLabel?.font = InsertVideo.Constants.Fonts.submitButton
        return view
    }()
    
    private lazy var mainView: InsertVideoView = {
        let view = InsertVideoView(frame: .zero,
                                   loadingView: loadingView,
                                   confirmationAlertView: confirmationAlertView,
                                   translucentView: translucentView,
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
            submitButton.backgroundColor = submitEnabled ? InsertVideo.Constants.Colors.submitButtonBackgroundEnabled : InsertVideo.Constants.Colors.submitButtonBackgroundDisabled
            submitButton.isEnabled = submitEnabled
        }
    }
    
    private var interactor: InsertVideoBusinessLogic?
    var router: InsertVideoRouterProtocol?
    
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        playerView.stopVideo()
    }
    
    private func setup() {
        let viewController = self
        let presenter = InsertVideoPresenter(viewController: viewController)
        let interactor = InsertVideoInteractor(presenter: presenter)
        let router = InsertVideoRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension InsertVideoController {

    private func showVideoError() {
        playerView.isHidden = true
        urlErrorView.isHidden = false
        submitEnabled = false
    }
}

extension InsertVideoController {
    
    @objc
    private func didTapBack() {
        router?.routeBack()
    }
    
    @objc
    private func didChangeInputTextField() {
        submitEnabled = false
        interactor?.fetchYoutubeVideoId(InsertVideo.Request.FetchVideo(url: inputTextField.text ?? .empty))
    }
    
    @objc
    private func didTapSubmit() {
        interactor?.fetchPublishVideo(InsertVideo.Request.Publish())
    }
    
    @objc
    private func hideConfirmationAlert() {
        navigationController?.tabBarController?.tabBar.isHidden = false
        mainView.hideConfirmationModal()
    }
}

extension InsertVideoController: WKYTPlayerViewDelegate {
    
    func playerView(_ playerView: WKYTPlayerView, receivedError error: WKYTPlayerError) {
        showVideoError()
    }
    
    func playerViewDidBecomeReady(_ playerView: WKYTPlayerView) {
        submitEnabled = true
    }
    
    func playerView(_ playerView: WKYTPlayerView, didChangeTo state: WKYTPlayerState) {
        switch state {
        case .unknown:
            submitEnabled = false
        default:
            submitEnabled = true
        }
    }
}

extension InsertVideoController: ConfirmationAlertViewDelegate {
    
    func didTapAccept() {
        navigationController?.tabBarController?.tabBar.isHidden = false
        mainView.hideConfirmationModal()
        interactor?.fetchConfirmPublishing(InsertVideo.Request.Confirm())
    }
    
    func didTapRefuse() {
        navigationController?.tabBarController?.tabBar.isHidden = false
        mainView.hideConfirmationModal()
    }
}

extension InsertVideoController {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if (isBackSpace == -92) && (textField.text?.count)! > 0 {
            if textField == inputTextField {
                textField.text!.removeAll()
                interactor?.fetchYoutubeVideoId(InsertVideo.Request.FetchVideo(url: textField.text ?? .empty))
                submitEnabled = false
            } else {
                textField.text?.removeLast()
            }
        }
        return true
    }
}

extension InsertVideoController: InsertVideoDisplayLogic {
    
    func displayYoutubeVideo(_ viewModel: InsertVideo.Info.ViewModel.Video) {
        urlErrorView.isHidden = true
        playerView.isHidden = false
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
    
    func displayConfirmationAlert() {
        navigationController?.tabBarController?.tabBar.isHidden = true
        mainView.displayConfirmationModal()
    }
    
    func displayLongLoading(_ loading: Bool) {
        navigationController?.tabBarController?.tabBar.isHidden = loading
        playerView.stopVideo()
        playerView.delegate = nil
        loadingView.isHidden = !loading
        loadingView.animateRotate()
    }
}
