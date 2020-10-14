//
//  EditProfileDetailsWorkerMock.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 28/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

@testable import Lumiere

final class EditProfileDetailsWorkerMock: EditProfileDetailsWorkerProtocol {
    
    func fetchUserData(request: EditProfileDetails.Request.UserData,
                       completion: @escaping (BaseResponse<EditProfileDetails.Info.Response.User>) -> Void) {
        completion(.success(EditProfileDetails.Info.Response.User.stub))
    }
    
    func fetchUpdateUserDetails(request: EditProfileDetails.Request.UpdateUser, completion: @escaping (EmptyResponse) -> Void) {
        guard request.name != "ERROR MOCK" else {
            completion(.error(FirebaseErrors.genericError))
            return
        }
        completion(.success)
    }
}
