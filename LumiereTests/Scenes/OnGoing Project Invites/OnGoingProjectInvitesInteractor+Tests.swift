//
//  OnGoingProjectInvitesInteractor+Tests.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 04/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import XCTest
@testable import Lumiere

class OnGoingProjectInvitesInteractor_Tests: XCTestCase {
    
    var sut: OnGoingProjectInvitesInteractor!
    var workerMock: OnGoingProjectInvitesWorkerMock!
    
    var users: OnGoingProjectInvites.Info.Model.UpcomingUsers?
    var project: OnGoingProjectInvites.Info.Model.Project?
    var alert: OnGoingProjectInvites.Info.Model.Alert?
    var hideModalAlertFlag = false
    var loadingFlag = false
    var presentProfileDetailsFlag = false
    var error: Error?
    var relationUpdate: OnGoingProjectInvites.Info.Model.RelationUpdate?
    
    override func setUp() {
        super.setUp()
        workerMock = OnGoingProjectInvitesWorkerMock()
        sut = OnGoingProjectInvitesInteractor(worker: workerMock, presenter: self)
    }
    
    override func tearDown() {
        workerMock = nil
        sut = nil
        users = nil
        project = nil
        alert = nil
        hideModalAlertFlag = false
        loadingFlag = false
        presentProfileDetailsFlag = false
        error = nil
        relationUpdate = nil
        super.tearDown()
    }
    
    func testFetchUsers_Success() {
        XCTAssertNil(error)
        XCTAssertNil(users)
        sut.fetchUsers(OnGoingProjectInvites.Request.FetchUsers())
        let expectedResult = OnGoingProjectInvites.Info.Model.UpcomingUsers(users: [OnGoingProjectInvites.Info.Model.User(userId: "idUser1", image: "image", name: "Usuário Teste 1", ocupation: "Artista", email: "user_test1@hotmail.com", relation: .nothing), OnGoingProjectInvites.Info.Model.User(userId: "idUser2", image: "image", name: "Usuário Teste 2", ocupation: "Artista", email: "user_test2@hotmail.com", relation: .nothing), OnGoingProjectInvites.Info.Model.User(userId: "idUser3", image: "image", name: "Usuário Teste 3", ocupation: "Artista", email: "user_test3@hotmail.com", relation: .nothing)])
        XCTAssertNil(error)
        XCTAssertEqual(expectedResult, users)
    }
    
    func testFetchProject() {
        
    }
}

extension OnGoingProjectInvitesInteractor_Tests: OnGoingProjectInvitesPresentationLogic {
    
    func presentUsers(_ response: OnGoingProjectInvites.Info.Model.UpcomingUsers) {
        self.users = response
    }
    
    func presentProject(_ response: OnGoingProjectInvites.Info.Model.Project) {
        self.project = response
    }
    
    func presentModalAlert(_ response: OnGoingProjectInvites.Info.Model.Alert) {
        self.alert = response
    }
    
    func hideModalAlert() {
        self.hideModalAlertFlag = true
    }
    
    func presentLoading(_ loading: Bool) {
        self.loadingFlag = loading
    }
    
    func presentProfileDetails() {
        self.presentProfileDetailsFlag = true
    }
    
    func presentError(_ response: Error) {
        self.error = response
    }
    
    func presentRelationUpdate(_ response: OnGoingProjectInvites.Info.Model.RelationUpdate) {
        self.relationUpdate = response
    }
}
