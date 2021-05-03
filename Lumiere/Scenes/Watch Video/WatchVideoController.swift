//
//  WatchVideoController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 09/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit
import YoutubePlayer_in_WKWebView

protocol WatchVideoDisplayLogic: ViewInterface {
    func displayYoutubeVideo(_ viewModel: WatchVideo.Info.ViewModel.Video)
}

class WatchVideoController: BaseViewController {
    
    private lazy var playerView: WKYTPlayerView = {
        let view = WKYTPlayerView(frame: .zero)
        view.delegate = self
        return view
    }()
    
    private lazy var mainView: WatchVideoView = {
        let view = WatchVideoView(frame: .zero,
                                  playerView: playerView)
        view.backgroundColor = .white
        return view
    }()
    
    private var interactor: WatchVideoBusinessLogic?
    var router: WatchVideoRouterProtocol?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchYoutubeVideo(WatchVideo.Request.FetchYoutubeId())
        interactor?.fetchRegisterView(WatchVideo.Request.RegisterView())
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    private func setup() {
        let viewController = self
        let presenter = WatchVideoPresenter(viewController: viewController)
        let interactor = WatchVideoInteractor(presenter: presenter)
        let router = WatchVideoRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.dataStore = interactor
        router.viewController = viewController
    }
}

extension WatchVideoController: WKYTPlayerViewDelegate {
    
    func playerView(_ playerView: WKYTPlayerView, receivedError error: WKYTPlayerError) {
        
    }
}

extension WatchVideoController {
    
    @objc
    private func didTapClose() {
        router?.dismiss()
    }
}

extension WatchVideoController: WatchVideoDisplayLogic {
    
    func displayYoutubeVideo(_ viewModel: WatchVideo.Info.ViewModel.Video) {
        mainView.setup(viewModel: viewModel)
    }
}
