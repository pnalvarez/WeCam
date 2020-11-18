//
//  InsertVideoInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 04/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import Foundation

protocol InsertVideoBusinessLogic {
    func fetchYoutubeVideoId(_ request: InsertVideo.Request.FetchVideo)
    func fetchPublishVideo(_ request: InsertVideo.Request.Publish)
    func fetchConfirmPublishing(_ request: InsertVideo.Request.Confirm)
}

protocol InsertVideoDataStore {
    var receivedData: InsertVideo.Info.Received.ReceivedProject? { get set }
    var video: InsertVideo.Info.Model.Video? { get }
    var finishedProject: InsertVideo.Info.Model.ProjectToSubmit? { get }
}

class InsertVideoInteractor: InsertVideoDataStore {
    
    private let worker: InsertVideoWorkerProtocol
    private let presenter: InsertVideoPresentationLogic
    
    var receivedData: InsertVideo.Info.Received.ReceivedProject?
    var video: InsertVideo.Info.Model.Video?
    var finishedProject: InsertVideo.Info.Model.ProjectToSubmit?
    
    init(worker: InsertVideoWorkerProtocol = InsertVideoWorker(),
         presenter: InsertVideoPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
}

extension InsertVideoInteractor {
    
    private func fetchSubmitVideoData(withData project: InsertVideo.Info.Model.FinishedProject) {
        let request = InsertVideo
            .Request
            .SubmitVideo(projectId: project.id,
                         projectTitle: project.title,
                         sinopsis: project.sinopsis,
                         cathegories: project.cathegories,
                         participants: project.teamMembers,
                         image: project.image,
                         video: project.media,
                         finishedDate: Int(project.finishDate.timeIntervalSince1970))
        worker.fetchPublishExistingProject(request) { response in
            switch response {
            case .success:
                self.presenter.presentLongLoading(false)
                self.presenter.presentFinishedProjectDetails()
            case .error(let error):
                self.presenter.presentLoading(false)
            }
        }
    }
    
    private func fetchFinishingProjectDetails(withData project: InsertVideo.Info.Received.FinishingProject) {
        worker.fetchProjectDetails(InsertVideo.Request.FetchProjectDetails(id: project.id)) { response in
            switch response {
            case .success(let data):
                let project = InsertVideo
                    .Info
                    .Model
                    .FinishedProject(id: data.id ?? .empty,
                                     title: data.title ?? .empty,
                                     cathegories: data.cathegories ?? .empty,
                                     sinopsis: data.sinopsis ?? .empty,
                                     teamMembers: data.teamMembers ?? .empty,
                                     image: data.image ?? .empty,
                                     media: self.video?.videoId ?? .empty,
                                     finishDate: Date())
                self.finishedProject = InsertVideo
                    .Info
                    .Model
                    .ProjectToSubmit.finishing(project)
                    
                self.fetchSubmitVideoData(withData: project)
            case .error(let error):
                break
            }
        }
    }
    
    private func publishNewProject(withData project: InsertVideo.Info.Received.NewProject) {
        let project = InsertVideo
            .Info
            .Model
            .NewProject(title: project.title,
                        cathegories: project.cathegories,
                        sinopsis: project.sinopsis,
                        teamMembers: .empty,
                        image: project.image,
                        media: video?.videoId ?? .empty,
                        finishDate: Date())
        finishedProject = InsertVideo.Info.Model.ProjectToSubmit.new(project)
        worker.fetchPublishNewProject(InsertVideo
                                        .Request
                                        .CreateProject(projectTitle: project.title,
                                                       sinopsis: project.sinopsis,
                                                       cathegories: project.cathegories,
                                                       participants: project.teamMembers,
                                                       image: project.image,
                                                       video: video?.videoId ?? .empty,
                                                       finishedDate: Int(project.finishDate.timeIntervalSince1970))) {
            response in
            switch response {
            case .success:
                self.presenter.presentLongLoading(false)
                self.presenter.presentFinishedProjectDetails()
            case .error(let error):
                break
            }
        }
    }
}

extension InsertVideoInteractor: InsertVideoBusinessLogic {
    
    func fetchYoutubeVideoId(_ request: InsertVideo.Request.FetchVideo) {
        guard let id = request.url.youtubeID, id.count == InsertVideo.Constants.BusinessLogic.youtubeIdLenght else {
            presenter.presentVideoError()
            return
        }
        video = InsertVideo.Info.Model.Video(videoId: id)
        guard let video = self.video else { return }
        presenter.presentVideoWithId(video)
    }
    
    func fetchPublishVideo(_ request: InsertVideo.Request.Publish) {
        presenter.presentConfirmationModal()
    }
    
    func fetchConfirmPublishing(_ request: InsertVideo.Request.Confirm) {
        presenter.presentLongLoading(true)
        switch receivedData {
        case .finishing(let project):
            fetchFinishingProjectDetails(withData: project)
        case .new(let project):
            publishNewProject(withData: project)
            break
        case .none:
            break
        }
    }
}

