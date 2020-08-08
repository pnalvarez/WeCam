//
//  AppDelegate.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import Firebase
import ObjectMapper

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

final class TestMappable: Mappable {
    
    var relation: String?
    
    init?(map: Map) { }
    
    func mapping(map: Map) {
        relation <- map["relation"]
    }
}

extension AppDelegate {
    
    private func fetchTest(request: FetchUserRelationRequest,
                           completion: @escaping (BaseResponse<TestMappable>) -> Void) {
        FirebaseAuthHelper().fetchUserRelation(request: request, completion: completion)
    }
}

