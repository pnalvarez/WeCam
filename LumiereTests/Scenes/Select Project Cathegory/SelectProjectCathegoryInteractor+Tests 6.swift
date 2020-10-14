//
//  SelectProjectCathegoryInteractor+Tests.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 26/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import XCTest
@testable import Lumiere

class SelectProjectCathegoryInteractor_Tests: XCTestCase {

    var sut: SelectProjectCathegoryInteractor!
    
    var interestCathegories: SelectProjectCathegory.Info.Model.InterestCathegories?
    var presentProjectProgressFlag = false
    var error: SelectProjectCathegory.Info.Errors.SelectionError?
    
    override func setUp() {
        super.setUp()
        sut = SelectProjectCathegoryInteractor(presenter: self)
    }
    
    override func tearDown() {
        sut = nil
        interestCathegories = nil
        presentProjectProgressFlag = false
        error = nil
        super.tearDown()
    }

    func testFetchAllCathegories() {
        XCTAssertNil(interestCathegories)
        sut.fetchAllCathegories(SelectProjectCathegory.Request.AllCathegories())
        let expectedResult = SelectProjectCathegory.Info.Model.InterestCathegories(cathegories: [SelectProjectCathegory.Info.Model.Cathegory(cathegory: .action, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .animation, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .adventure, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .comedy, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .drama, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .dance, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .documentary, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .fiction, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .war, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .musical, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .police, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .series, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .suspense, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .horror, selected: false)])
        XCTAssertEqual(expectedResult, interestCathegories)
    }
    
