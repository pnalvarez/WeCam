//
//  SignUpInteractor+Tests.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 28/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
@testable import Lumiere
import XCTest

class SignUpInteractor_Tests: XCTestCase {
    
    var sut: SignUpInteractor!
    private var mock: SignUpProviderProtocol! = SignUpProviderMock()
    
    var styles: [MovieStyle]?
    var errors: SignUp.Errors.SignUpErrors?
    var loading: Bool?
    var signUpUserFlag: Bool = false
    var fetchServerErrorFlag = false
    var genericErrorFlag = false
   
    override func setUp() {
        super.setUp()
        sut = SignUpInteractor(viewController: SignUpController())
        sut.provider = mock
        sut.presenter = self
    }
    
    override func tearDown() {
        sut = nil
        mock = nil
        styles = nil
        errors = nil
        loading = nil
    }
    
    func testFetchMovieStyles() {
        sut.fetchMovieStyles()
        XCTAssertNotNil(styles)
    }
    
    func testDidSelectCathegory_NotSelected() {
        sut.didSelectCathegory(SignUp.Request.SelectedCathegory(cathegory: .action))
        let testable = sut.interestCathegories.cathegories.count
        let expectedResult = 1
        XCTAssertEqual(testable, expectedResult)
    }
    
    func testDidSelectCathegory_Selected() {
        sut.interestCathegories.cathegories.append(.action)
        sut.didSelectCathegory(SignUp.Request.SelectedCathegory(cathegory: .action))
        let testable = sut.interestCathegories.cathegories.count
        let expectedResult = 0
        XCTAssertEqual(testable, expectedResult)
    }
    
    func testFetchSignUp_Success() {
        sut.interestCathegories.cathegories.append(.action)
        sut.fetchSignUp(SignUp.Request.UserData(image: nil,
                                                name: "Test Test",
                                                email: "test@hotmail.com",
                                                password: "1234",
                                                confirmation: "1234",
                                                phoneNumber: "(20) 99892-0668",
                                                professionalArea: "Test"))
        XCTAssertTrue(signUpUserFlag)
    }
    
    func testFetchSignUp_NameEmptyError() {
        sut.interestCathegories.cathegories.append(.action)
        sut.fetchSignUp(SignUp.Request.UserData(image: nil,
                                                name: "",
                                                email: "error@hotmail.com",
                                                password: "1234",
                                                confirmation: "1234",
                                                phoneNumber: "12345678",
                                                professionalArea: "Test"))
        XCTAssertNotNil(errors)
    }
    
    func testFetchSignUp_NameInvalidError() {
        sut.interestCathegories.cathegories.append(.action)
        sut.fetchSignUp(SignUp.Request.UserData(image: nil,
                                                name: "TEST",
                                                email: "error@hotmail.com",
                                                password: "1234",
                                                confirmation: "1234",
                                                phoneNumber: "12345678",
                                                professionalArea: "Test"))
        XCTAssertNotNil(errors)
    }
    
    func testFetchSignUp_EmailInvalid() {
        sut.interestCathegories.cathegories.append(.action)
        sut.interestCathegories.cathegories.append(.action)
        sut.fetchSignUp(SignUp.Request.UserData(image: nil,
                                                name: "TEST Test",
                                                email: "error",
                                                password: "123456",
                                                confirmation: "123456",
                                                phoneNumber: "(20) 99892-0668",
                                                professionalArea: "Test"))
        XCTAssertNotNil(errors)
    }
    
    func testFetchSignUp_EmailEmpty() {
        sut.interestCathegories.cathegories.append(.action)
        sut.fetchSignUp(SignUp.Request.UserData(image: nil,
                                                name: "TEST Test",
                                                email: "",
                                                password: "123456",
                                                confirmation: "123456",
                                                phoneNumber: "(20) 99892-0668",
                                                professionalArea: "Test"))
        XCTAssertNotNil(errors)
    }
    
    func testFetchSignUp_passwordEmpty() {
        sut.interestCathegories.cathegories.append(.action)
        sut.fetchSignUp(SignUp.Request.UserData(image: nil,
                                                name: "TEST Test",
                                                email: "email@hotmail.com",
                                                password: "",
                                                confirmation: "",
                                                phoneNumber: "(20) 99892-0668",
                                                professionalArea: "Test"))
        XCTAssertNotNil(errors)
    }
    
