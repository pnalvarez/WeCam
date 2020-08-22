//
//  EditProjectDetailsWorker.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 21/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol EditProjectDetailsWorkerProtocol {
    func fetchPublish(request: EditProjectDetails.Request.CompletePublish,
                      completion: @escaping (EmptyResponse) -> Void)
}

class EditProjectDetailsWorker: EditProjectDetailsWorkerProtocol {
    
    private let builder: FirebaseAuthHelperProtocol
    
    init(builder: FirebaseAuthHelperProtocol = FirebaseAuthHelper()) {
        self.builder = builder
    }
    
    func fetchPublish(request: EditProjectDetails.Request.CompletePublish,
                      completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["payload": ["image": request.project.image,
                                                   "cathegories": request.project.cathegories,
                                                   "sinopsis": request.project.sinopsis,
                                                   "needing": request.project.needing,
                                                   "percentage": request.project.progress],
                                       "participants": request.project.invitedUserIds]
        builder.fetchCreateProject(request: headers, completion: completion)
    }
}
