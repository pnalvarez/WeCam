//
//  APICathegoryManager.swift
//  WeCam
//
//  Created by Pedro Alvarez on 18/04/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import Firebase
import FirebaseDatabase

final class APICathegoryManager {
    typealias Cathegory = String
    
    private let realtimeDB = Database.database().reference()
    
    static let shared = APICathegoryManager()
    
    private init() { }
    
    func fetchInterestCathegories(userId: String,
                                  successCallback: @escaping ([Cathegory]) -> Void,
                                  failureCallback: @escaping (WCError) -> Void) {
        realtimeDB
            .child(Paths.usersPath)
            .child(userId)
            .child("interest_cathegories")
            .observeSingleEvent(of: .value) { snapshot in
                guard let cathegories = snapshot.value as? [String] else {
                    failureCallback(.genericError)
                    return
                }
                successCallback(cathegories)
        }
    }
    
    func fetchFilterCathegories(userId: String,
                                successCallback: @escaping ([Cathegory]) -> Void,
                                failureCallback: @escaping (WCError) -> Void) {
        realtimeDB
            .child(Paths.usersPath)
            .child(userId)
            .child("filtered_ongoing_project_cathegories")
            .observeSingleEvent(of: .value) { snapshot in
                guard let cathegories = snapshot.value as? [String] else {
                    successCallback(.empty)
                    return
                }
                successCallback(cathegories)
        }
    }
    
    func saveFilterCathegories(userId: String,
                               cathegories: [Cathegory],
                               successCallback: @escaping () -> Void,
                               failureCallback: @escaping (WCError) -> Void) {
        realtimeDB
            .child(Paths.usersPath)
            .child(userId)
            .updateChildValues(["filtered_ongoing_project_cathegories": cathegories]) { error, ref in
                if error != nil {
                    failureCallback(.filterProjects)
                    return
                }
                successCallback()
        }
    }
}
