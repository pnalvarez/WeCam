//
//  FirebaseHelperMock.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 28/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
@testable import Lumiere
import ObjectMapper

enum ErrorMock: Error {
    case generic
}

final class FirebaseHelperMock: FirebaseAuthHelperProtocol {
    func fetchUserConnectNotifications<T>(request: GetConnectNotificationRequest, completion: @escaping (BaseResponse<[T]>) -> Void) where T : Mappable {
        
    }
    
    func fetchSignInUser<T>(request: [String : Any], completion: @escaping (BaseResponse<T>) -> Void) where T : Mappable {
        
    }
    
    func fetchCurrentUser<T>(request: [String : Any], completion: @escaping (BaseResponse<T>) -> Void) where T : Mappable {
        
    }
    
    func fetchUserData<T>(request: [String : Any], completion: @escaping (BaseResponse<T>) -> Void) where T : Mappable {
        
    }
    
    func fetchConnectUsers(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        
    }
    
    func fetchUserRelation<T>(request: [String : Any], completion: @escaping (BaseResponse<T>) -> Void) where T : Mappable {
        
    }
    
    func fetchRemoveConnection(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        
    }
    
    func fetchRemovePendingConnection(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        
    }
    
    func fetchSendConnectionRequest(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        
    }
    
    func fetchAcceptConnection(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        
    }
    
    func fetchCurrentUserConnections<T>(completion: @escaping (BaseResponse<[T]>) -> Void) where T : Mappable {
        
    }
    
    func fetchUserConnections<T>(request: [String : Any], completion: @escaping (BaseResponse<[T]>) -> Void) where T : Mappable {
        
    }
    
    func fetchRefusePendingConnection(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        
    }
    
    func fetchSignOut(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        
    }
    
    func fetchCreateProject<T>(request: [String : Any], completion: @escaping (BaseResponse<T>) -> Void) where T : Mappable {
        
    }
    
    func fetchProjectWorking<T>(request: [String : Any], completion: @escaping (BaseResponse<T>) -> Void) where T : Mappable {
        
    }
    
    func updateUserData(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        
    }
    
    func inviteUserToProject(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        
    }
    
    func fetchProjectRelation<T>(request: [String : Any], completion: @escaping (BaseResponse<T>) -> Void) where T : Mappable {
        
    }
    
    func updateProjectInfo(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        
    }
    
    func updateProjectImage<T>(request: [String : Any], completion: @escaping (BaseResponse<T>) -> Void) where T : Mappable {
        
    }
    
    func updateProjectNeedingField(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        
    }
    
    func fetchUserParticipatingProjects<T>(request: [String : Any], completion: @escaping (BaseResponse<[T]>) -> Void) where T : Mappable {
        
    }
    
    func fetchProjectInvites<T>(request: [String : Any], completion: @escaping (BaseResponse<[T]>) -> Void) where T : Mappable {
        
    }
    
    func acceptProjectInvite(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        
    }
    
    func fetchProjectParticipants<T>(request: [String : Any], completion: @escaping (BaseResponse<[T]>) -> Void) where T : Mappable {
        
    }
    
    func refuseProjectInvite(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        
    }
    
    func sendProjectParticipationRequest(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        
    }
    
    func removeProjectParticipationRequest(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        
    }
    
    func exitProject(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        
    }
    
    func fetchProjectParticipationRequestNotifications<T>(request: [String : Any], completion: @escaping (BaseResponse<[T]>) -> Void) where T : Mappable {
        
    }
    
    func acceptUserIntoProject(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        
    }
    
    func refuseUserIntoProject(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        
    }
    
    func fetchUserRelationToProject<T>(request: [String : Any], completion: @escaping (BaseResponse<T>) -> Void) where T : Mappable {
        
    }
    
    func removeProjectInviteToUser(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        
    }
    
    func removeUserFromProject(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        
    }
    
    func fetchCurrentUserAuthoringProjects<T>(request: [String : Any], completion: @escaping (BaseResponse<[T]>) -> Void) where T : Mappable {
        
    }
    
    func updateProjectProgress(request: [String : Any], completion: @escaping (EmptyResponse) -> Void) {
        
    }
    
    
    func createUser(request: CreateUserRequest,
                    completion: @escaping (SignUp.Response.RegisterUser) -> Void) {
        if request.password == "ERROR" {
            completion(.error(ErrorMock.generic))
        } else {
            completion(.success(SignUp.Response.UserResponse(uid: "12xy4")))
        }
    }
    
    func registerUserData(request: SaveUserInfoRequest,
                          completion: @escaping (SignUp.Response.SaveUserInfo) -> Void) {
        if request.name == "ERROR" {
            completion(.error(ErrorMock.generic))
        } else {
            completion(.success)
        }
    }
    
    func signInUser(request: SignInRequest,
                    completion: @escaping (SignIn.Response.SignInResponse) -> Void) {
        if request.email == "ERROR" {
            completion(.error(.init(error: ErrorMock.generic)))
        } else {
            completion(.success)
        }
    }
}
