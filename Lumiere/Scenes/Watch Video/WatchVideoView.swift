//
//  WatchVideoView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 09/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit
import YoutubePlayer_in_WKWebView

class WatchVideoView: UIView {
    
    private unowned var activityView: UIActivityIndicatorView
    private unowned var closeButton: WCCloseButton
    private unowned var playerView: WKYTPlayerView
    
    private var viewModel: WatchVideo.Info.ViewModel.Video?
    
    init(frame: CGRect,
         activityView: UIActivityIndicatorView,
         closeButton: WCCloseButton,
         playerView: WKYTPlayerView) {
        self.activityView = activityView
        self.closeButton = closeButton
        self.playerView = playerView
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(viewModel: WatchVideo.Info.ViewModel.Video?) {
        self.viewModel = viewModel
        applyViewCode()
    }
}

extension WatchVideoView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(closeButton)
        addSubview(playerView)
        addSubview(activityView)
    }
    
    func setupConstraints() {
        activityView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(28)
            make.left.equalToSuperview().inset(28)
        }
        playerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(320)
            make.height.equalTo(320)
        }
    }
    
    func configureViews() {
        playerView.load(withVideoId: viewModel?.id ?? .empty)
    }
}
