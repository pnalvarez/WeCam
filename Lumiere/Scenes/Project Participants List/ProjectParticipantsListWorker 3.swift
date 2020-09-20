//
//  ProjectParticipantsListWorker.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 05/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol ProjectParticipantsListWorkerProtocol {
    func fetchParticipants(_ request: ProjectParticipantsList.Request.FetchParticipantsWithId,
                           completion: @escaping (BaseResponse<[ProjectParticipantsList.Info.Response.Participant]>) -> Void)
}

class ProjectParticipantsListWorker: ProjectParticipantsListWorkerProtocol {
    
    private let builder: FirebaseAuthHelperProtocol
    
    init(builder: FirebaseAuthHelperProtocol = FirebaseAuthHelper()) {
        self.builder = builder
    }
    
    func fetchParticipants(_ request: ProjectParticipantsList.Request.FetchParticipantsWithId,
                           completion: @escaping (BaseResponse<[ProjectParticipantsList.Info.Response.Participant]>) -> Void) {
        let headers: [String : Any] = ["projectId" : request.projectId]
        builder.fetchProjectParticipants(request: headers, completion: completion)
    }
}
