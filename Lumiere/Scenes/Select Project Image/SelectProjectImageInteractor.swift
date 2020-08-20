//
//  SelectProjectImageInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 16/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol SelectProjectImageBusinessLogic {
    func didSelectImage(_ request: SelectProjectImage.Request.SelectImage)
    func fetchAdvance(_ request: SelectProjectImage.Request.Advance)
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
    
    func didSelectImage(_ request: SelectProjectImage.Request.SelectImage) {
        projectModel = SelectProjectImage.Info.Model.Project(image: request.image.jpegData(compressionQuality: 0.5))
        presenter.presentProjectCathegories()
    }
    
    func fetchAdvance(_ request: SelectProjectImage.Request.Advance) {
        presenter.presentCathegories()
    }
}
