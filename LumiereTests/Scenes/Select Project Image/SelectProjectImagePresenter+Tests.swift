//
//  SelectProjectImagePresenter+Tests.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 26/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import XCTest
@testable import Lumiere

class SelectProjectImagePresenter_Tests: XCTestCase {

    var sut: SelectProjectImagePresenter!
    var displaySelectCathegoryFlag = false
    var error: String?
    
    override func setUp() {
        super.setUp()
        sut = SelectProjectImagePresenter(viewController: self)
    }
    
    override func tearDown() {
        sut = nil
        displaySelectCathegoryFlag = false
        error = nil
        super.tearDown()
    }
    
    func testPresentCathegories() {
        XCTAssertFalse(displaySelectCathegoryFlag)
        sut.presentCathegories()
        XCTAssertTrue(displaySelectCathegoryFlag)
    }
    
    func testPresentError() {
        XCTAssertNil(error)
        sut.presentError("Error")
        XCTAssertNotNil(error)
    }
}

extension SelectProjectImagePresenter_Tests: SelectProjectImageDisplayLogic {
    
    func displaySelectCathegory() {
        displaySelectCathegoryFlag = true
    }
    
    func displayError(_ viewModel: String) {
        self.error = viewModel
    }
}
