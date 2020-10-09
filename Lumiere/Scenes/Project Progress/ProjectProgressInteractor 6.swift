//
//  ProjectProgressInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 20/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol ProjectProgressBusinessLogic {
    func fetchAdvance(_ request: ProjectProgress.Request.Advance)
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
         viewController: ProjectProgressDisplayLogic) {
        self.worker = worker
        self.presenter = ProjectProgressPresenter(viewController: viewController)
    }
}

extension ProjectProgressInteractor: ProjectProgressBusinessLogic {

    func fetchAdvance(_ request: ProjectProgress.Request.Advance) {
        progressingProject = ProjectProgress.Info.Model.Project(image: projectData?.image,
                                                                cathegories: projectData?.cathegories ?? .empty,
                                                                progress: request.percentage)
        presenter.presentEditProjectDetails()
    }
}
