//
//  NotificationsInteractor+Tests.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 24/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import XCTest
@testable import Lumiere

final class NotificationsInteractor_Tests: XCTestCase {
    
    var sut: NotificationsInteractor!
    var workerMock: NotificationsWorkerMock!
    var presentLoadingFlag = false
    var error: String?
    var allNotifications: Notifications.Info.Model.AllNotifications?
    var didFetchUserDataFlag = false
    var connectNotificationAnswer: Notifications.Info.Model.NotificationAnswer?
    var inviteNotificationAnswer: Notifications.Info.Model.NotificationAnswer?
    var projectParticiationNotificationsAnswer: Notifications.Info.Model.NotificationAnswer?
    var didFetchProjectDataFlag = false
    
    override func setUp() {
        super.setUp()
        workerMock = NotificationsWorkerMock()
        sut = NotificationsInteractor(presenter: self, worker: workerMock)
        sut.currentUser = Notifications.Info.Received.CurrentUser(userId: "idUser")
    }
    
    override func tearDown() {
        super.tearDown()
        workerMock = nil
        sut = nil
        presentLoadingFlag = false
        error = nil
        allNotifications = nil
        didFetchUserDataFlag = false
        connectNotificationAnswer = nil
        inviteNotificationAnswer = nil
        projectParticiationNotificationsAnswer = nil
        didFetchProjectDataFlag = false
    }
    
    func testFetchNotifications() {
        XCTAssertNil(allNotifications)
        sut.fetchNotifications()
        let expectedResult = Notifications.Info.Model.AllNotifications(notifications: [Notifications.Info.Model.ConnectNotification(userId: "idUser1", userName: "Usuario Teste 1", image: "image", ocupation: "Artista", email: "user_test1@hotmail.com"), Notifications.Info.Model.ConnectNotification(userId: "idUser2", userName: "Usuario Teste 2", image: "image", ocupation: "Artista", email: "user_test1@hotmail.com"), Notifications.Info.Model.ProjectInviteNotification(userId: "isUser1", userName: "Usuario Teste 1", image: "image", projectId: "idProj1", projectName: "Projeto Teste 1"), Notifications.Info.Model.ProjectInviteNotification(userId: "isUser2", userName: "Usuario Teste 2", image: "image", projectId: "idProj2", projectName: "Projeto Teste 2"), Notifications.Info.Model.ProjectParticipationRequestNotification(userId: "idUser1", userName: "Usuario Teste 1", image: "image", projectId: "idProj1", projectName: "Projeto Teste 1", email: "user_test1@hotmail.com", ocupation: "Artista"), Notifications.Info.Model.ProjectParticipationRequestNotification(userId: "idUser2", userName: "Usuario Teste 2", image: "image", projectId: "idProj2", projectName: "Projeto Teste 2", email: "user_test2@hotmail.com", ocupation: "Artista")])
        XCTAssertEqual(expectedResult.notifications.count, allNotifications?.notifications.count)
    }
    
    func testDidSelectNotification_ConnectNotification() {
        XCTAssertFalse(didFetchUserDataFlag)
        sut.allNotifications = Notifications.Info.Model.AllNotifications(notifications: [Notifications.Info.Model.ConnectNotification(userId: "idUser1", userName: "Usuario Teste 1", image: "image", ocupation: "Artista", email: "user_test1@hotmail.com"), Notifications.Info.Model.ConnectNotification(userId: "idUser2", userName: "Usuario Teste 2", image: "image", ocupation: "Artista", email: "user_test1@hotmail.com"), Notifications.Info.Model.ProjectInviteNotification(userId: "isUser1", userName: "Usuario Teste 1", image: "image", projectId: "idProj1", projectName: "Projeto Teste 1"), Notifications.Info.Model.ProjectInviteNotification(userId: "isUser2", userName: "Usuario Teste 2", image: "image", projectId: "idProj2", projectName: "Projeto Teste 2"), Notifications.Info.Model.ProjectParticipationRequestNotification(userId: "idUser1", userName: "Usuario Teste 1", image: "image", projectId: "idProj1", projectName: "Projeto Teste 1", email: "user_test1@hotmail.com", ocupation: "Artista"), Notifications.Info.Model.ProjectParticipationRequestNotification(userId: "idUser2", userName: "Usuario Teste 2", image: "image", projectId: "idProj2", projectName: "Projeto Teste 2", email: "user_test2@hotmail.com", ocupation: "Artista")])
        sut.didSelectNotification(Notifications.Request.SelectProfile(index: 0))
        XCTAssertTrue(didFetchUserDataFlag)
    }
    
