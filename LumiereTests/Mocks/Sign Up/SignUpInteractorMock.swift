//
//  SignUpInteractorMock.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 28/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

@testable import Lumiere

class SignUpInteractorMock: SignUpBusinessLogic {
    
    var presenter: SignUpPresentationLogic
    
    init(presenter: SignUpPresentationLogic) {
        self.presenter = presenter
    }
    func fetchMovieStyles() {

    }
    
    func didSelectCathegory(_ request: SignUp.Request.SelectedCathegory) {
        
    }
    
    func fetchSignUp(_ request: SignUp.Request.UserData) {
        
    }
}
