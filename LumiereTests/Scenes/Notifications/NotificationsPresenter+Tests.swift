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
        XCTAssertNil(upcomingNotifications)
        sut.presentNotifications(Notifications.Info.Model.AllNotifications.stub)
        let expectedResult = Notifications.Info.ViewModel.UpcomingNotifications(notifications: [Notifications.Info.ViewModel.Notification(notificationText: "Deseja permitir conexão?", image: "image", name: "Usuario Teste 1", ocupation: "Artista", email: NSAttributedString(string: "user_test1@hotmail.com",
                                                                                                                                                                                                                                                                                  attributes: [NSAttributedString.Key.font: Notifications
                                                                                                                                                                                                                                                                                      .Constants
                                                                                                                                                                                                                                                                                      .Fonts
                                                                                                                                                                                                                                                                                      .emailLbl,
                                                                                                                                                                                                                                                                                               NSAttributedString.Key.foregroundColor:
                                                                                                                                                                                                                                                                                                  Notifications.Constants.Colors.emailLbl,
                                                                                                                                                                                                                                                                                               NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]), selectable: true),
                                                                                                Notifications.Info.ViewModel.Notification(notificationText: "Usuario Teste 2 te convidou para este projeto, deseja participar?", image: "image", name: "Projeto Teste 2", ocupation: .empty, email: .empty, selectable: true),
                                                                                                Notifications.Info.ViewModel.Notification(notificationText: "Solicitou participar do projeto Projeto Teste 3, deseja aceitá-lo?", image: "image", name: "Usuario Teste 3", ocupation: "Artista", email: NSAttributedString(string: "user_test3@hotmail.com",
                                                                                                                                                                                                                                                                                                                            attributes: [NSAttributedString.Key.font: Notifications
                                                                                                                                                                                                                                                                                                                                .Constants
                                                                                                                                                                                                                                                                                                                                .Fonts
                                                                                                                                                                                                                                                                                                                                .emailLbl,
                                                                                                                                                                                                                                                                                                                                         NSAttributedString.Key.foregroundColor:
                                                                                                                                                                                                                                                                                                                                            Notifications.Constants.Colors.emailLbl,
                                                                                                                                                                                                                                                                                                                                         NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]),
                                                                                                                                                                                                                                                                                                                            selectable: true)])
        XCTAssertEqual(expectedResult, upcomingNotifications)
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
    
    func testPresentAnsweredProjectInviteNotification_Accept() {
        XCTAssertNil(notificationAnswer)
        sut.presentAnsweredProjectInviteNotification(index: 0, answer: .accepted)
        let expectedResult = Notifications.Info.ViewModel.NotificationAnswer(index: 0, text: "Você agora faz parte deste projeto")
        XCTAssertEqual(expectedResult, notificationAnswer)
    }
    
    func testPresentAnsweredProjectInviteNotifications_Refuse() {
        XCTAssertNil(notificationAnswer)
        sut.presentAnsweredProjectInviteNotification(index: 0, answer: .refused)
        let expectedResult = Notifications.Info.ViewModel.NotificationAnswer(index: 0, text: "Você recusou o convite para este projeto")
        XCTAssertEqual(expectedResult, notificationAnswer)
    }
    
    func testPresentAnsweredProjectParticipationRequestNotification_Accepted() {
        XCTAssertNil(notificationAnswer)
        sut.presentAnsweredProjectParticipationRequest(index: 0, answer: .accepted)
        let expectedResult = Notifications.Info.ViewModel.NotificationAnswer(index: 0, text: "agora faz parte do seu projeto")
        XCTAssertEqual(expectedResult, notificationAnswer)
    }
    
    func testPresentAnsweredProjectParticipationRequestNotification_Refused() {
        XCTAssertNil(notificationAnswer)
        sut.presentAnsweredProjectParticipationRequest(index: 0, answer: .refused)
        let expectedResult = Notifications.Info.ViewModel.NotificationAnswer(index: 0, text: "foi recusado no seu projeto")
        XCTAssertEqual(expectedResult, notificationAnswer)
    }
    
    func testDidFetchProjectData() {
        XCTAssertFalse(displayProjectDetailsFlag)
        sut.didFetchProjectData()
        XCTAssertTrue(displayProjectDetailsFlag)
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
