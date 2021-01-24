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
    
    var sut: ProjectInvitesInteractor!
    var workerMock: OnGoingProjectInvitesWorkerMock!
    
    var users: ProjectInvites.Info.Model.UpcomingUsers?
    var project: ProjectInvites.Info.Model.Project?
    var alert: ProjectInvites.Info.Model.Alert?
    var hideModalAlertFlag = false
    var loadingFlag = false
    var presentProfileDetailsFlag = false
    var error: Error?
    var relationUpdate: ProjectInvites.Info.Model.RelationUpdate?
    
    override func setUp() {
        super.setUp()
        workerMock = OnGoingProjectInvitesWorkerMock()
        sut = ProjectInvitesInteractor(worker: workerMock, presenter: self)
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
        sut.fetchUsers(ProjectInvites.Request.FetchUsers())
        let expectedResult = ProjectInvites.Info.Model.UpcomingUsers(users: [ProjectInvites.Info.Model.User(userId: "idUser1", image: "image", name: "Usuário Teste 1", ocupation: "Artista", email: "user_test1@hotmail.com", relation: .nothing), ProjectInvites.Info.Model.User(userId: "idUser2", image: "image", name: "Usuário Teste 2", ocupation: "Artista", email: "user_test2@hotmail.com", relation: .nothing), ProjectInvites.Info.Model.User(userId: "idUser3", image: "image", name: "Usuário Teste 3", ocupation: "Artista", email: "user_test3@hotmail.com", relation: .nothing)])
        XCTAssertNil(error)
        XCTAssertEqual(expectedResult, users)
    }
    
    func testFetchProject_Success() {
        XCTAssertNil(error)
        XCTAssertNil(project)
        sut.projectReceivedModel = ProjectInvites.Info.Received.Project(projectId: "idProj")
        sut.fetchProject(ProjectInvites.Request.FetchProject())
        let expectedResult = ProjectInvites.Info.Model.Project(projectId: "idProj", title: "Projeto Teste 1", image: "image", authorId: "idUser1")
        XCTAssertEqual(expectedResult, project)
    }
    
    func testFetchProject_Error() {
        XCTAssertNil(error)
        sut.projectReceivedModel = ProjectInvites.Info.Received.Project(projectId: "ERROR")
        sut.fetchProject(ProjectInvites.Request.FetchProject())
        XCTAssertNotNil(error)
    }
    
    func testFetchInteract_PresentModal() {
        XCTAssertNil(error)
        XCTAssertNil(alert)
        sut.users = ProjectInvites.Info.Model.UpcomingUsers.stub
        sut.fetchInteract(ProjectInvites.Request.Interaction(index: 0))
        let expectedResult = ProjectInvites.Info.Model.Alert(text: "Deseja remover este usuário do projeto?")
        XCTAssertNil(error)
        XCTAssertEqual(expectedResult, alert)
    }
    
    func testFetchInteract_SendInvite_Success() {
        XCTAssertNil(error)
        XCTAssertNil(relationUpdate)
        sut.users = ProjectInvites.Info.Model.UpcomingUsers.stub
        XCTAssertEqual(sut.users?.users[2].relation, .nothing)
        sut.fetchInteract(ProjectInvites.Request.Interaction(index: 2))
        let expectedRelationUpdate = ProjectInvites.Info.Model.RelationUpdate(index: 2, relation: .receivedRequest)
        let expectedRelation = ProjectInvites.Info.Model.Relation.receivedRequest
        XCTAssertNil(error)
        XCTAssertEqual(expectedRelationUpdate, relationUpdate)
        XCTAssertEqual(expectedRelation, sut.users?.users[2].relation)
    }
    
    func testFetchInteract_SendInvite_Error() {
        XCTAssertNil(error)
        XCTAssertNil(relationUpdate)
        sut.projectReceivedModel = ProjectInvites.Info.Received.Project(projectId: "ERROR")
        sut.projectModel = ProjectInvites.Info.Model.Project(projectId: "ERROR", title: "Projeto Teste 1", image: "image", authorId: "idUser1")
        sut.users = ProjectInvites.Info.Model.UpcomingUsers.stub
        XCTAssertEqual(sut.users?.users[2].relation, .nothing)
        sut.fetchInteract(ProjectInvites.Request.Interaction(index: 2))
        let expectedRelationUpdate = ProjectInvites.Info.Model.RelationUpdate(index: 2, relation: .nothing)
        let expectedRelation = ProjectInvites.Info.Model.Relation.nothing
        XCTAssertNotNil(error)
        XCTAssertEqual(expectedRelationUpdate, relationUpdate)
        XCTAssertEqual(expectedRelation, sut.users?.users[2].relation)
    }
    
    func testFetchConfirmInteraction_RemoveParticipant_Success() {
        XCTAssertNil(error)
        sut.projectModel = ProjectInvites.Info.Model.Project(projectId: "idProj1", title: "Projeto Teste 1", image: "image", authorId: "idUser1")
        sut.users = ProjectInvites.Info.Model.UpcomingUsers.stub
        sut.interactingUser = ProjectInvites.Info.Model.UpcomingUsers.stub.users[0]
        sut.fetchConfirmInteraction(ProjectInvites.Request.ConfirmInteraction())
        let expectedRelation = ProjectInvites.Info.Model.Relation.nothing
        XCTAssertNil(error)
        XCTAssertEqual(expectedRelation, sut.users?.users[0].relation)
    }
    
    func testFetchConfirmInteraction_RemoveParticipant_Error() {
        XCTAssertNil(error)
        sut.projectModel = ProjectInvites.Info.Model.Project(projectId: "ERROR", title: "Projeto Teste 1", image: "image", authorId: "idUser1")
        sut.users = ProjectInvites.Info.Model.UpcomingUsers.stub
        sut.interactingUser = ProjectInvites.Info.Model.UpcomingUsers.stub.users[0]
        sut.fetchConfirmInteraction(ProjectInvites.Request.ConfirmInteraction())
        XCTAssertNotNil(error)
    }
    
    func testFetchConfirmInteraction_RemoveInvite_Success() {
        XCTAssertNil(error)
        sut.projectModel = ProjectInvites.Info.Model.Project(projectId: "idProj1", title: "Projeto Teste 1", image: "image", authorId: "idUser1")
        sut.users = ProjectInvites.Info.Model.UpcomingUsers.stub
        sut.interactingUser = ProjectInvites.Info.Model.UpcomingUsers.stub.users[3]
        sut.fetchConfirmInteraction(ProjectInvites.Request.ConfirmInteraction())
        let expectedRelation = ProjectInvites.Info.Model.Relation.nothing
        XCTAssertNil(error)
        XCTAssertEqual(expectedRelation, sut.users?.users[3].relation)
    }
    
    func testFetchConfirmInteraction_RemoveInvite_Error() {
        XCTAssertNil(error)
        sut.projectModel = ProjectInvites.Info.Model.Project(projectId: "ERROR", title: "Projeto Teste 1", image: "image", authorId: "idUser1")
        sut.users = ProjectInvites.Info.Model.UpcomingUsers.stub
        sut.interactingUser = ProjectInvites.Info.Model.UpcomingUsers.stub.users[3]
        sut.fetchConfirmInteraction(ProjectInvites.Request.ConfirmInteraction())
        XCTAssertNotNil(error)
    }
    
    func testFetchConfirmInteraction_AcceptParticipant_Success() {
        XCTAssertNil(error)
        sut.projectModel = ProjectInvites.Info.Model.Project(projectId: "idProj1", title: "Projeto Teste 1", image: "image", authorId: "idUser1")
        sut.users = ProjectInvites.Info.Model.UpcomingUsers.stub
        sut.interactingUser = ProjectInvites.Info.Model.UpcomingUsers.stub.users[1]
        sut.fetchConfirmInteraction(ProjectInvites.Request.ConfirmInteraction())
        let expectedRelation = ProjectInvites.Info.Model.Relation.simpleParticipant
        XCTAssertNil(error)
        XCTAssertEqual(expectedRelation, sut.users?.users[1].relation)
    }
    
    func testFetchConfirmInteraction_AcceptParticipant_Error() {
        XCTAssertNil(error)
        sut.projectModel = ProjectInvites.Info.Model.Project(projectId: "ERROR", title: "Projeto Teste 1", image: "image", authorId: "idUser1")
        sut.users = ProjectInvites.Info.Model.UpcomingUsers.stub
        sut.interactingUser = ProjectInvites.Info.Model.UpcomingUsers.stub.users[1]
        sut.fetchConfirmInteraction(ProjectInvites.Request.ConfirmInteraction())
        XCTAssertNotNil(error)
    }
    
    func testRefuseInteraction_RefuseParticipant_Success() {
        XCTAssertNil(error)
        XCTAssertNil(relationUpdate)
        sut.projectModel = ProjectInvites.Info.Model.Project(projectId: "idProj1", title: "Projeto Teste 1", image: "image", authorId: "idUser1")
        sut.users = ProjectInvites.Info.Model.UpcomingUsers.stub
        sut.interactingUser = ProjectInvites.Info.Model.UpcomingUsers.stub.users[1]
        sut.fetchRefuseInteraction(ProjectInvites.Request.RefuseInteraction())
        let expectedResult = ProjectInvites.Info.Model.Relation.nothing
        XCTAssertNil(error)
        XCTAssertEqual(expectedResult, sut.users?.users[1].relation)
    }
    
    func testRefuseInteraction_RefuseParticipant_ERROR() {
        XCTAssertNil(error)
        XCTAssertNil(relationUpdate)
        sut.projectModel = ProjectInvites.Info.Model.Project(projectId: "ERROR", title: "Projeto Teste 1", image: "image", authorId: "idUser1")
        sut.users = ProjectInvites.Info.Model.UpcomingUsers.stub
        sut.interactingUser = ProjectInvites.Info.Model.UpcomingUsers.stub.users[1]
        sut.fetchRefuseInteraction(ProjectInvites.Request.RefuseInteraction())
        let expectedResult = ProjectInvites.Info.Model.Relation.sentRequest
        XCTAssertNotNil(error)
        XCTAssertEqual(expectedResult, sut.users?.users[1].relation)
    }
    
    func testFetchSearchUser() {
        XCTAssertNil(users)
        sut.filteredUsers = ProjectInvites.Info.Model.UpcomingUsers.stub
        sut.fetchSearchUser(ProjectInvites.Request.Search(preffix: "Usuário Teste 4"))
        let expectedResult = ProjectInvites.Info.Model.UpcomingUsers(users: [ProjectInvites.Info.Model.User(userId: "idUser4", image: "image", name: "Usuário Teste 4", ocupation: "Artista", email: "user_test4@hotmail.com", relation: .receivedRequest)])
        XCTAssertEqual(expectedResult, users)
    }
    
    func testDidSelectUser() {
        XCTAssertFalse(presentProfileDetailsFlag)
        sut.users = ProjectInvites.Info.Model.UpcomingUsers.stub
        sut.didSelectUser(ProjectInvites.Request.SelectUser(index: 0))
        XCTAssertTrue(presentProfileDetailsFlag)
    }
}

extension OnGoingProjectInvitesInteractor_Tests: ProjectInvitesPresentationLogic {
    
    func presentUsers(_ response: ProjectInvites.Info.Model.UpcomingUsers) {
        self.users = response
    }
    
    func presentProject(_ response: ProjectInvites.Info.Model.Project) {
        self.project = response
    }
    
    func presentModalAlert(_ response: ProjectInvites.Info.Model.Alert) {
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
    
    func presentRelationUpdate(_ response: ProjectInvites.Info.Model.RelationUpdate) {
        self.relationUpdate = response
    }
}
