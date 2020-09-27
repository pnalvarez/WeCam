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
    var projectModel: SelectProjectImage.Info.Model.Project? { get }
}

class SelectProjectImageInteractor: SelectProjectImageDataStore {
    
    private let presenter: SelectProjectImagePresentationLogic
    private let worker: SelectProjectImageWorkerProtocol
    
    var projectModel: SelectProjectImage.Info.Model.Project?
    
    init(presenter: SelectProjectImagePresentationLogic,
         worker: SelectProjectImageWorkerProtocol = SelectProjectImageWorker()) {
        self.presenter = presenter
        self.worker = worker
    }
}

extension SelectProjectImageInteractor: SelectProjectImageBusinessLogic {
    
    func didSelectImage(_ request: SelectProjectImage.Request.SelectImage) {
        projectModel = SelectProjectImage.Info.Model.Project(image: request.image.jpegData(compressionQuality: 0.5))
    }
    
    func fetchAdvance(_ request: SelectProjectImage.Request.Advance) {
        guard projectModel?.image != nil else{
            presenter.presentError("Selecione uma imagem para o seu projeto")
            return
        }
        presenter.presentCathegories()
    }
}
