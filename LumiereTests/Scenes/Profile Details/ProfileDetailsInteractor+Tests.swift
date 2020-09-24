//
//  ProfileDetailsInteractor+Tests.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 02/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import XCTest
@testable import Lumiere

class ProfileDetailsInteractor_Tests: XCTestCase {

    var sut: ProfileDetailsInteractor!
    var workerMock: ProfileDetailsWorkerMock!
    
    var userInfo: ProfileDetails.Info.Model.User!
    var error: ProfileDetails.Errors.ProfileDetailsError!
    var newConnectionType: ProfileDetails.Info.Model.NewConnectionType!
    var allConnectionsFlag = false
    var didEndRequestFlag = false
    var presentInterfaceForLoggedFlag = false
    var presentLoadingFlag = false
    var signOutFlag = false
    var confirmationAlert: ProfileDetails.Info.Model.IneractionConfirmation!
    var presentProjectDetailsFlag = false
    
    override func setUp() {
        super.setUp()
        workerMock = ProfileDetailsWorkerMock()
        sut = ProfileDetailsInteractor(presenter: self,
                                       worker: workerMock)
    }
    
    override func tearDown() {
        super.tearDown()
        workerMock = nil
        sut = nil
        newConnectionType = nil
        userInfo = nil
        error = nil
        allConnectionsFlag = false
        didEndRequestFlag = false
        presentLoadingFlag = false
        presentInterfaceForLoggedFlag = false
        signOutFlag = false
        confirmationAlert = nil
        presentLoadingFlag = false
    }
    
    func testFetchUserInfo_Success() {
        XCTAssertNil(userInfo)
        sut.fetchUserInfo(ProfileDetails.Request.UserData())
        let expectedResult = ProfileDetails
            .Info
            .Model
            .User(connectionType: .contact,
                  id: "idUser",
                  image: "image_url",
                  name: "Usuario Teste",
                  occupation: "Artist",
                  email: "user_test1@hotmail.com",
                  phoneNumber: "(20)9820-1189",
                  connectionsCount: "0",
                  progressingProjects: [ProfileDetails.Info.Model.Project(id: "idProj1", image: "image_url1"),
                                        ProfileDetails.Info.Model.Project(id: "idProj2", image: "image_url2"),
                                        ProfileDetails.Info.Model.Project(id: "idProj3", image: "image_url3")], finishedProjects: .empty)
        XCTAssertEqual(userInfo, expectedResult)
    }
    
    func testFetchUserInfo_Error() {
        XCTAssertNil(userInfo)
        sut.receivedUserData = ProfileDetails.Info.Received.User(userId: "ERROR")
        sut.fetchUserInfo(ProfileDetails.Request.UserData())
        XCTAssertNotNil(error)
    }
    
    func testFetchInteract_Nothing() {
        XCTAssertNil(newConnectionType)
        sut.userDataModel = ProfileDetails.Info.Model.User(connectionType: .nothing, id: .empty, image: .empty, name: .empty, occupation: .empty, email: .empty, phoneNumber: .empty, connectionsCount: .empty, progressingProjects: .empty, finishedProjects: .empty)
        sut.fetchInteract(ProfileDetails.Request.AddConnection())
        let expectedResult = ProfileDetails.Info.Model.NewConnectionType(connectionType: .pending)
        XCTAssertEqual(newConnectionType, expectedResult)
    }
    
    func testFetchInteract_Other() {
        XCTAssertNil(confirmationAlert)
        sut.userDataModel = ProfileDetails.Info.Model.User(connectionType: .pending, id: .empty, image: .empty, name: .empty, occupation: .empty, email: .empty, phoneNumber: .empty, connectionsCount: .empty, progressingProjects: .empty, finishedProjects: .empty)
        sut.fetchInteract(ProfileDetails.Request.AddConnection())
        let expectedResult = ProfileDetails.Info.Model.IneractionConfirmation(connectionType: .pending)
        XCTAssertEqual(expectedResult, confirmationAlert)
    }
    
