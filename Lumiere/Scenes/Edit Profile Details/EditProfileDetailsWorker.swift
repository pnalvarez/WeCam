//
//  EditProfileDetailsWorker.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 23/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol EditProfileDetailsWorkerProtocol {
    func fetchUserData(request: EditProfileDetails.Request.UserData,
                       completion: @escaping (BaseResponse<EditProfileDetails.Info.Response.User>) -> Void)
    func fetchUpdateUserDetails(request: EditProfileDetails.Request.UpdateUser,
                                completion: @escaping (EmptyResponse) -> Void)
}

class EditProfileDetailsWorker: EditProfileDetailsWorkerProtocol {
    
    private let builder: FirebaseManagerProtocol
    
    init(builder: FirebaseManagerProtocol = FirebaseManager()) {
        self.builder = builder
    }
    
    func fetchUserData(request: EditProfileDetails.Request.UserData,
                       completion: @escaping (BaseResponse<EditProfileDetails.Info.Response.User>) -> Void) {
        builder.fetchCurrentUser(request: [:], completion: completion)
    }
    
    func fetchUpdateUserDetails(request: EditProfileDetails.Request.UpdateUser, completion: @escaping (EmptyResponse) -> Void) {
        let headers: [String : Any] = ["payload": ["name": request.name,
                                                   "interest_cathegories": request.interestCathegories,
                                                   "professional_area": request.ocupation,
                                                   "phone_number": request.cellphone,
                                                    ],
                                       "image": request.image
        ]
        builder.updateUserData(request: headers, completion: completion)
    }
}
