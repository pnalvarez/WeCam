//
//  ProfileDetailsInteractorMock.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 24/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

@testable import Lumiere

final class ProfileDetailsInteractorMock: ProfileDetailsBusinessLogic {
    
    private let presenter: ProfileDetailsPresentationLogic
    
    init(presenter: ProfileDetailsPresentationLogic) {
        self.presenter = presenter
    }
    
    func fetchUserInfo(_ request: ProfileDetails.Request.UserData) {
        presenter.presentUserInfo(ProfileDetails.Info.Model.User.stub)
    }
    
    func fetchInteract(_ request: ProfileDetails.Request.AddConnection) {
        
    }
    
    func fetchAllConnections(_ request: ProfileDetails.Request.AllConnections) {
        
    }
    
    func fetchConfirmInteraction(_ request: ProfileDetails.Request.ConfirmInteraction) {
        
    }
    
    func didSelectOnGoingProject(_ request: ProfileDetails.Request.SelectProjectWithIndex) {
        
    }
}
