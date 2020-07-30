//
//  SignInInteractor+Tests.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 28/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
@testable import Lumiere
import XCTest

class SignInInteractor_Tests: XCTestCase {

    var sut: SignInInteractor!
    var mock: SignInProviderProtocol! = SignInProviderMock()
    
    override func setUp() {
        super.setUp()
        sut = SignInInteractor(viewController: SignInController())
        sut.provider = mock
        sut.presenter = self
    }
    
    override func tearDown() {
        sut = nil
        mock = nil
        super.tearDown()
    }

    func testFetchSignIn() {
        
    }
}

extension SignInInteractor_Tests: SignInPresentationLogic {
    
    func didFetchSuccessLogin() {
        
    }
    
    func didFetchServerError(_ error: SignIn.Errors.ServerError) {
        
    }
    
    func didFetchInputError(_ error: SignIn.Errors.InputError) {
        
    }
    
    func presentLoading(_ loading: Bool) {
        
    }
}
