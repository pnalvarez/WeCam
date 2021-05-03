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

class WatchVideoView: BaseView {
    
    private unowned var playerView: WKYTPlayerView
    
    private var viewModel: WatchVideo.Info.ViewModel.Video?
    
    init(frame: CGRect,
         playerView: WKYTPlayerView) {
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
        addSubview(playerView)
    }
    
    func setupConstraints() {
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
