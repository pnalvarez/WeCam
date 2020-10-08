//
//  SignUpProvider+Tests.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 28/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
@testable import Lumiere
import XCTest

class SignUpProvider_Tests: XCTestCase {
    
    var sut: SignUpProvider!
    private var mock: FirebaseManagerProtocol! = FirebaseHelperMock()
    
    override func setUp() {
        super.setUp()
        sut = SignUpProvider(helper: mock)
    }

    override func tearDown() {
        sut = nil
        mock = nil
        super.tearDown()
    }
    
    func testFetchSignUp_Success() {
        var testable: String?
        sut.fetchSignUp(SignUp.Request.CreateUser(email: "usuarioteste@hotmail.com",
                                                  password: "1234")) { response in
                                                    switch response {
                                                    case .success(let data):
                                                        testable = data.uid
                                                        break
                                                    case .error(_):
                                                        break
                                                    }
                                                    XCTAssertNotNil(testable)
        }
    }
    
    func testFetchSignUp_Error() {
        var testable: String?
        sut.fetchSignUp(SignUp.Request.CreateUser(email: "usuarioteste@hotmail.com",
                                                  password: "ERROR")) { response in
                                                    switch response {
                                                    case .success(let data):
                                                        testable = data.uid
                                                        break
                                                    case .error(_):
                                                        break
                                                    }
                                                    XCTAssertNil(testable)
        }
    }
    
    func testSaveUserInfo_Success() {
        var testable = false
        sut.saveUserInfo(SignUp
            .Request
            .SignUpProviderRequest(userData: SignUp.Info.Model.UserData(image: nil,
                                                                        name: "Test",
                                                                        cellPhone: "12345678",
                                                                        email: "usuarioteste@hotmail.com",
                                                                        password: "123456",
                                                                        professionalArea: "Test",
                                                                        interestCathegories: .init(cathegories: [])),
                                   userId: "id")) { response in
                                    switch response {
                                    case .success:
                                        testable = true
                                        break
                                    default:
                                        break
                                    }
                                    
        }
        XCTAssertTrue(testable)
    }
    
    func testSaveUserInfo_Error() {
        var testable = false
        sut.saveUserInfo(SignUp
            .Request
            .SignUpProviderRequest(userData: SignUp.Info.Model.UserData(image: nil,
                                                                        name: "ERROR",
                                                                        cellPhone: "12345678",
                                                                        email: "usuarioteste@hotmail.com",
                                                                        password: "123456",
                                                                        professionalArea: "Test",
                                                                        interestCathegories: .init(cathegories: [])),
                                   userId: "id")) { response in
                                    switch response {
                                    case .error(_):
                                        testable = true
                                        break
                                    default:
                                        break
                                    }
                                    
        }
        XCTAssertTrue(testable)
    }
}
