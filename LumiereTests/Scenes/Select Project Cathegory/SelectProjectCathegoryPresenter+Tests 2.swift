//
//  SelectProjectCathegoryPresenter+Tests.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 27/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import XCTest
@testable import Lumiere

class SelectProjectCathegoryPresenter_Tests: XCTestCase {

    var sut: SelectProjectCathegoryPresenter!
    
    var interestCathegories: SelectProjectCathegory.Info.Model.InterestCathegories?
    var displayProjectProgressFlag = false
    var error: SelectProjectCathegory.Info.Errors.SelectionError?
    
    override func setUp() {
        super.setUp()
        sut = SelectProjectCathegoryPresenter(viewController: self)
    }
    
    override func tearDown() {
        sut = nil
        interestCathegories = nil
        displayProjectProgressFlag = false
        error = nil
        super.tearDown()
    }
    
    func testPresentAllCathegories() {
        XCTAssertNil(interestCathegories)
        sut.presentAllCathegories(SelectProjectCathegory.Info.Model.InterestCathegories(cathegories: [SelectProjectCathegory.Info.Model.Cathegory(cathegory: .action, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .animation, selected: false)]))
        let expectedResult = SelectProjectCathegory.Info.Model.InterestCathegories(cathegories: [SelectProjectCathegory.Info.Model.Cathegory(cathegory: .action, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .animation, selected: false)])
        XCTAssertEqual(expectedResult, interestCathegories)
    }
    
    func testPresentProjectProgress() {
        XCTAssertFalse(displayProjectProgressFlag)
        sut.presentProjectProgress()
        XCTAssertTrue(displayProjectProgressFlag)
    }
    
    func testPresentError() {
        XCTAssertNil(error)
        sut.presentError(SelectProjectCathegory.Info.Errors.SelectionError(title: .empty, message: .empty))
        XCTAssertNotNil(error)
    }
}

extension SelectProjectCathegoryPresenter_Tests: SelectProjectCathegoryDisplayLogic {
    
    func displayAllCathegories(_ viewModel: SelectProjectCathegory.Info.Model.InterestCathegories) {
        self.interestCathegories = viewModel
    }
    
    func displayProjectProgress() {
        self.displayProjectProgressFlag = true
    }
    
    func displayError(_ viewModel: SelectProjectCathegory.Info.Errors.SelectionError) {
        self.error = viewModel
    }
}
