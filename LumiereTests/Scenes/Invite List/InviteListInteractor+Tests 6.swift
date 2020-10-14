//
//  InviteListInteractor+Tests.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 28/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import XCTest
@testable import Lumiere

class InviteListInteractor_Tests: XCTestCase {

    var sut: InviteListInteractor!
    var workerMock: InviteListWorkerProtocol!
    
    var selectedUsers: [InviteList.Info.Model.User] = .empty
    var connections: InviteList.Info.Model.Connections?
    var presentLoadingFlag = false
    
    override func setUp() {
        super.setUp()
        workerMock = InviteListWorkerMock()
        sut = InviteListInteractor(worker: workerMock, presenter: self)
        sut.delegate = self
    }
    
    override func tearDown() {
        workerMock = nil
        sut = nil
        selectedUsers = .empty
        connections = nil
        presentLoadingFlag = false
        super.tearDown()
    }
    
    func testFetchConnections() {
        XCTAssertNil(connections)
        sut.fetchConnections(InviteList.Request.FetchConnections())
        let expectedResult = InviteList.Info.Model.Connections(users: [InviteList.Info.Model.User(id: "idUser1", image: "image", name: "Usuario Teste 1", email: "user_test1@hotmail.com", ocupation: "Artista", inviting: false), InviteList.Info.Model.User(id: "idUser2", image: "image", name: "Usuario Teste 2", email: "user_test2@hotmail.com", ocupation: "Artista", inviting: false)])
        XCTAssertEqual(expectedResult, connections)
    }
    
    func testSelectUser_Select() {
        XCTAssertEqual(selectedUsers.count, 0)
        sut.connections = InviteList.Info.Model.Connections.stub
        sut.fetchSelectUser(InviteList.Request.SelectUser(index: 0))
        let expectedResult = [InviteList.Info.Model.User(id: "idUser1", image: "image", name: "Usuario Teste 1", email: "user_test1@hotmail.com", ocupation: "Artista", inviting: false)]
        XCTAssertEqual(expectedResult, selectedUsers)
    }
    
    func testSelectUser_Unselect() {
        selectedUsers.append(InviteList.Info.Model.User(id: "idUser1", image: "image", name: "Usuario Teste 1", email: "user_test1@hotmail.com", ocupation: "Artista", inviting: false))
        XCTAssertEqual(selectedUsers.count, 1)
        sut.connections = InviteList.Info.Model.Connections(users: [InviteList.Info.Model.User(id: "idUser1", image: "image", name: "Usuario Teste 1", email: "user_test1@hotmail.com", ocupation: "Artista", inviting: true), InviteList.Info.Model.User(id: "idUser2", image: "image", name: "Usuario Teste 2", email: "user_test2@hotmail.com", ocupation: "Artista", inviting: false)])
        sut.fetchSelectUser(InviteList.Request.SelectUser(index: 0))
        XCTAssertEqual(selectedUsers.count, 0)
    }
    
    func testFetchSearch() {
        sut.connections = InviteList.Info.Model.Connections.stub
        XCTAssertNil(connections)
        sut.fetchSearch(InviteList.Request.Search(preffix: "Usuario Teste 1"))
        XCTAssertEqual(connections?.users.count, 1)
    }
}

extension InviteListInteractor_Tests: InviteListDelegate {
    
    func didSelectUser(_ user: InviteList.Info.Model.User) {
        self.selectedUsers.append(user)
    }
    
    func didUnselectUser(_ userId: String) {
        self.selectedUsers.removeAll(where: {$0.id == userId})
    }
}

extension InviteListInteractor_Tests: InviteListPresentationLogic {
    
    func presentConnections(_ response: InviteList.Info.Model.Connections) {
        self.connections = response
    }
    
    func presentLoading(_ loading: Bool) {
        self.presentLoadingFlag = true
    }
}
