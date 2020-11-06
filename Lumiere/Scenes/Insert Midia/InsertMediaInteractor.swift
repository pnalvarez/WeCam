//
//  InsertMediaInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 04/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import Foundation

protocol InsertMediaBusinessLogic {
    func fetchYoutubeVideoId(_ request: InsertMedia.Request.FetchVideo)
    func fetchPublishVideo(_ request: InsertMedia.Request.Publish)
}

protocol InsertMediaDataStore {
    var receivedData: InsertMedia.Info.Received.FinishingProject? { get set }
    var media: InsertMedia.Info.Model.Media? { get }
    var finishedProject: InsertMedia.Info.Model.FinishedProject? { get }
}

class InsertMediaInteractor: InsertMediaDataStore {
    
    private let worker: InsertMediaWorkerProtocol
    private let presenter: InsertMediaPresentationLogic
    
    var receivedData: InsertMedia.Info.Received.FinishingProject?
    var media: InsertMedia.Info.Model.Media?
    var finishedProject: InsertMedia.Info.Model.FinishedProject?
    
    init(worker: InsertMediaWorkerProtocol = InsertMediaWorker(),
         presenter: InsertMediaPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
}

extension InsertMediaInteractor {
    
    private func fetchSubmitVideoData() {
        let request = InsertMedia
            .Request
            .SubmitVideo(projectId: finishedProject?.id ?? .empty,
                         projectTitle: finishedProject?.title ?? .empty,
                         sinopsis: finishedProject?.sinopsis ?? .empty,
                         cathegories: finishedProject?.cathegories ?? .empty,
                         participants: finishedProject?.teamMembers ?? .empty,
                         image: finishedProject?.image ?? .empty,
                         media: finishedProject?.media ?? .empty,
                         finishedDate: Int(finishedProject?.finishDate.timeIntervalSince1970 ?? 0))
        worker.fetchPublishProject(request) { response in
            switch response {
            case .success:
                self.presenter.presentLoading(false)
                self.presenter.presentFinishedProjectDetails()
            case .error(let error):
                self.presenter.presentLoading(false)
            }
        }
    }
}

extension InsertMediaInteractor: InsertMediaBusinessLogic {
    
    func fetchYoutubeVideoId(_ request: InsertMedia.Request.FetchVideo) {
        guard let id = request.url.youtubeID else {
            presenter.presentVideoError()
            return
        }
        media = InsertMedia.Info.Model.Media(videoId: id)
        guard let media = self.media else { return }
        presenter.presentVideoWithId(media)
    }
    
    func fetchPublishVideo(_ request: InsertMedia.Request.Publish) {
        presenter.presentLoading(true)
        worker.fetchProjectDetails(InsertMedia.Request.FetchProjectDetails(id: receivedData?.id ?? .empty)) { response in
            switch response {
            case .success(let data):
                self.finishedProject = InsertMedia
                    .Info
                    .Model
                    .FinishedProject(id: data.id ?? .empty,
                                     title: data.title ?? .empty,
                                     cathegories: data.cathegories ?? .empty,
                                     sinopsis: data.sinopsis ?? .empty,
                                     teamMembers: data.teamMembers ?? .empty,
                                     image: data.image ?? .empty,
                                     media: self.media?.videoId ?? .empty,
                                     finishDate: Date())
                self.fetchSubmitVideoData()
            case .error(let error):
                break
            }
        }
    }
}