    func testDidSelectNotification_ProjetInvite() {
        XCTAssertFalse(didFetchProjectDataFlag)
        sut.allNotifications = Notifications.Info.Model.AllNotifications(notifications: [Notifications.Info.Model.ConnectNotification(userId: "idUser1", userName: "Usuario Teste 1", image: "image", ocupation: "Artista", email: "user_test1@hotmail.com"), Notifications.Info.Model.ConnectNotification(userId: "idUser2", userName: "Usuario Teste 2", image: "image", ocupation: "Artista", email: "user_test1@hotmail.com"), Notifications.Info.Model.ProjectInviteNotification(userId: "isUser1", userName: "Usuario Teste 1", image: "image", projectId: "idProj1", projectName: "Projeto Teste 1"), Notifications.Info.Model.ProjectInviteNotification(userId: "isUser2", userName: "Usuario Teste 2", image: "image", projectId: "idProj2", projectName: "Projeto Teste 2"), Notifications.Info.Model.ProjectParticipationRequestNotification(userId: "idUser1", userName: "Usuario Teste 1", image: "image", projectId: "idProj1", projectName: "Projeto Teste 1", email: "user_test1@hotmail.com", ocupation: "Artista"), Notifications.Info.Model.ProjectParticipationRequestNotification(userId: "idUser2", userName: "Usuario Teste 2", image: "image", projectId: "idProj2", projectName: "Projeto Teste 2", email: "user_test2@hotmail.com", ocupation: "Artista")])
        sut.didSelectNotification(Notifications.Request.SelectProfile(index: 2))
        XCTAssertTrue(didFetchProjectDataFlag)
    }
    
    func testDidSelectNotification_ProjectParticipationRequest() {
        XCTAssertFalse(didFetchUserDataFlag)
        sut.allNotifications = Notifications.Info.Model.AllNotifications(notifications: [Notifications.Info.Model.ConnectNotification(userId: "idUser1", userName: "Usuario Teste 1", image: "image", ocupation: "Artista", email: "user_test1@hotmail.com"), Notifications.Info.Model.ConnectNotification(userId: "idUser2", userName: "Usuario Teste 2", image: "image", ocupation: "Artista", email: "user_test1@hotmail.com"), Notifications.Info.Model.ProjectInviteNotification(userId: "isUser1", userName: "Usuario Teste 1", image: "image", projectId: "idProj1", projectName: "Projeto Teste 1"), Notifications.Info.Model.ProjectInviteNotification(userId: "isUser2", userName: "Usuario Teste 2", image: "image", projectId: "idProj2", projectName: "Projeto Teste 2"), Notifications.Info.Model.ProjectParticipationRequestNotification(userId: "idUser1", userName: "Usuario Teste 1", image: "image", projectId: "idProj1", projectName: "Projeto Teste 1", email: "user_test1@hotmail.com", ocupation: "Artista"), Notifications.Info.Model.ProjectParticipationRequestNotification(userId: "idUser2", userName: "Usuario Teste 2", image: "image", projectId: "idProj2", projectName: "Projeto Teste 2", email: "user_test2@hotmail.com", ocupation: "Artista")])
        sut.didSelectNotification(Notifications.Request.SelectProfile(index: 4))
        XCTAssertTrue(didFetchUserDataFlag)
    }
    
    func testDidAcceptNotification_ConnectNotification() {
        XCTAssertNil(connectNotificationAnswer)
        sut.allNotifications = Notifications.Info.Model.AllNotifications(notifications: [Notifications.Info.Model.ConnectNotification(userId: "idUser1", userName: "Usuario Teste 1", image: "image", ocupation: "Artista", email: "user_test1@hotmail.com"), Notifications.Info.Model.ConnectNotification(userId: "idUser2", userName: "Usuario Teste 2", image: "image", ocupation: "Artista", email: "user_test1@hotmail.com"), Notifications.Info.Model.ProjectInviteNotification(userId: "isUser1", userName: "Usuario Teste 1", image: "image", projectId: "idProj1", projectName: "Projeto Teste 1"), Notifications.Info.Model.ProjectInviteNotification(userId: "isUser2", userName: "Usuario Teste 2", image: "image", projectId: "idProj2", projectName: "Projeto Teste 2"), Notifications.Info.Model.ProjectParticipationRequestNotification(userId: "idUser1", userName: "Usuario Teste 1", image: "image", projectId: "idProj1", projectName: "Projeto Teste 1", email: "user_test1@hotmail.com", ocupation: "Artista"), Notifications.Info.Model.ProjectParticipationRequestNotification(userId: "idUser2", userName: "Usuario Teste 2", image: "image", projectId: "idProj2", projectName: "Projeto Teste 2", email: "user_test2@hotmail.com", ocupation: "Artista")])
        sut.didAcceptNotification(Notifications.Request.NotificationAnswer(index: 0))
        let expectedResult = Notifications.Info.Model.NotificationAnswer.accepted
        XCTAssertEqual(sut.allNotifications?.notifications.count, 5)
        XCTAssertEqual(expectedResult, connectNotificationAnswer)
    }
    
