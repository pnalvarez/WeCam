//
//  SaveNotificationsRequest.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 02/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import Foundation

struct SaveNotificationsRequest {
    let fromUserId: String
    let toUserId: String
    let notifications: Array<Any>
}
