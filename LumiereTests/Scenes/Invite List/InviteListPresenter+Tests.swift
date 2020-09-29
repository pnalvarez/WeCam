//
//  InviteListPresenter+Tests.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 28/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import XCTest
@testable import Lumiere

class InviteListPresenter_Tests: XCTestCase {

    var sut: InviteListPresenter!
    
    var connections: InviteList.Info.ViewModel.Connections?
    var loadingFlag = false
    
    override func setUp() {
        super.setUp()
        sut = InviteListPresenter(viewController: self)
    }

    override func tearDown() {
        sut = nil
        connections = nil
        loadingFlag = false
        super.tearDown()
    }
    
    func testPresentConnections() {
        XCTAssertNil(connections)
        sut.presentConnections(InviteList.Info.Model.Connections.stub)
        let expectedResult = InviteList.Info.ViewModel.Connections(users: [InviteList.Info.ViewModel.User(name: "Usuario Teste 1", image: "image", email: "user_test1@hotmail.com", ocupation: "Artista", inviting: false), InviteList.Info.ViewModel.User(name: "Usuario Teste 2", image: "image", email: "user_test2@hotmail.com", ocupation: "Artista", inviting: false)])
        XCTAssertEqual(expectedResult, connections)
    }
    
    func testPresentLoading() {
        XCTAssertFalse(loadingFlag)
        sut.presentLoading(true)
        XCTAssertTrue(loadingFlag)
    }
}

extension InviteListPresenter_Tests: InviteListDisplayLogic {
    
    func displayConnections(_ viewModel: InviteList.Info.ViewModel.Connections) {
        self.connections = viewModel
    }
    
    func displayLoading(_ loading: Bool) {
        self.loadingFlag = true
    }
}
