//
//  ProfileDetailsWorkerMock.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 02/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
@testable import Lumiere

final class ProfileDetailsWorkerMock: ProfileDetailsWorkerProtocol {
    
    func fetchUserConnectNotifications(_ request: ProfileDetails.Request.FetchNotifications, completion: @escaping (ProfileDetails.Response.AllNotifications) -> Void) {
        
    }
    
    func fetchCurrentUserId(_ request: ProfileDetails.Request.FetchCurrentUserId, completion: @escaping (ProfileDetails.Response.CurrentUserId) -> Void) {
        
    }
    
    func fetchCurrentUserData(_ request: ProfileDetails.Request.FetchCurrentUserData, completion: @escaping (ProfileDetails.Response.CurrentUser) -> Void) {
        
    }
    
    func fetchProjectData(_ request: ProfileDetails.Request.ProjectInfo) {
        
    }
    
    func fetchAddConnection(_ request: ProfileDetails.Request.NewConnectNotification, completion: @escaping (ProfileDetails.Response.AddConnection) -> Void) {
        
    }
}
