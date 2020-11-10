//
//  WatchVideoInteractor.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 09/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol WatchVideoBusinessLogic {
    func fetchYoutubeVideo(_ request: WatchVideo.Request.FetchYoutubeId)
}

protocol WatchVideoDataStore {
    var receivedData: WatchVideo.Info.Received.Project? { get set }
    var video: WatchVideo.Info.Model.Video? { get }
}


class WatchVideoInteractor: WatchVideoDataStore {
    
    private let worker: WatchVideoWorkerProtocol
    private let presenter: WatchVideoPresentationLogic
    
    var receivedData: WatchVideo.Info.Received.Project?
    var video: WatchVideo.Info.Model.Video?
    
    init(worker: WatchVideoWorkerProtocol = WatchVideoWorker(),
         presenter: WatchVideoPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
}

extension WatchVideoInteractor: WatchVideoBusinessLogic {
    
    func fetchYoutubeVideo(_ request: WatchVideo.Request.FetchYoutubeId) {
        presenter.presentLoading(true)
        worker.fetchYoutubeVideo(WatchVideo.Request.FetchYoutubeIdWithProjectId(projectId: receivedData?.id ?? .empty)) { response in
            switch response {
            case .success(let data):
                self.presenter.presentLoading(false)
                self.video = WatchVideo.Info.Model.Video(id: data.videoId ?? .empty)
                guard let video = self.video else { return }
                self.presenter.presentYoutubeVideo(video)
            case .error(let error):
                self.presenter.presentLoading(false)
            }
        }
    }
}
