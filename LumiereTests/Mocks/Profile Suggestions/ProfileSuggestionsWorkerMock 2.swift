//
//  ProfileSuggestionsWorkerMock.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 28/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

@testable import Lumiere

final class ProfileSuggestionsWorkerMock: ProfileSuggestionsWorkerProtocol {
    
    func fetchCommonConnectionsProfileSuggestions(_ request: ProfileSuggestions.Request.FetchCommonConnectionsProfileSuggestions,
                                                  completion: @escaping (BaseResponse<[ProfileSuggestions.Info.Response.Profile]>) -> Void) {
        guard request.limit != 0 else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success(ProfileSuggestions.Info.Response.Profile.stubArray))
    }
    
    func fetchCommonProjectsProfileSuggestions(_ request: ProfileSuggestions.Request.FetchCommonProjectsProfileSuggestions,
                                               completion: @escaping (BaseResponse<[ProfileSuggestions.Info.Response.Profile]>) -> Void) {
        guard request.limit != 0 else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success(ProfileSuggestions.Info.Response.Profile.stubArray))
    }
    
    func fetchCommonCathegoriesProfileSuggestions(_ request: ProfileSuggestions.Request.FetchCommonCathegoriesProfileSuggestions,
                                                  completion: @escaping (BaseResponse<[ProfileSuggestions.Info.Response.Profile]>) -> Void) {
        guard request.limit != 0 else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success(ProfileSuggestions.Info.Response.Profile.stubArray))
    }
    
    func fetchSendConnectionRequest(_ request: ProfileSuggestions.Request.AddUserWithId,
                                    completion: @escaping (EmptyResponse) -> Void) {
        guard request.userId != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success)
    }
    
    func fetchRemoveProfileSuggestion(_ request: ProfileSuggestions.Request.RemoveUserWithId,
                                      completion: @escaping (EmptyResponse) -> Void) {
        guard request.userId != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success)
    }
    
}
