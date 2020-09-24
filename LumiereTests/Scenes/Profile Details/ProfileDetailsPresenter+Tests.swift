//
//  ProfileDetailsPresenter+Tests.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 02/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import XCTest
@testable import Lumiere

class ProfileDetailsPresenter_Tests: XCTestCase {

    var sut: ProfileDetailsPresenter!
    
    var userViewModel: ProfileDetails.Info.ViewModel.User!
    var error: String!
    var newConnectionType: ProfileDetails.Info.ViewModel.NewConnectionType!
    var displayAllConnectionsFlag = false
    var displayEndRequestFlag = false
    var displayInterfaceForLoggedFlag = false
    var displayLoadingFlag = false
    var displaySignOutFlag = false
    var interactionConfirmation: ProfileDetails.Info.ViewModel.InteractionConfirmation!
    var displayProjectDetailsFlag = false
    
    override func setUp() {
        super.setUp()
        sut = ProfileDetailsPresenter(viewController: self)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        userViewModel = nil
        error = nil
        newConnectionType = nil
        displayAllConnectionsFlag = false
        displayEndRequestFlag = false
        displayInterfaceForLoggedFlag = false
        displayLoadingFlag = false
        displaySignOutFlag = false
        interactionConfirmation = nil
        displayProjectDetailsFlag = false
    }
    
    func testPresentUserInfo() {
        XCTAssertNil(userViewModel)
        sut.presentUserInfo(ProfileDetails.Info.Model.User.stub)
        let expectedResult = ProfileDetails.Info.ViewModel.User.stub
        XCTAssertEqual(expectedResult, userViewModel)
    }
    
    func testPresentError() {
        XCTAssertNil(error)
        sut.presentError(ProfileDetails.Errors.ProfileDetailsError(description: "Error"))
        XCTAssertNotNil(error)
    }
    
    func testPresentNewInteractionIcon() {
        XCTAssertNil(newConnectionType)
        sut.presentNewInteractionIcon(ProfileDetails.Info.Model.NewConnectionType(connectionType: .contact))
        let expectedResult = ProfileDetails.Info.ViewModel.NewConnectionType(image: ProfileDetails.Constants.Images.isConnection)
        XCTAssertEqual(expectedResult, newConnectionType)
    }
    
    func testPresentAllConnections() {
        XCTAssertFalse(displayAllConnectionsFlag)
        sut.presentAllConnections()
        XCTAssertTrue(displayAllConnectionsFlag)
    }
    
    func testDidEndRequest() {
        XCTAssertFalse(displayEndRequestFlag)
        sut.didEndRequest()
        XCTAssertTrue(displayEndRequestFlag)
    }
    
    func testPresentInterfaceForLogged() {
        XCTAssertFalse(displayInterfaceForLoggedFlag)
        sut.presentInterfaceForLogged()
        XCTAssertTrue(displayInterfaceForLoggedFlag)
    }
    
    func testPresentLoading() {
        XCTAssertFalse(displayLoadingFlag)
        sut.presentLoading(true)
        XCTAssertTrue(displayLoadingFlag)
    }
    
    func testDidSignOut() {
        XCTAssertFalse(displaySignOutFlag)
        sut.didSignOut()
        XCTAssertTrue(displaySignOutFlag)
    }
    
    func testPresentConfirmationAlert() {
        XCTAssertNil(interactionConfirmation)
        sut.presentConfirmationAlert(ProfileDetails.Info.Model.IneractionConfirmation(connectionType: .contact))
        let expectedResult = ProfileDetails.Info.ViewModel.InteractionConfirmation(text: "Tem certeza que deseja remover esta conexão?")
        XCTAssertEqual(expectedResult, interactionConfirmation)
    }
    
    func testPresentProjectDetails() {
        XCTAssertFalse(displayProjectDetailsFlag)
        sut.presentProjectDetails()
        XCTAssertTrue(displayProjectDetailsFlag)
    }
}

extension ProfileDetailsPresenter_Tests: ProfileDetailsDisplayLogic {
    
    func displayUserInfo(_ viewModel: ProfileDetails.Info.ViewModel.User) {
        self.userViewModel = viewModel
    }
    
    func displayError(_ viewModel: String) {
        self.error = viewModel
    }
    
    func displayNewConnectionType(_ viewModel: ProfileDetails.Info.ViewModel.NewConnectionType) {
        self.newConnectionType = viewModel
    }
    
    func displayAllConnections() {
        displayAllConnectionsFlag = true
    }
    
    func displayEndRequest() {
        displayEndRequestFlag = true
    }
    
    func displayInterfaceForLogged() {
        displayInterfaceForLoggedFlag = true
    }
    
    func displayLoading(_ loading: Bool) {
        displayLoadingFlag = true
    }
    
    func displaySignOut() {
        displaySignOutFlag = true
    }
    
    func displayConfirmation(_ viewModel: ProfileDetails.Info.ViewModel.InteractionConfirmation) {
        self.interactionConfirmation = viewModel
    }
    
    func displayProjectDetails() {
        displayProjectDetailsFlag = true
    }
}
