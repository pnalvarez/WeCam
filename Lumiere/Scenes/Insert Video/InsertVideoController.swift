//
//  InsertVideoController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 04/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit
import WCUIKit
import YoutubePlayer_in_WKWebView

protocol InsertVideoDisplayLogic: ViewInterface {
    func displayYoutubeVideo(_ viewModel: InsertVideo.Info.ViewModel.Video)
    func displayVideoError()
    func displayFinishedProjectDetails()
    func displayConfirmationAlert()
    func hidePlayer()
}

class InsertVideoController: BaseViewController {
    
    private lazy var inputTextField: WCInputTextField = {
        let view = WCInputTextField(frame: .zero)
        view.addTarget(self, action: #selector(didChangeInputTextField), for: .editingChanged)
        view.delegate = self
        return view
    }()
    
    private lazy var urlErrorView: WCEmptyListView = {
        let view = WCEmptyListView(frame: .zero, text: InsertVideo.Constants.Texts.urlNotFound)
        view.isHidden = true
        return view
    }()
    
    private lazy var playerView: WKYTPlayerView = {
        let view = WKYTPlayerView(frame: .zero)
        view.delegate = self
        return view
    }()
    
    private lazy var submitButton: WCPrimaryActionButton = {
        let view = WCPrimaryActionButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapSubmit), for: .touchUpInside)
        view.text = InsertVideo.Constants.Texts.submit
        return view
    }()
    
    private lazy var mainView: InsertVideoView = {
        let view = InsertVideoView(frame: .zero,
                                   inputTextField: inputTextField,
                                   urlErrorView: urlErrorView,
                                   playerView: playerView,
                                   submitButton: submitButton)
        return view
    }()
    
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
    
    private func showVideoError() {
        playerView.isHidden = true
        urlErrorView.isHidden = false
        submitButton.enableState = .disabled
    }
    
    @objc
    private func didChangeInputTextField() {
        submitButton.enableState = .disabled
        interactor?.fetchYoutubeVideoId(InsertVideo.Request.FetchVideo(url: inputTextField.text ?? .empty))
    }
    
    @objc
    private func didTapSubmit() {
        interactor?.fetchPublishVideo(InsertVideo.Request.Publish())
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if (isBackSpace == -92) && (textField.text?.count)! > 0 {
            if textField == inputTextField {
                textField.text!.removeAll()
                interactor?.fetchYoutubeVideoId(InsertVideo.Request.FetchVideo(url: textField.text ?? .empty))
                submitButton.enableState = .disabled
            } else {
                textField.text?.removeLast()
            }
        }
        return true
    }
}

extension InsertVideoController: WKYTPlayerViewDelegate {
    
    func playerView(_ playerView: WKYTPlayerView, receivedError error: WKYTPlayerError) {
        showVideoError()
    }
    
    func playerViewDidBecomeReady(_ playerView: WKYTPlayerView) {
        submitButton.enableState = .enabled
    }
    
    func playerView(_ playerView: WKYTPlayerView, didChangeTo state: WKYTPlayerState) {
        switch state {
        case .unknown:
            submitButton.enableState = .disabled
        default:
            submitButton.enableState = .enabled
        }
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
    
    func displayConfirmationAlert() {
        navigationController?.tabBarController?.tabBar.isHidden = true
        WCDialogView().show(dialogType: .interaction(confirmText: WCConstants.Strings.yesAnswer, cancelText: WCConstants.Strings.noAnswer), in: self, title: InsertVideo.Constants.Texts.submit, description: InsertVideo.Constants.Texts.confirmation, doneAction: {
            self.interactor?.fetchConfirmPublishing(InsertVideo.Request.Confirm())
        })
    }
    
    func hidePlayer() {
        playerView.stopVideo()
        playerView.delegate = nil
    }
}
