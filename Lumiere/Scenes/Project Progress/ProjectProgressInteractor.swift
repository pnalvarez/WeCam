//
//  ProjectProgressInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 20/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol ProjectProgressBusinessLogic {
    func fetchAdvance(_ request: ProjectProgress.Request.Advance)
    func fetchConfirmFinished(_ request: ProjectProgress.Request.ConfirmFinishedStatus)
    func fetchConfirmPercentage(_ request: ProjectProgress.Request.ConfirmPercentage)
}

protocol ProjectProgressDataStore {
    var projectData: ProjectProgress.Info.Received.Project? { get set }
    var progressingProject: ProjectProgress.Info.Model.Project? { get set }
}

class ProjectProgressInteractor: ProjectProgressDataStore {
    
    private var worker: ProjectProgressWorkerProtocol
    var presenter: ProjectProgressPresentationLogic
    
    var projectData: ProjectProgress.Info.Received.Project?
    var progressingProject: ProjectProgress.Info.Model.Project?
    
    init(worker: ProjectProgressWorkerProtocol = ProjectProgressWorker(),
         presenter: ProjectProgressPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
}

extension ProjectProgressInteractor: ProjectProgressBusinessLogic {

    func fetchAdvance(_ request: ProjectProgress.Request.Advance) {
        progressingProject = ProjectProgress.Info.Model.Project(image: projectData?.image,
                                                                cathegories: projectData?.cathegories ?? .empty,
                                                                progress: request.percentage)
        if request.percentage > ProjectProgress.Constants.BusinessLogic.finishedProgressBottonRange {
            presenter.presentFinishConfirmationAlert()
        } else {
            presenter.presentEditProjectDetails()
        }
    }
    
    func fetchConfirmFinished(_ request: ProjectProgress.Request.ConfirmFinishedStatus) {
        progressingProject?.progress = ProjectProgress.Constants.BusinessLogic.finishedPercentage
        progressingProject?.status = .finished
        presenter.presentEditProjectDetails()
    }
    
    func fetchConfirmPercentage(_ request: ProjectProgress.Request.ConfirmPercentage) {     
        presenter.presentEditProjectDetails()
    }
}
