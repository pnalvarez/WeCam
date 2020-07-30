//
//  SignUpPresenter+Tests.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 28/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
@testable import Lumiere
import XCTest

class SignUpPresenter_Tests: XCTestCase {
    
    enum ErrorMock: Error {
        case generic
    }

    var sut: SignUpPresenter!
    
    var movieStyles: [MovieStyle]!
    var infoError: SignUp.Info.ViewModel.Error!
    var confirmationMatchFlag = false
    var loadingFlag = false
    var didSignUpUserFlag = false
    var serverError: SignUp.Info.ViewModel.Error!
    
    override func setUp() {
        super.setUp()
        sut = SignUpPresenter(viewController: self)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testDidFetchMovieStyles() {
        sut.didFetchMovieStyles([.action])
        let testable = movieStyles.count
        let expectedResult = 1
        XCTAssertEqual(testable, expectedResult)
    }
    
    func testPresentError_Generic() {
        sut.presentError(.emailInvalid)
        let testable = infoError
        XCTAssertNotNil(testable)
    }
    
    func testPresentError_ConfirmationMatch() {
        sut.presentError(.passwordMatch)
        let testable = confirmationMatchFlag
        XCTAssertTrue(testable)
    }
    
    func testPresentLoading() {
        sut.presentLoading(true)
        XCTAssertTrue(loadingFlag)
    }
    
    func testDidSignUpUser() {
        sut.didSignUpUser()
        XCTAssertTrue(didSignUpUserFlag)
    }
    
    func testDidFetchServerError() {
        sut.didFetchServerError(SignUp.Errors.ServerError.init(error: ErrorMock.generic))
        XCTAssertNotNil(serverError)
    }
    
    func testDidFetchGenericError() {
        sut.didFetchGenericError()
        XCTAssertNotNil(serverError)
    }
}

extension SignUpPresenter_Tests: SignUpDisplayLogic {
    
    func displayMovieStyles(_ viewModel: [MovieStyle]) {
        movieStyles = viewModel
    }
    
    func displayInformationError(_ viewModel: SignUp.Info.ViewModel.Error) {
        infoError = viewModel
    }
    
    func displayConfirmationMatchError() {
        confirmationMatchFlag = true
    }
    
    func displayLoading(_ loading: Bool) {
        loadingFlag = loading
    }
    
    func displayServerError(_ viewModel: SignUp.Info.ViewModel.Error) {
        serverError = viewModel
    }
    
    func displayDidSignUpUser() {
        didSignUpUserFlag = true
    }
}