    func testFetchAllConnections() {
        XCTAssertFalse(allConnectionsFlag)
        sut.fetchAllConnections(ProfileDetails.Request.AllConnections())
        XCTAssertTrue(allConnectionsFlag)
    }
    
    func testFetchConfirmInteraction_RemoveConnectionRequest_Success() {
        sut.userDataModel = ProfileDetails.Info.Model.User(connectionType: .pending, id: .empty, image: .empty, name: .empty, occupation: .empty, email: .empty, phoneNumber: .empty, connectionsCount: .empty, progressingProjects: .empty, finishedProjects: .empty)
        XCTAssertNil(newConnectionType)
       sut.fetchConfirmInteraction(ProfileDetails.Request.ConfirmInteraction())
        let expectedResult = ProfileDetails.Info.Model.NewConnectionType(connectionType: .nothing)
        XCTAssertEqual(expectedResult, newConnectionType)
    }
    
    func testFetchConfirmInteraction_RemoveConnectionRequest_Error() {
        sut.userDataModel = ProfileDetails.Info.Model.User(connectionType: .pending, id: "ERROR", image: .empty, name: .empty, occupation: .empty, email: .empty, phoneNumber: .empty, connectionsCount: .empty, progressingProjects: .empty, finishedProjects: .empty)
        XCTAssertNil(newConnectionType)
        sut.fetchConfirmInteraction(ProfileDetails.Request.ConfirmInteraction())
        XCTAssertNotNil(error)
    }
    
    func testFetchConfirmInteraction_AcceptConnection_Success() {
        sut.userDataModel = ProfileDetails.Info.Model.User(connectionType: .sent, id: .empty, image: .empty, name: .empty, occupation: .empty, email: .empty, phoneNumber: .empty, connectionsCount: .empty, progressingProjects: .empty, finishedProjects: .empty)
        XCTAssertNil(newConnectionType)
        sut.fetchConfirmInteraction(ProfileDetails.Request.ConfirmInteraction())
        let expectedResult = ProfileDetails.Info.Model.NewConnectionType(connectionType: .contact)
        XCTAssertEqual(expectedResult, newConnectionType)
    }
    
    func testFetchConfirmInteraction_AcceptConnection_Error() {
        sut.userDataModel = ProfileDetails.Info.Model.User(connectionType: .sent, id: "ERROR", image: .empty, name: .empty, occupation: .empty, email: .empty, phoneNumber: .empty, connectionsCount: .empty, progressingProjects: .empty, finishedProjects: .empty)
        XCTAssertNil(newConnectionType)
        sut.fetchConfirmInteraction(ProfileDetails.Request.ConfirmInteraction())
        XCTAssertNotNil(error)
    }
    
    func testFetchConfirmInteraction_RemoveConnection_Success() {
        
    }
}

extension ProfileDetailsInteractor_Tests: ProfileDetailsPresentationLogic {
    
    func presentUserInfo(_ response: ProfileDetails.Info.Model.User) {
        self.userInfo = response
    }
    
    func presentError(_ response: ProfileDetails.Errors.ProfileDetailsError) {
        self.error = response
    }
    
    func presentNewInteractionIcon(_ response: ProfileDetails.Info.Model.NewConnectionType) {
        self.newConnectionType = response
    }
    
    func presentAllConnections() {
        allConnectionsFlag = true
    }
    
    func didEndRequest() {
        didEndRequestFlag = true
    }
    
    func presentInterfaceForLogged() {
        presentInterfaceForLoggedFlag = true
    }
    
    func presentLoading(_ loading: Bool) {
        presentLoadingFlag = true
    }
    
    func didSignOut() {
        signOutFlag = true
    }
    
    func presentConfirmationAlert(_ response: ProfileDetails.Info.Model.IneractionConfirmation) {
        confirmationAlert = response
    }
    
    func presentProjectDetails() {
        presentProjectDetailsFlag = true
    }
}
