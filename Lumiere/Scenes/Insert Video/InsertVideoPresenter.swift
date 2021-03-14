//
//  InsertMediaPresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 04/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

protocol InsertVideoPresentationLogic {
    func presentVideoError()
    func presentVideoWithId(_ response: InsertVideo.Info.Model.Video)
    func presentFinishedProjectDetails()
    func presentLoading(_ loading: Bool)
    func presentLongLoading(_ loading: Bool)
    func presentConfirmationModal()
}

class InsertVideoPresenter: InsertVideoPresentationLogic {
    
    private unowned var viewController: InsertVideoDisplayLogic
    
    init(viewController: InsertVideoDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentVideoError() {
        viewController.displayVideoError()
    }
    
    func presentVideoWithId(_ response: InsertVideo.Info.Model.Video) {
        let viewModel = InsertVideo.Info.ViewModel.Video(videoId: response.videoId)
        viewController.displayYoutubeVideo(viewModel)
    }
    
    func presentFinishedProjectDetails() {
        viewController.displayFinishedProjectDetails()
    }
    
    func presentLoading(_ loading: Bool) {
        viewController.displayLoading(loading)
    }
    
    func presentLongLoading(_ loading: Bool) {
        viewController.displayLongLoading(loading)
    }
    
    func presentConfirmationModal() {
        viewController.displayConfirmationAlert()
    }
}
