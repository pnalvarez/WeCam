//
//  SelectProjectImageInteractor+Tests.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 26/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import XCTest
@testable import Lumiere

class SelectProjectImageInteractor_Tests: XCTestCase {

    var sut: SelectProjectImageInteractor!
    var error: String?
    var presentCathegoriesFlag = false

    override func setUp() {
        super.setUp()
        sut = SelectProjectImageInteractor(presenter: self)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testDidSelectImage() {
        XCTAssertNil(sut.projectModel)
        sut.didSelectImage(SelectProjectImage.Request.SelectImage(image: UIImage()))
        XCTAssertNotNil(sut.projectModel)
    }
    
    func testFetchAdvance_Success() {
        XCTAssertFalse(presentCathegoriesFlag)
        sut.projectModel = SelectProjectImage.Info.Model.Project(image: Data())
        sut.fetchAdvance(SelectProjectImage.Request.Advance())
        XCTAssertTrue(presentCathegoriesFlag)
    }
    
    func testFetchAdvance_Error() {
        XCTAssertNil(error)
        sut.fetchAdvance(SelectProjectImage.Request.Advance())
        XCTAssertNotNil(error)
    }
}

extension SelectProjectImageInteractor_Tests: SelectProjectImagePresentationLogic {
    
    func presentCathegories() {
        presentCathegoriesFlag = true
    }
    
    func presentError(_ response: String) {
        self.error = response
    }
}