    func testDidAcceptNotification_ProjectInvite() {
        XCTAssertNil(inviteNotificationAnswer)
        sut.allNotifications = Notifications.Info.Model.AllNotifications(notifications: [Notifications.Info.Model.ConnectNotification(userId: "idUser1", userName: "Usuario Teste 1", image: "image", ocupation: "Artista", email: "user_test1@hotmail.com"), Notifications.Info.Model.ConnectNotification(userId: "idUser2", userName: "Usuario Teste 2", image: "image", ocupation: "Artista", email: "user_test1@hotmail.com"), Notifications.Info.Model.ProjectInviteNotification(userId: "isUser1", userName: "Usuario Teste 1", image: "image", projectId: "idProj1", projectName: "Projeto Teste 1"), Notifications.Info.Model.ProjectInviteNotification(userId: "isUser2", userName: "Usuario Teste 2", image: "image", projectId: "idProj2", projectName: "Projeto Teste 2"), Notifications.Info.Model.ProjectParticipationRequestNotification(userId: "idUser1", userName: "Usuario Teste 1", image: "image", projectId: "idProj1", projectName: "Projeto Teste 1", email: "user_test1@hotmail.com", ocupation: "Artista"), Notifications.Info.Model.ProjectParticipationRequestNotification(userId: "idUser2", userName: "Usuario Teste 2", image: "image", projectId: "idProj2", projectName: "Projeto Teste 2", email: "user_test2@hotmail.com", ocupation: "Artista")])
        sut.didAcceptNotification(Notifications.Request.NotificationAnswer(index: 2))
        let expectedResult = Notifications.Info.Model.NotificationAnswer.accepted
        XCTAssertEqual(sut.allNotifications?.notifications.count, 5)
        XCTAssertEqual(expectedResult, inviteNotificationAnswer)
    }
    
    func testDidAcceptNotification_ProjectParticipationRequest() {
        XCTAssertNil(projectParticiationNotificationsAnswer)
        sut.allNotifications = Notifications.Info.Model.AllNotifications(notifications: [Notifications.Info.Model.ConnectNotification(userId: "idUser1", userName: "Usuario Teste 1", image: "image", ocupation: "Artista", email: "user_test1@hotmail.com"), Notifications.Info.Model.ConnectNotification(userId: "idUser2", userName: "Usuario Teste 2", image: "image", ocupation: "Artista", email: "user_test1@hotmail.com"), Notifications.Info.Model.ProjectInviteNotification(userId: "isUser1", userName: "Usuario Teste 1", image: "image", projectId: "idProj1", projectName: "Projeto Teste 1"), Notifications.Info.Model.ProjectInviteNotification(userId: "isUser2", userName: "Usuario Teste 2", image: "image", projectId: "idProj2", projectName: "Projeto Teste 2"), Notifications.Info.Model.ProjectParticipationRequestNotification(userId: "idUser1", userName: "Usuario Teste 1", image: "image", projectId: "idProj1", projectName: "Projeto Teste 1", email: "user_test1@hotmail.com", ocupation: "Artista"), Notifications.Info.Model.ProjectParticipationRequestNotification(userId: "idUser2", userName: "Usuario Teste 2", image: "image", projectId: "idProj2", projectName: "Projeto Teste 2", email: "user_test2@hotmail.com", ocupation: "Artista")])
        sut.didAcceptNotification(Notifications.Request.NotificationAnswer(index: 4))
        let expectedResult = Notifications.Info.Model.NotificationAnswer.accepted
        XCTAssertEqual(sut.allNotifications?.notifications.count, 5)
        XCTAssertEqual(expectedResult, projectParticiationNotificationsAnswer)
    }
    
