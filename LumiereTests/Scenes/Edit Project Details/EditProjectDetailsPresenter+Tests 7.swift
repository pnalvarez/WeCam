//
//  EditProjectDetailsPresenter+Tests.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 28/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import XCTest
@testable import Lumiere

class EditProjectDetailsPresenter_Tests: XCTestCase {

    var sut: EditProjectDetailsPresenter!
    
    var displayPublishedProjectDetailsFlag = false
    var invitedUsers: EditProjectDetails.Info.ViewModel.InvitedUsers?
    var loadingFlag = false
    var error: EditProjectDetails.Info.ViewModel.DisplayError?
    
    override func setUp() {
        super.setUp()
        sut = EditProjectDetailsPresenter(viewController: self)
    }

    override func tearDown() {
        sut = nil
        invitedUsers = nil
        loadingFlag = false
        error = nil
        super.tearDown()
    }
    
    func testPresentPublishedProjectDetails() {
        XCTAssertFalse(displayPublishedProjectDetailsFlag)
        sut.presentPublishedProjectDetails()
        XCTAssertTrue(displayPublishedProjectDetailsFlag)
    }
    
    func testPresentInvitedUsers() {
        XCTAssertNil(invitedUsers)
        sut.presentInvitedUsers(EditProjectDetails.Info.Model.InvitedUsers.stub)
        let expectedResult = EditProjectDetails.Info.ViewModel.InvitedUsers(users: [EditProjectDetails.Info.ViewModel.User(name: "Usuario Teste 1", ocupation: "Artista", image: "image"), EditProjectDetails.Info.ViewModel.User(name: "Usuario Teste 2", ocupation: "Artista", image: "image"), EditProjectDetails.Info.ViewModel.User(name: "Usuario Teste 3", ocupation: "Artista", image: "image")])
        XCTAssertEqual(expectedResult, invitedUsers)
    }
    
    func testPresentLoading() {
        XCTAssertFalse(loadingFlag)
        sut.presentLoading(true)
        XCTAssertTrue(loadingFlag)
    }
    
    func testPresentServerError() {
        XCTAssertNil(error)
        sut.presentServerError(EditProjectDetails.Info.Model.ServerError(error: FirebaseErrors.genericError))
        XCTAssertNotNil(error)
    }
    
    func testPresentLocalError() {
        XCTAssertNil(error)
        sut.presentLocalError(EditProjectDetails.Info.Model.LocalError(description: "Local Error"))
        XCTAssertNotNil(error)
    }
}

extension EditProjectDetailsPresenter_Tests: EditProjectDetailsDisplayLogic {
    
    func displayPublishedProjectDetails() {
        self.displayPublishedProjectDetailsFlag = true
    }
    
    func displayInvitedUsers(_ viewModel: EditProjectDetails.Info.ViewModel.InvitedUsers) {
        self.invitedUsers = viewModel
    }
    
    func displayLoading(_ loading: Bool) {
        self.loadingFlag = loading
    }
    
    func displayError(_ viewModel: EditProjectDetails.Info.ViewModel.DisplayError) {
        self.error = viewModel
    }
}
