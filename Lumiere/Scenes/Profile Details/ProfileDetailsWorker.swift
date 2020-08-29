//
//  ProfileDetailsWorker.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import ObjectMapper

protocol ProfileDetailsWorkerProtocol {
    func fetchUserInfo(request: ProfileDetails.Request.FetchUserDataWithId,
                       completion: @escaping (BaseResponse<ProfileDetails.Response.User>) -> Void)
    func fetchProjectData(_ request: ProfileDetails.Request.ProjectInfo)
    func fetchRemoveConnection(_ request: ProfileDetails.Request.RemoveConnection,
                                completion: @escaping (EmptyResponse) -> Void)
    func fetchRemovePendingConnection(_ request: ProfileDetails.Request.RemovePendingConnection,
                                      completion: @escaping (EmptyResponse) -> Void)
    func fetchSendConnectionRequest(_ request: ProfileDetails.Request.SendConnectionRequest,
                                    completion: @escaping (EmptyResponse) -> Void)
    func fetchAcceptConnection(_ request: ProfileDetails.Request.AcceptConnectionRequest,
                               completion: @escaping (EmptyResponse) -> Void)
    func fetchSignOut(_ request: ProfileDetails.Request.SignOut,
                      completion: @escaping (EmptyResponse) -> Void)
}

class ProfileDetailsWorker: ProfileDetailsWorkerProtocol {

    private let builder: FirebaseAuthHelperProtocol
    
    init(builder: FirebaseAuthHelperProtocol = FirebaseAuthHelper()) {
        self.builder = builder
    }

    func fetchUserInfo(request: ProfileDetails.Request.FetchUserDataWithId,
                       completion: @escaping (BaseResponse<ProfileDetails.Response.User>) -> Void) {
        builder.fetchUserData(request: ["userId": request.id], completion: completion)
    }
    
    func fetchProjectData(_ request: ProfileDetails.Request.ProjectInfo) {
        //TO DO
    }
    
    func fetchRemoveConnection(_ request: ProfileDetails.Request.RemoveConnection,
                                completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["userId": request.id]
        builder.fetchRemoveConnection(request: headers, completion: completion)
    }
    
    func fetchRemovePendingConnection(_ request: ProfileDetails.Request.RemovePendingConnection,
                                      completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String: Any] = ["userId": request.id]
        builder.fetchRemovePendingConnection(request: headers, completion: completion)
    }
    
    func fetchSendConnectionRequest(_ request: ProfileDetails.Request.SendConnectionRequest,
                                    completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["userId": request.id]
        builder.fetchSendConnectionRequest(request: headers, completion: completion)
    }
    
    func fetchAcceptConnection(_ request: ProfileDetails.Request.AcceptConnectionRequest,
                               completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String: Any] = ["userId": request.id]
        builder.fetchAcceptConnection(request: headers, completion: completion)
    }
    
    func fetchSignOut(_ request: ProfileDetails.Request.SignOut,
                      completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = .empty
        builder.fetchSignOut(request: headers, completion: completion)
    }
}

