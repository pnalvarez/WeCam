//
//  EditProjectDetailsInteractor+Tests.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 27/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import XCTest
@testable import Lumiere

class EditProjectDetailsInteractor_Tests: XCTestCase {

    var sut: EditProjectDetailsInteractor!
    var workerMock: EditProjectDetailsWorkerProtocol!
    
    var presentPublishedProjectDetailsFlag = false
    var invitedUsers: EditProjectDetails.Info.Model.InvitedUsers?
    var loadingFlag = false
    var serverError: EditProjectDetails.Info.Model.ServerError?
    var localError: EditProjectDetails.Info.Model.LocalError?
    
    override func setUp() {
        super.setUp()
        workerMock = EditProjectDetailsWorkerMock()
        sut = EditProjectDetailsInteractor(worker: workerMock, presenter: self)
    }
    
    override func tearDown() {
        sut = nil
        presentPublishedProjectDetailsFlag = false
        invitedUsers = nil
        loadingFlag = false
        serverError = nil
        localError = nil
        super.tearDown()
    }
    
    func testFetchInvitations() {
        sut.invitedUsers = EditProjectDetails.Info.Model.InvitedUsers.stub
        XCTAssertNil(invitedUsers)
        sut.fetchInvitations(EditProjectDetails.Request.Invitations())
        let expectedResult = EditProjectDetails.Info.Model.InvitedUsers.stub
        XCTAssertEqual(expectedResult, invitedUsers)
    }
    
    func testFetchPublish_Success() {
        XCTAssertFalse(presentPublishedProjectDetailsFlag)
        sut.fetchPublish(EditProjectDetails.Request.Publish(title: "Projeto Teste", sinopsis: "Sinopse do Projeto Teste", needing: "Artistas"))
        XCTAssertTrue(presentPublishedProjectDetailsFlag)
    }
    
    func testFetchPublish_LocalError() {
        XCTAssertNil(localError)
        sut.fetchPublish(EditProjectDetails.Request.Publish(title: .empty, sinopsis: .empty, needing: .empty))
        XCTAssertNotNil(localError)
    }
    
    func testFetchPublish_ServerError() {
        XCTAssertNil(serverError)
        sut.fetchPublish(EditProjectDetails.Request.Publish(title: "ERROR", sinopsis: "Sinopsis", needing: .empty))
        XCTAssertNotNil(serverError)
    }
    
    func testFetchPublish_InviteUsers() {
        XCTAssertFalse(presentPublishedProjectDetailsFlag)
        sut.invitedUsers = EditProjectDetails.Info.Model.InvitedUsers.stub
        sut.fetchPublish(EditProjectDetails.Request.Publish(title: "Projeto Teste", sinopsis: "Sinopse do Projeto Teste", needing: .empty))
        XCTAssertTrue(presentPublishedProjectDetailsFlag)
    }
}

extension EditProjectDetailsInteractor_Tests: EditProjectDetailsPresentationLogic {
    
    func presentPublishedProjectDetails() {
        self.presentPublishedProjectDetailsFlag = true
    }
    
    func presentInvitedUsers(_ response: EditProjectDetails.Info.Model.InvitedUsers) {
        self.invitedUsers = response
    }
    
    func presentLoading(_ loading: Bool) {
        self.loadingFlag = loading
    }
    
    func presentServerError(_ response: EditProjectDetails.Info.Model.ServerError) {
        self.serverError = response
    }
    
    func presentLocalError(_ response: EditProjectDetails.Info.Model.LocalError) {
        self.localError = response
    }
}
