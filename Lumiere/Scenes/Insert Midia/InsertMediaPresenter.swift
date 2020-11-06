//
//  InsertMediaPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 04/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol InsertMediaPresentationLogic {
    func presentVideoError()
    func presentVideoWithId(_ response: InsertMedia.Info.Model.Media)
    func presentFinishedProjectDetails()
    func presentLoading(_ loading: Bool)
}

class InsertMediaPresenter: InsertMediaPresentationLogic {
    
    private unowned var viewController: InsertMediaDisplayLogic
    
    init(viewController: InsertMediaDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentVideoError() {
        viewController.displayVideoError()
    }
    
    func presentVideoWithId(_ response: InsertMedia.Info.Model.Media) {
        let viewModel = InsertMedia.Info.ViewModel.Media(videoId: response.videoId)
        viewController.displayYoutubeVideo(viewModel)
    }
    
    func presentFinishedProjectDetails() {
        viewController.displayFinishedProjectDetails()
    }
    
    func presentLoading(_ loading: Bool) {
        viewController.displayLoading(loading)
    }
}
