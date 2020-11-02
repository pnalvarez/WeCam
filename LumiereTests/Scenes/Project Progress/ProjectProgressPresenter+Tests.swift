//
//  ProjectProgressPresenter.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 27/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import XCTest
@testable import Lumiere

class ProjectProgressPresenter_Tests: XCTestCase {

    var sut: ProjectProgressPresenter!
    
    var displayEditProjectDetailsFlag = false
    
    override func setUp() {
        super.setUp()
        sut = ProjectProgressPresenter(viewController: self)
    }
    
    override func tearDown() {
        sut = nil
        displayEditProjectDetailsFlag = false
        super.tearDown()
    }
    
    func testPresentEditProjectDetails() {
        XCTAssertFalse(displayEditProjectDetailsFlag)
        sut.presentEditProjectDetails()
        XCTAssertTrue(displayEditProjectDetailsFlag)
    }
}

extension ProjectProgressPresenter_Tests: ProjectProgressDisplayLogic {
    
    func displayFinishConfirmationDialog() {
        
    }
    
    
    func presentFinishConfirmationAlert() {
        
    }
    
    func displayEditProjectDetails() {
        self.displayEditProjectDetailsFlag = true
    }
}
