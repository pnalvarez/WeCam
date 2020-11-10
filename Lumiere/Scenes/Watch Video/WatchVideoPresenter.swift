//
//  WatchVideoPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 09/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol WatchVideoPresentationLogic {
    func presentYoutubeVideo(_ response: WatchVideo.Info.Model.Video)
    func presentLoading(_ loading: Bool)
}

class WatchVideoPresenter: WatchVideoPresentationLogic {
    
    private unowned var viewController: WatchVideoDisplayLogic
    
    init(viewController: WatchVideoDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentYoutubeVideo(_ response: WatchVideo.Info.Model.Video) {
        let viewModel = WatchVideo.Info.ViewModel.Video(id: response.id)
        viewController.displayYoutubeVideo(viewModel)
    }
    
    func presentLoading(_ loading: Bool) {
        viewController.displayLoading(loading)
    }
}