    func testDidRefuseNotification_ProjectInvite() {
        XCTAssertNil(inviteNotificationAnswer)
        sut.allNotifications = Notifications.Info.Model.AllNotifications(notifications: [Notifications.Info.Model.ConnectNotification(userId: "idUser1", userName: "Usuario Teste 1", image: "image", ocupation: "Artista", email: "user_test1@hotmail.com"), Notifications.Info.Model.ConnectNotification(userId: "idUser2", userName: "Usuario Teste 2", image: "image", ocupation: "Artista", email: "user_test1@hotmail.com"), Notifications.Info.Model.ProjectInviteNotification(userId: "isUser1", userName: "Usuario Teste 1", image: "image", projectId: "idProj1", projectName: "Projeto Teste 1"), Notifications.Info.Model.ProjectInviteNotification(userId: "isUser2", userName: "Usuario Teste 2", image: "image", projectId: "idProj2", projectName: "Projeto Teste 2"), Notifications.Info.Model.ProjectParticipationRequestNotification(userId: "idUser1", userName: "Usuario Teste 1", image: "image", projectId: "idProj1", projectName: "Projeto Teste 1", email: "user_test1@hotmail.com", ocupation: "Artista"), Notifications.Info.Model.ProjectParticipationRequestNotification(userId: "idUser2", userName: "Usuario Teste 2", image: "image", projectId: "idProj2", projectName: "Projeto Teste 2", email: "user_test2@hotmail.com", ocupation: "Artista")])
        let expectedResult = Notifications.Info.Model.NotificationAnswer.refused
        sut.didRefuseNotification(Notifications.Request.NotificationAnswer(index: 2))
        XCTAssertEqual(sut.allNotifications?.notifications.count, 5)
        XCTAssertEqual(expectedResult, inviteNotificationAnswer)
    }
    
    func testDidRefuseNotification_ConnectNotification() {
        XCTAssertNil(connectNotificationAnswer)
        sut.allNotifications = Notifications.Info.Model.AllNotifications(notifications: [Notifications.Info.Model.ConnectNotification(userId: "idUser1", userName: "Usuario Teste 1", image: "image", ocupation: "Artista", email: "user_test1@hotmail.com"), Notifications.Info.Model.ConnectNotification(userId: "idUser2", userName: "Usuario Teste 2", image: "image", ocupation: "Artista", email: "user_test1@hotmail.com"), Notifications.Info.Model.ProjectInviteNotification(userId: "isUser1", userName: "Usuario Teste 1", image: "image", projectId: "idProj1", projectName: "Projeto Teste 1"), Notifications.Info.Model.ProjectInviteNotification(userId: "isUser2", userName: "Usuario Teste 2", image: "image", projectId: "idProj2", projectName: "Projeto Teste 2"), Notifications.Info.Model.ProjectParticipationRequestNotification(userId: "idUser1", userName: "Usuario Teste 1", image: "image", projectId: "idProj1", projectName: "Projeto Teste 1", email: "user_test1@hotmail.com", ocupation: "Artista"), Notifications.Info.Model.ProjectParticipationRequestNotification(userId: "idUser2", userName: "Usuario Teste 2", image: "image", projectId: "idProj2", projectName: "Projeto Teste 2", email: "user_test2@hotmail.com", ocupation: "Artista")])
        sut.didRefuseNotification(Notifications.Request.NotificationAnswer(index: 0))
        let expectedResult = Notifications.Info.Model.NotificationAnswer.refused
        XCTAssertEqual(sut.allNotifications?.notifications.count, 5)
        XCTAssertEqual(expectedResult, connectNotificationAnswer)
    }
    
    func testDidRefuseNotification_ProjectParticipationRequest() {
        XCTAssertNil(projectParticiationNotificationsAnswer)
        sut.allNotifications = Notifications.Info.Model.AllNotifications(notifications: [Notifications.Info.Model.ConnectNotification(userId: "idUser1", userName: "Usuario Teste 1", image: "image", ocupation: "Artista", email: "user_test1@hotmail.com"), Notifications.Info.Model.ConnectNotification(userId: "idUser2", userName: "Usuario Teste 2", image: "image", ocupation: "Artista", email: "user_test1@hotmail.com"), Notifications.Info.Model.ProjectInviteNotification(userId: "isUser1", userName: "Usuario Teste 1", image: "image", projectId: "idProj1", projectName: "Projeto Teste 1"), Notifications.Info.Model.ProjectInviteNotification(userId: "isUser2", userName: "Usuario Teste 2", image: "image", projectId: "idProj2", projectName: "Projeto Teste 2"), Notifications.Info.Model.ProjectParticipationRequestNotification(userId: "idUser1", userName: "Usuario Teste 1", image: "image", projectId: "idProj1", projectName: "Projeto Teste 1", email: "user_test1@hotmail.com", ocupation: "Artista"), Notifications.Info.Model.ProjectParticipationRequestNotification(userId: "idUser2", userName: "Usuario Teste 2", image: "image", projectId: "idProj2", projectName: "Projeto Teste 2", email: "user_test2@hotmail.com", ocupation: "Artista")])
        sut.didRefuseNotification(Notifications.Request.NotificationAnswer(index: 4))
        let expectedResult = Notifications.Info.Model.NotificationAnswer.refused
        XCTAssertEqual(sut.allNotifications?.notifications.count, 5)
        XCTAssertEqual(expectedResult, projectParticiationNotificationsAnswer)
    }
    
