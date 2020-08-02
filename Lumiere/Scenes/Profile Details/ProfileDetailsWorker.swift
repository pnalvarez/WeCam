//
//  ProfileDetailsWorker.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol ProfileDetailsWorkerProtocol {
    func fetchProjectData(_ request: ProfileDetails.Request.ProjectInfo)
    func fetchAddConnection(_ request: ProfileDetails.Request.AddConnection)
}

class ProfileDetailsWorker: ProfileDetailsWorkerProtocol {
    
    private let builder: FirebaseAuthHelperProtocol
    
    init(builder: FirebaseAuthHelperProtocol = FirebaseAuthHelper()) {
        self.builder = builder
    }
    
    func fetchProjectData(_ request: ProfileDetails.Request.ProjectInfo) {
        //TO DO
    }
    
    func fetchAddConnection(_ request: ProfileDetails.Request.AddConnection) {
        //TO DO
    }
}
