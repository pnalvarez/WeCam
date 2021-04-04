//
//  APINotificationManager.swift
//  WeCam
//
//  Created by Pedro Alvarez on 04/04/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import Firebase
import FirebaseDatabase

final class APINotificationManager {
    
    private let realtimeDB = Database.database().reference()
    private let authReference = Auth.auth()
    
    static let shared = APINotificationManager()
    
    private init() { }
    
    func cleanOngoingProjectInvites(projecId: String,
                                    successCallback: @escaping () -> Void,
                                    failureCallback: @escaping (WCError) -> Void) {
        var pendingInvites = [String]()
        var notifications = [[String : Any]]()
        
        realtimeDB
            .child(Paths.projectsPath)
            .child(Paths.ongoingProjectsPath)
            .child(projecId)
            .child("pending_invites")
            .observeSingleEvent(of: .value) { snapshot in
                if let pendingIds = snapshot.value as? [String] {
                    pendingInvites = pendingIds
                }
                let outDispatchGroup = DispatchGroup()
                for userId in pendingInvites {
                    outDispatchGroup.enter()
                    self.realtimeDB
                        .child(Paths.usersPath)
                        .child(userId)
                        .child("project_invite_notifications")
                        .observeSingleEvent(of: .value) { snapshot in
                            if let projectNotifications = snapshot.value as? [[String : Any]] {
                                notifications = projectNotifications
                            }
                            notifications.removeAll(where: { notification in
                                guard let id = notification["projectId"] as? String else {
                                    return false
                                }
                                return id == projecId
                            })
                            self.realtimeDB
                                .child(Paths.usersPath)
                                .child(userId)
                                .updateChildValues(["project_invite_notifications" : notifications]) { error, ref in
                                    outDispatchGroup.leave()
                                }
                    }
                    outDispatchGroup.notify(queue: .main) {
                        successCallback()
                    }
                }
        }
    }
}
