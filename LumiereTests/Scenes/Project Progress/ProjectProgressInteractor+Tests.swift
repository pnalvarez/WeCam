//
//  SelectProjectProgressInteractor+Tests.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 27/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import XCTest
@testable import Lumiere

class ProjectProgressInteractor_Tests: XCTestCase {

    var sut: ProjectProgressInteractor!
    
    var presentEditProgressDetailsFlag = false
    
    override func setUp() {
        super.setUp()
        sut = ProjectProgressInteractor(presenter: self)
    }
    
    override func tearDown() {
        sut = nil
        presentEditProgressDetailsFlag = false
        super.tearDown()
    }
    
    func testFetchAvance() {
        XCTAssertFalse(presentEditProgressDetailsFlag)
        sut.fetchAdvance(ProjectProgress.Request.Advance(percentage: 0.8))
        XCTAssertTrue(presentEditProgressDetailsFlag)
    }
}

extension ProjectProgressInteractor_Tests: ProjectProgressPresentationLogic {
    
    func presentFinishConfirmationAlert() {
        
    }
    
    
    func presentEditProjectDetails() {
        self.presentEditProgressDetailsFlag = true
    }
}
