//
//  EditProjectDetailsWorker.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 21/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import Foundation
import ObjectMapper

protocol EditProjectDetailsWorkerProtocol {
    func fetchPublish(request: EditProjectDetails.Request.CompletePublish,
                      completion: @escaping (BaseResponse<EditProjectDetails.Info.Response.Project>) -> Void)
    func fetchInviteUser(request: EditProjectDetails.Request.InviteUser,
                         completion: @escaping (EmptyResponse) -> Void)
}

class EditProjectDetailsWorker: EditProjectDetailsWorkerProtocol {
    
    private let builder: FirebaseAuthHelperProtocol
    
    init(builder: FirebaseAuthHelperProtocol = FirebaseAuthHelper()) {
        self.builder = builder
    }
    
    func fetchPublish(request: EditProjectDetails.Request.CompletePublish,
                      completion: @escaping (BaseResponse<EditProjectDetails.Info.Response.Project>) -> Void) {
        let headers: [String : Any] = ["payload": ["image": request.project.image,
                                                   "title": request.project.title,
                                                   "cathegories": request.project.cathegories,
                                                   "sinopsis": request.project.sinopsis,
                                                   "needing": request.project.needing,
                                                   "percentage": request.project.progress] ]
        builder.fetchCreateProject(request: headers, completion: completion)
    }
    
    func fetchInviteUser(request: EditProjectDetails.Request.InviteUser,
                         completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["image": request.image,
                                       "project_title": request.title,
                                       "projectId": request.projectId,
                                       "author_id": request.authorId,
                                       "userId": request.userId]
        builder.inviteUserToProject(request: headers, completion: completion)
    }
}
