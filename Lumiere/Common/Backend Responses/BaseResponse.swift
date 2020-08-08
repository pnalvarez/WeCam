//
//  BaseResponse.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 06/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

enum BaseResponse<T> {
    case success(T)
    case error(Error)
}

enum EmptyResponse {
    case success
    case error(Error)
}
