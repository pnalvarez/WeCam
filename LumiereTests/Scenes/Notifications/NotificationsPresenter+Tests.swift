//
//  NotificationsPresenter+Tests.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 26/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import XCTest
@testable import Lumiere

class NotificationsPresenter_Tests: XCTestCase {

    var sut: NotificationsPresenter!
    var loading = false
    var error: Notifications.Info.ViewModel.NotificationError?
    var upcomingNotifications: Notifications.Info.ViewModel.UpcomingNotifications?
    var displaySelectedUserFlag = false
    var notificationAnswer: Notifications.Info.ViewModel.NotificationAnswer?
    var displayProjectDetailsFlag = false
    
    
    override func setUp() {
        super.setUp()
        sut = NotificationsPresenter(viewController: self)
    }

    override func tearDown() {
        sut = nil
        loading = false
        error = nil
        upcomingNotifications = nil
        displaySelectedUserFlag = false
        notificationAnswer = nil
        displayProjectDetailsFlag = false
        super.tearDown()
    }
    
    func testPresentLoading() {
        XCTAssertFalse(loading)
        sut.presentLoading(true)
        XCTAssertTrue(loading)
    }
    
    func testPresentError() {
        XCTAssertNil(error)
        sut.presentError("Error")
        let expectedResult = Notifications.Info.ViewModel.NotificationError(description: "Error")
        XCTAssertEqual(expectedResult, error)
    }
    
    func testPresentNotifications() {
        
    }
    
    func testDidFetchUserData() {
        XCTAssertFalse(displaySelectedUserFlag)
        sut.didFetchUserData()
        XCTAssertTrue(displaySelectedUserFlag)
    }
    
    func testPresentAnsweredConnectNotification_Accept() {
        XCTAssertNil(notificationAnswer)
        sut.presentAnsweredConnectNotification(index: 0, answer: Notifications.Info.Model.NotificationAnswer.accepted)
        let expectedResult = Notifications.Info.ViewModel.NotificationAnswer(index: 0, text: "Você agora está conectado a")
        XCTAssertEqual(expectedResult, notificationAnswer)
    }
    
    func testPresentAnsweredConnectNotification_Refuse() {
        XCTAssertNil(notificationAnswer)
        sut.presentAnsweredConnectNotification(index: 0, answer: .refused)
        let expectedResult = Notifications.Info.ViewModel.NotificationAnswer(index: 0, text: "Você recusou se conectar a")
        XCTAssertEqual(expectedResult, notificationAnswer)
    }
}

extension NotificationsPresenter_Tests: NotificationsDisplayLogic {
    
    func displayLoading(_ loading: Bool) {
        self.loading = loading
    }
    
    func displayError(_ viewModel: Notifications.Info.ViewModel.NotificationError) {
        self.error = viewModel
    }
    
    func displayNotifications(_ viewModel: Notifications.Info.ViewModel.UpcomingNotifications) {
        self.upcomingNotifications = viewModel
    }
    
    func displaySelectedUser() {
        displaySelectedUserFlag = true
    }
    
    func displayNotificationAnswer(_ viewModel: Notifications.Info.ViewModel.NotificationAnswer) {
        self.notificationAnswer = viewModel
    }
    
    func displayProjectDetails() {
        self.displayProjectDetailsFlag = true
    }
}
