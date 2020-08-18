//
//  SelectProjectImagePresenter.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 16/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

protocol SelectProjectImagePresentationLogic {
    func presentImages(_ response: SelectProjectImage.Info.Model.Images)
    func presentSelectedImage(_ response: SelectProjectImage.Info.Model.Project)
}

class SelectProjectImagePresenter: SelectProjectImagePresentationLogic {
    
    private unowned var viewController: SelectProjectImageDisplayLogic
    
    init(viewController: SelectProjectImageDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentImages(_ response: SelectProjectImage.Info.Model.Images) {
        let viewModel = SelectProjectImage.Info.ViewModel.AlbumImages(images: response.images)
        viewController.displayImages(viewModel)
    }
    
    func presentSelectedImage(_ response: SelectProjectImage.Info.Model.Project) {
        guard let image = response.image else { return }
        let viewModel = SelectProjectImage.Info.ViewModel.SelectedImage(image: UIImage(data: image))
        viewController.displaySelectedImage(viewModel)
    }
}