    func testFetchSignUp_passwordDontMatch() {
        sut.interestCathegories.cathegories.append(.action)
        sut.fetchSignUp(SignUp.Request.UserData(image: nil,
                                                name: "TEST Test",
                                                email: "email@hotmail.com",
                                                password: "123456",
                                                confirmation: "123",
                                                phoneNumber: "(20) 99892-0668",
                                                professionalArea: "Test"))
        XCTAssertNotNil(errors)
    }
    
    func testFetchSignUp_ConfirmationEmpty() {
        sut.interestCathegories.cathegories.append(.action)
        sut.fetchSignUp(SignUp.Request.UserData(image: nil,
                                                name: "TEST Test",
                                                email: "email@hotmail.com",
                                                password: "123456",
                                                confirmation: "",
                                                phoneNumber: "(20) 99892-0668",
                                                professionalArea: "Test"))
        XCTAssertNotNil(errors)
    }
    
    func testFetchSignUp_PhoneNumberEmpty() {
        sut.interestCathegories.cathegories.append(.action)
        sut.fetchSignUp(SignUp.Request.UserData(image: nil,
                                                name: "TEST Test",
                                                email: "email@hotmail.com",
                                                password: "123456",
                                                confirmation: "123456",
                                                phoneNumber: "",
                                                professionalArea: "Test"))
        XCTAssertNotNil(errors)
    }
    
    func testFetchSignUp_PhoneNumberInvalid() {
        sut.interestCathegories.cathegories.append(.action)
        sut.fetchSignUp(SignUp.Request.UserData(image: nil,
                                                name: "TEST Test",
                                                email: "email@hotmail.com",
                                                password: "123456",
                                                confirmation: "123456",
                                                phoneNumber: "(20) 998920668",
                                                professionalArea: "Test"))
        XCTAssertNotNil(errors)
    }
    
    func testFetchSignUp_ProfessionalEmpty() {
        sut.interestCathegories.cathegories.append(.action)
        sut.fetchSignUp(SignUp.Request.UserData(image: nil,
                                                name: "TEST Test",
                                                email: "email@hotmail.com",
                                                password: "123456",
                                                confirmation: "123456",
                                                phoneNumber: "(20) 99892-0668",
                                                professionalArea: ""))
        XCTAssertNotNil(errors)
    }
    
    func testFetchSignUp_InterestCathegoriesEmpty() {
        sut.fetchSignUp(SignUp.Request.UserData(image: nil,
                                                name: "TEST Test",
                                                email: "email@hotmail.com",
                                                password: "123456",
                                                confirmation: "123456",
                                                phoneNumber: "(20) 99892-0668",
                                                professionalArea: "Test"))
        XCTAssertNotNil(errors)
    }
    
    func testFetchSignUp_ServerError() {
        sut.interestCathegories.cathegories.append(.action)
        sut.fetchSignUp(SignUp.Request.UserData(image: nil,
                                                name: "Test Test",
                                                email: "server_error@hotmail.com",
                                                password: "123456",
                                                confirmation: "123456",
                                                phoneNumber: "(20) 99892-0668",
                                                professionalArea: "Test"))
        XCTAssertTrue(fetchServerErrorFlag)
    }
    func testFetchSignUp_ServerGenericError() {
        sut.interestCathegories.cathegories.append(.action)
        sut.fetchSignUp(SignUp.Request.UserData(image: nil,
                                                name: "Test Test",
                                                email: "server_error2@hotmail.com",
                                                password: "123456",
                                                confirmation: "123456",
                                                phoneNumber: "(20) 99892-0668",
                                                professionalArea: "Test"))
        XCTAssertTrue(genericErrorFlag)
    }
}

extension SignUpInteractor_Tests: SignUpPresentationLogic {
    
    func didFetchMovieStyles(_ styles: [MovieStyle]) {
        self.styles = styles
    }
    
    func presentError(_ response: SignUp.Errors.SignUpErrors) {
        self.errors = response
    }
    
    func presentLoading(_ loading: Bool) {
        self.loading = loading
    }
    
    func didSignUpUser() {
        self.signUpUserFlag = true
    }
    
    func didFetchServerError(_ error: SignUp.Errors.ServerError) {
        self.fetchServerErrorFlag = true
    }
    
    func didFetchGenericError() {
        self.genericErrorFlag = true
    }
}
