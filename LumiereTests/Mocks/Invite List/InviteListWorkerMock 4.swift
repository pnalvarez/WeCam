//
//  InviteListWorkerMock.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 28/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

@testable import Lumiere

final class InviteListWorkerMock: InviteListWorkerProtocol {
    
    func fetchConnections(_ request: InviteList.Request.FetchConnections, completion: @escaping (BaseResponse<[InviteList.Info.Response.User]>) -> Void) {
        completion(.success(InviteList.Info.Response.User.stubArray))
    }
}
