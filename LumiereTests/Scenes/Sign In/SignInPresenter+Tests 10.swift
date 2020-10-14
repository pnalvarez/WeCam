//
//  SignInPresenter+Tests.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 28/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
@testable import Lumiere
import XCTest

class SignInPresenter_Tests: XCTestCase {
    
    enum ErrorMock: Error {
        case generic
    }

    var sut: SignInPresenter!
    
    var successFlag = false
    var loading: Bool?
    var error: SignIn.ViewModel.SignInError?

    override func setUp() {
        super.setUp()
        sut = SignInPresenter(viewController: self)
    }
    
    override func tearDown() {
        sut = nil
        error = nil
        super.tearDown()
    }
    
    func testDidFetchSuccessLogin() {
        sut.didFetchSuccessLogin()
        XCTAssertTrue(successFlag)
    }
    
    func testPresentLoading() {
        sut.presentLoading(true)
        XCTAssertNotNil(loading)
    }
    
    func testDidFetchServerError() {
        sut.didFetchServerError(SignIn.Errors.ServerError(error: ErrorMock.generic))
        XCTAssertNotNil(error)
    }
    
    func testDidFetchInputError_email() {
        sut.didFetchInputError(.emailEmpty)
        XCTAssertNotNil(error)
    }
    
    func testDidFetchInputError_password() {
        sut.didFetchInputError(.passwordEmpty)
        XCTAssertNotNil(error)
    }
}

extension SignInPresenter_Tests: SignInDisplayLogic {
    
    func displaySuccessfulLogin() {
        successFlag = true
    }
    
    func displayServerError(_ viewModel: SignIn.ViewModel.SignInError) {
        error = viewModel
    }
    
    func displayLoading(_ loading: Bool) {
        self.loading = loading
    }
    
    func displayEmailError(_ viewModel: SignIn.ViewModel.SignInError) {
        error = viewModel
    }
    
    func displaypasswordError(_ viewModel: SignIn.ViewModel.SignInError) {
        error = viewModel
    }
}
