//
//  BaseResponse.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 06/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import ObjectMapper

enum BaseResponse<T> {
    case success(T)
    case error(Error)
}

enum EmptyResponse {
    case success
    case error(Error)
}

enum CheckEntityResponse {
    case sucess(type: EntityType)
    case error
}

enum EntityType: String {
    case user = "user"
    case ongoingProject = "ongoing_project"
    case finishedProject = "finished_project"
}
