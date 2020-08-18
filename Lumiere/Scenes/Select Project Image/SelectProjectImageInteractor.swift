//
//  SelectProjectImageInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 16/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol SelectProjectImageBusinessLogic {
    func fetchDeviceImages(_ request: SelectProjectImage.Request.AlbumImages)
    func didSelectImage(_ request: SelectProjectImage.Request.SelectImage)
}

protocol SelectProjectImageDataStore {
    var projectModel: SelectProjectImage.Info.Model.Project? { get set }
}

class SelectProjectImageInteractor: SelectProjectImageDataStore {
    
    var presenter: SelectProjectImagePresentationLogic
    var worker: SelectProjectImageWorkerProtocol
    
    var projectModel: SelectProjectImage.Info.Model.Project?
    
    init(viewController: SelectProjectImageDisplayLogic,
         worker: SelectProjectImageWorkerProtocol = SelectProjectImageWorker()) {
        self.presenter = SelectProjectImagePresenter(viewController: viewController)
        self.worker = worker
    }
}

extension SelectProjectImageInteractor: SelectProjectImageBusinessLogic {
    
    func fetchDeviceImages(_ request: SelectProjectImage.Request.AlbumImages) {
        worker.fetchAlbumImages(request) { response in
            let data = SelectProjectImage.Info.Model.Images(images: response.images)
            self.presenter.presentImages(data)
        }
    }
    
    func didSelectImage(_ request: SelectProjectImage.Request.SelectImage) {
        projectModel = SelectProjectImage.Info.Model.Project(image: request.image.jpegData(compressionQuality: 0.5))
        guard let project = projectModel else { return }
        presenter.presentSelectedImage(project)
    }
}