    func testSelectCathegory_SelectUnselectedCathegory() {
        sut.allCathegories = SelectProjectCathegory.Info.Model.InterestCathegories(cathegories: [SelectProjectCathegory.Info.Model.Cathegory(cathegory: .action, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .animation, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .adventure, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .comedy, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .drama, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .dance, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .documentary, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .fiction, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .war, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .musical, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .police, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .series, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .suspense, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .horror, selected: false)])
        XCTAssertNil(interestCathegories)
        sut.fetchSelectCathegory(SelectProjectCathegory.Request.SelectCathegory(cathegory: .action))
        let expectedResult = SelectProjectCathegory.Info.Model.InterestCathegories(cathegories: [SelectProjectCathegory.Info.Model.Cathegory(cathegory: .action, selected: true), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .animation, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .adventure, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .comedy, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .drama, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .dance, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .documentary, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .fiction, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .war, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .musical, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .police, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .series, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .suspense, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .horror, selected: false)])
        XCTAssertEqual(expectedResult, interestCathegories)
    }
    
    func testFetchSelectCathegory_SelectFirstCathegory() {
        sut.allCathegories = SelectProjectCathegory.Info.Model.InterestCathegories(cathegories: [SelectProjectCathegory.Info.Model.Cathegory(cathegory: .action, selected: true), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .animation, selected: true), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .adventure, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .comedy, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .drama, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .dance, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .documentary, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .fiction, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .war, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .musical, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .police, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .series, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .suspense, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .horror, selected: false)])
        sut.selectedCathegories = SelectProjectCathegory.Info.Model.SelectedCathegories(firstCathegory: .action, secondCathegory: .animation)
        XCTAssertNil(interestCathegories)
        XCTAssertNotNil(sut.selectedCathegories?.firstCathegory)
        sut.fetchSelectCathegory(SelectProjectCathegory.Request.SelectCathegory(cathegory: .action))
        let expectedResult = SelectProjectCathegory.Info.Model.InterestCathegories(cathegories: [SelectProjectCathegory.Info.Model.Cathegory(cathegory: .action, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .animation, selected: true), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .adventure, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .comedy, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .drama, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .dance, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .documentary, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .fiction, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .war, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .musical, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .police, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .series, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .suspense, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .horror, selected: false)])
        XCTAssertEqual(expectedResult, interestCathegories)
        XCTAssertNil(sut.selectedCathegories?.firstCathegory)
    }
    
    func testFetchSelectCathegory_SelectSecondCathegory() {
        sut.allCathegories = SelectProjectCathegory.Info.Model.InterestCathegories(cathegories: [SelectProjectCathegory.Info.Model.Cathegory(cathegory: .action, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .animation, selected: true), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .adventure, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .comedy, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .drama, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .dance, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .documentary, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .fiction, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .war, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .musical, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .police, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .series, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .suspense, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .horror, selected: false)])
        sut.selectedCathegories = SelectProjectCathegory.Info.Model.SelectedCathegories(firstCathegory: nil, secondCathegory: .animation)
        XCTAssertNil(interestCathegories)
        XCTAssertNotNil(sut.selectedCathegories?.secondCathegory)
        sut.fetchSelectCathegory(SelectProjectCathegory.Request.SelectCathegory(cathegory: .animation))
        let expectedResult = SelectProjectCathegory.Info.Model.InterestCathegories(cathegories: [SelectProjectCathegory.Info.Model.Cathegory(cathegory: .action, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .animation, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .adventure, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .comedy, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .drama, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .dance, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .documentary, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .fiction, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .war, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .musical, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .police, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .series, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .suspense, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .horror, selected: false)])
        XCTAssertEqual(expectedResult, interestCathegories)
        XCTAssertNil(sut.selectedCathegories?.secondCathegory)
    }
    
    func testFetchSelectCathegory_Error() {
        XCTAssertNil(error)
        sut.selectedCathegories = SelectProjectCathegory.Info.Model.SelectedCathegories(firstCathegory: .action, secondCathegory: .animation)
        sut.allCathegories = SelectProjectCathegory.Info.Model.InterestCathegories(cathegories: [SelectProjectCathegory.Info.Model.Cathegory(cathegory: .action, selected: true), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .animation, selected: true), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .adventure, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .comedy, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .drama, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .dance, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .documentary, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .fiction, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .war, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .musical, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .police, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .series, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .suspense, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .horror, selected: false)])
        sut.fetchSelectCathegory(SelectProjectCathegory.Request.SelectCathegory(cathegory: .adventure))
        XCTAssertNotNil(error)
    }
    
    func testFetchAdvance_Success() {
        XCTAssertFalse(presentProjectProgressFlag)
        sut.allCathegories = SelectProjectCathegory.Info.Model.InterestCathegories(cathegories: [SelectProjectCathegory.Info.Model.Cathegory(cathegory: .action, selected: true), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .animation, selected: true), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .adventure, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .comedy, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .drama, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .dance, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .documentary, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .fiction, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .war, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .musical, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .police, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .series, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .suspense, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .horror, selected: false)])
        sut.selectedCathegories = SelectProjectCathegory.Info.Model.SelectedCathegories(firstCathegory: .action, secondCathegory: .animation)
        sut.fetchAdvance(SelectProjectCathegory.Request.Advance())
        XCTAssertTrue(presentProjectProgressFlag)
    }
    
    func testFetchAdvance_Error() {
        XCTAssertNil(error)
        sut.allCathegories = SelectProjectCathegory.Info.Model.InterestCathegories(cathegories: [SelectProjectCathegory.Info.Model.Cathegory(cathegory: .action, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .animation, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .adventure, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .comedy, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .drama, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .dance, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .documentary, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .fiction, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .war, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .musical, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .police, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .series, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .suspense, selected: false), SelectProjectCathegory.Info.Model.Cathegory(cathegory: .horror, selected: false)])
        sut.selectedCathegories = SelectProjectCathegory.Info.Model.SelectedCathegories(firstCathegory: nil, secondCathegory: nil)
        sut.fetchAdvance(SelectProjectCathegory.Request.Advance())
        XCTAssertNotNil(error)
    }
}

extension SelectProjectCathegoryInteractor_Tests: SelectProjectCathegoryPresentationLogic {
    
    func presentAllCathegories(_ response: SelectProjectCathegory.Info.Model.InterestCathegories) {
        self.interestCathegories = response
    }
    
    func presentProjectProgress() {
        self.presentProjectProgressFlag = true
    }
    
    func presentError(_ response: SelectProjectCathegory.Info.Errors.SelectionError) {
        self.error = response
    }
}
