//
//  NotificationsWorkerMock.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 24/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

@testable import Lumiere

final class NotificationsWorkerMock: NotificationsWorkerProtocol {
    
    func fetchConnectionNotifications(_ request: Notifications.Request.FetchConnectionNotifications,
                                      completion: @escaping (BaseResponse<Array<Notifications.Response.ConnectNotification>>) -> Void) {
        guard request.userId != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success(Notifications.Response.ConnectNotification.stubArray))
    }
    
    func fetchProjectInviteNotifications(_ request: Notifications.Request.ProjectInviteNotifications,
                                         completion: @escaping (BaseResponse<[Notifications.Response.OnGoingProjectInvite]>) -> Void) {
        completion(.success(Notifications.Response.OnGoingProjectInvite.stubArray))
    }
    
    func fetchUserData(_ request: Notifications.Request.FetchUserData,
                       completion: @escaping (BaseResponse<Notifications.Response.User>) -> Void) {
        guard request.userId != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success(Notifications.Response.User.stub))
    }
    
    func fetchConnectUsers(_ request: Notifications.Request.ConnectUsers,
                           completion: @escaping (EmptyResponse) -> Void) {
        guard request.fromUserId != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success)
    }
    
    func fetchRemovePendingConnectNotification(_ request: Notifications.Request.RemovePendingNotification,
                                               completion: @escaping (EmptyResponse) -> Void) {
        guard request.userId != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success)
    }
    
    func fetchInvitingUserData(_ request: Notifications.Request.FetchInvitingUser, completion: @escaping (BaseResponse<Notifications.Response.InvitingUser>) -> Void) {
        guard request.userId != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success(Notifications.Response.InvitingUser.stub))
    }
    
    func fetchAcceptProjectInvite(_ request: Notifications.Request.AcceptProjectInvite,
                                  completion: @escaping (EmptyResponse) -> Void) {
        guard request.projectId != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success)
    }
    
    func fetchProjectParticipationRequestNotifications(_ request: Notifications.Request.FetchProjectParticipationRequestNotifications,
                                                       completion: @escaping (BaseResponse<[Notifications.Response.OnGoingProjectParticipationRequest]>) -> Void) {
        completion(.success(Notifications.Response.OnGoingProjectParticipationRequest.stubArray))
    }
    
    func fetchAcceptUserIntoProject(_ request: Notifications.Request.FetchAcceptUserIntoProject,
                                    completion: @escaping (EmptyResponse) -> Void) {
        guard request.userId != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success)
    }
    
    func fetchRefuseProjectInvite(_ request: Notifications.Request.RefuseProjectInvite,
                                  completion: @escaping (EmptyResponse) -> Void) {
        guard request.projectId != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success)
    }
    
    func fetchRefuseProjectParticipationRequest(_ request: Notifications.Request.RefuseParticipationRequest,
                                                completion: @escaping (EmptyResponse) -> Void) {
        guard request.userId != "ERROR" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success)
    }
}