    func testFetchRefreshNotifications() {
        XCTAssertNil(allNotifications)
        sut.allNotifications = Notifications.Info.Model.AllNotifications(notifications: [Notifications.Info.Model.ConnectNotification(userId: "idUser1", userName: "Usuario Teste 1", image: "image", ocupation: "Artista", email: "user_test1@hotmail.com"), Notifications.Info.Model.ConnectNotification(userId: "idUser2", userName: "Usuario Teste 2", image: "image", ocupation: "Artista", email: "user_test1@hotmail.com"), Notifications.Info.Model.ProjectInviteNotification(userId: "isUser1", userName: "Usuario Teste 1", image: "image", projectId: "idProj1", projectName: "Projeto Teste 1"), Notifications.Info.Model.ProjectInviteNotification(userId: "isUser2", userName: "Usuario Teste 2", image: "image", projectId: "idProj2", projectName: "Projeto Teste 2"), Notifications.Info.Model.ProjectParticipationRequestNotification(userId: "idUser1", userName: "Usuario Teste 1", image: "image", projectId: "idProj1", projectName: "Projeto Teste 1", email: "user_test1@hotmail.com", ocupation: "Artista"), Notifications.Info.Model.ProjectParticipationRequestNotification(userId: "idUser2", userName: "Usuario Teste 2", image: "image", projectId: "idProj2", projectName: "Projeto Teste 2", email: "user_test2@hotmail.com", ocupation: "Artista")])
        let expectedResult = Notifications.Info.Model.AllNotifications(notifications: [Notifications.Info.Model.ConnectNotification(userId: "idUser1", userName: "Usuario Teste 1", image: "image", ocupation: "Artista", email: "user_test1@hotmail.com"), Notifications.Info.Model.ConnectNotification(userId: "idUser2", userName: "Usuario Teste 2", image: "image", ocupation: "Artista", email: "user_test1@hotmail.com"), Notifications.Info.Model.ProjectInviteNotification(userId: "isUser1", userName: "Usuario Teste 1", image: "image", projectId: "idProj1", projectName: "Projeto Teste 1"), Notifications.Info.Model.ProjectInviteNotification(userId: "isUser2", userName: "Usuario Teste 2", image: "image", projectId: "idProj2", projectName: "Projeto Teste 2"), Notifications.Info.Model.ProjectParticipationRequestNotification(userId: "idUser1", userName: "Usuario Teste 1", image: "image", projectId: "idProj1", projectName: "Projeto Teste 1", email: "user_test1@hotmail.com", ocupation: "Artista"), Notifications.Info.Model.ProjectParticipationRequestNotification(userId: "idUser2", userName: "Usuario Teste 2", image: "image", projectId: "idProj2", projectName: "Projeto Teste 2", email: "user_test2@hotmail.com", ocupation: "Artista")])
        sut.fetchRefreshNotifications(Notifications.Request.RefreshNotifications())
        XCTAssertEqual(expectedResult, allNotifications)
    }
}

extension NotificationsInteractor_Tests: NotificationsPresentationLogic {
    
    func presentLoading(_ loading: Bool) {
        presentLoadingFlag = loading
    }
    
    func presentError(_ response: String) {
        self.error = response
    }
    
    func presentNotifications(_ response: Notifications.Info.Model.AllNotifications) {
        self.allNotifications = response
    }
    
    func didFetchUserData() {
        didFetchUserDataFlag = true
    }
    
    func presentAnsweredConnectNotification(index: Int, answer: Notifications.Info.Model.NotificationAnswer) {
        self.connectNotificationAnswer = answer
    }
    
    func presentAnsweredProjectInviteNotification(index: Int, answer: Notifications.Info.Model.NotificationAnswer) {
        self.inviteNotificationAnswer = answer
    }
    
    func presentAnsweredProjectParticipationRequest(index: Int, answer: Notifications.Info.Model.NotificationAnswer) {
        projectParticiationNotificationsAnswer = answer
    }
    
    func didFetchProjectData() {
        didFetchProjectDataFlag = true
    }
}
