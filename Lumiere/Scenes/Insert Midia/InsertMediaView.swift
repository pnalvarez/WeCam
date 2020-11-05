//
//  InsertMediaView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 04/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView

class InsertMediaView: UIView {
    
    private unowned var playerView: WKYTPlayerView
    
    init(frame: CGRect,
         playerView: WKYTPlayerView) {
        self.playerView = playerView
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InsertMediaView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func configureViews() {
        
    }
}
