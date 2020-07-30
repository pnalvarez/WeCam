//
//  SignInProvider+Tests.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 28/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
@testable import Lumiere
import XCTest

class SignInProvider_Tests: XCTestCase {

    var sut: SignInProvider!
    var mock: FirebaseAuthHelperProtocol!
    
    var successFlag = false
    var failureFlag = false
    
    override func setUp() {
        super.setUp()
        mock = FirebaseHelperMock()
        sut = SignInProvider(builder: mock)
    }

    override func tearDown() {
        sut = nil
        mock = nil
        super.tearDown()
    }
    
    func testFetchSignIn_Success() {
        sut.fetchSignIn(request: SignIn.Models.Request(email: "user@hotmail.com",
                                                       password: "123456")) { response in
                                                        switch response {
                                                        case .success:
                                                            self.successFlag = true
                                                            break
                                                        case .error(_):
                                                            break
                                                        }
        }
        XCTAssertTrue(successFlag)
    }
    
    func testFetchSignIn_Error() {
        sut.fetchSignIn(request: SignIn.Models.Request(email: "ERROR",
                                                       password: "123456")) { response in
                                                        switch response {
                                                        case .success:
                                                            break
                                                        case .error(_):
                                                            self.failureFlag = true
                                                            break
                                                        }
        }
        XCTAssertTrue(failureFlag)
    }
}
