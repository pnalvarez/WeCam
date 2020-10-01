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
    
    var successFlag = false
    var serverError: SignIn.Errors.ServerError?
    var inputError: SignIn.Errors.InputError?
    var loadingFlag: Bool?
    
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

    func testFetchSignIn_Success() {
        sut.fetchSignIn(request: SignIn.Models.Request(email: "pedronalvarez@hotmail.com", password: "123456"))
        XCTAssertTrue(successFlag)
    }
    
    func testFetchSignIn_EmptyEmail() {
        sut.fetchSignIn(request: SignIn.Models.Request(email: .empty, password: "123456"))
        XCTAssertNotNil(inputError)
    }
    
    func testFetchSignIn_InvalidEmail() {
        sut.fetchSignIn(request: SignIn.Models.Request(email: "pedronalvarez", password: "123456"))
        XCTAssertNotNil(inputError)
    }
    
    func testFetchSignIn_passwordEmpty() {
        sut.fetchSignIn(request: SignIn.Models.Request(email: "pedronalvarez@hotmail.com", password: .empty))
        XCTAssertNotNil(inputError)
    }
    
    func testFetchSignIn_ServerError() {
        sut.fetchSignIn(request: SignIn.Models.Request(email: "ERROR@hotmail.com", password: "123456"))
        XCTAssertNotNil(serverError)
    }
}

extension SignInInteractor_Tests: SignInPresentationLogic {
    
    func didFetchSuccessLogin() {
        successFlag = true
    }
    
    func didFetchServerError(_ error: SignIn.Errors.ServerError) {
        serverError = error
    }
    
    func didFetchInputError(_ error: SignIn.Errors.InputError) {
        inputError = error
    }
    
    func presentLoading(_ loading: Bool) {
        loadingFlag = loading
    }
}
