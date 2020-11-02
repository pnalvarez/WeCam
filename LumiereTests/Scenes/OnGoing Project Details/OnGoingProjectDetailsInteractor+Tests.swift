//
//  OnGoingProjectDetailsInteractor+Tests.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 04/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import XCTest
@testable import Lumiere

class OnGoingProjectDetailsInteractor_Tests: XCTestCase {
    
    var sut: OnGoingProjectDetailsInteractor!
    var workerMock: OnGoingProjectDetailsWorkerMock!
    
    var projectDetails: OnGoingProjectDetails.Info.Model.Project?
    var projectRelation: OnGoingProjectDetails.Info.Model.RelationModel?
    var error: String?
    var loadingFlag = false
    var feedback: OnGoingProjectDetails.Info.Model.Feedback?
    var presentUserDetailsFlag = false
    var relation: OnGoingProjectDetails.Info.Model.RelationModel?
    var presentInteractionEffectivatedFlag = false
    var presentRefusedInteractionFlag = false
    var progress: OnGoingProjectDetails.Info.Model.Progress?
    var presentProjectDetailsFlag = false
    
    override func setUp() {
        super.setUp()
        workerMock = OnGoingProjectDetailsWorkerMock()
        sut = OnGoingProjectDetailsInteractor(worker: workerMock, presenter: self)
    }
    
    override func tearDown() {
        workerMock = nil
        sut = nil
        projectDetails = nil
        projectRelation = nil
        error = nil
        loadingFlag = false
        feedback = nil
        presentUserDetailsFlag = false
        relation = nil
        presentInteractionEffectivatedFlag = false
        presentRefusedInteractionFlag = false
        progress = nil
        presentProjectDetailsFlag = false
        super.tearDown()
    }
    
    func testFetchProjectDetails_Success_NotInvitedUsers() {
        XCTAssertNil(projectDetails)
        XCTAssertNil(error)
        sut.receivedData = OnGoingProjectDetails.Info.Received.Project(projectId: "idProj", notInvitedUsers: ["idUser"])
        sut.fetchProjectDetails(OnGoingProjectDetails.Request.FetchProject())
        let expectedResult = OnGoingProjectDetails.Info.Model.Project(id: "idProj", firstCathegory: "Ação", secondCathegory: "Aventura", image: "image", progress: 50, title: "Projeto Teste 1", sinopsis: "Sinopse do Projeto Teste 1", teamMembers: [OnGoingProjectDetails.Info.Model.TeamMember(id: "idUser1", name: "Usuário Teste 1", ocupation: "Artista", image: "image"), OnGoingProjectDetails.Info.Model.TeamMember(id: "idUser2", name: "Usuário Teste 1", ocupation: "Artista", image: "image")], needing: "Artistas")
        XCTAssertNotNil(error)
        XCTAssertEqual(expectedResult, projectDetails)
    }
    
    func testFetchProjectDetails_Success_AllUsersInvited() {
        XCTAssertNil(projectDetails)
        XCTAssertNil(error)
        sut.receivedData = OnGoingProjectDetails.Info.Received.Project(projectId: "idProj", notInvitedUsers: .empty)
        sut.fetchProjectDetails(OnGoingProjectDetails.Request.FetchProject())
        let expectedResult = OnGoingProjectDetails.Info.Model.Project(id: "idProj", firstCathegory: "Ação", secondCathegory: "Aventura", image: "image", progress: 50, title: "Projeto Teste 1", sinopsis: "Sinopse do Projeto Teste 1", teamMembers: [OnGoingProjectDetails.Info.Model.TeamMember(id: "idUser1", name: "Usuário Teste 1", ocupation: "Artista", image: "image"), OnGoingProjectDetails.Info.Model.TeamMember(id: "idUser2", name: "Usuário Teste 1", ocupation: "Artista", image: "image")], needing: "Artistas")
        XCTAssertNil(error)
        XCTAssertEqual(expectedResult, projectDetails)
    }
    
    func testFetchProjectDetails_ProjectError() {
        XCTAssertNil(error)
        sut.receivedData = OnGoingProjectDetails.Info.Received.Project(projectId: "ERROR", notInvitedUsers: .empty)
        sut.fetchProjectDetails(OnGoingProjectDetails.Request.FetchProject())
        XCTAssertNotNil(error)
    }
    
    func testDidSelectTeamMember() {
        XCTAssertFalse(presentUserDetailsFlag)
        sut.projectData = OnGoingProjectDetails.Info.Model.Project(id: "idUser", firstCathegory: "Ação", secondCathegory: "Aventura", image: "image", progress: 50, title: "Projeto Teste 1", sinopsis: "Sinopse do Projeto Teste 1", teamMembers: [OnGoingProjectDetails.Info.Model.TeamMember(id: "idUser", name: "Usuario Teste 1", ocupation: "Artista", image: "image")], needing: "Artistas")
        sut.didSelectTeamMember(OnGoingProjectDetails.Request.SelectedTeamMember(index: 0))
        XCTAssertTrue(presentUserDetailsFlag)
    }
    
    func testFetchProjectRelation_Success() {
        XCTAssertNil(error)
        XCTAssertNil(projectRelation)
        sut.receivedData = OnGoingProjectDetails.Info.Received.Project(projectId: "idProj", notInvitedUsers: .empty)
        sut.fetchProjectRelation(OnGoingProjectDetails.Request.ProjectRelation())
        let expectedResult = OnGoingProjectDetails.Info.Model.RelationModel(relation: .author)
        XCTAssertNil(error)
        XCTAssertEqual(expectedResult, projectRelation)
    }
    
    func testFetchProjectRelation_Error() {
        XCTAssertNil(error)
        sut.receivedData = OnGoingProjectDetails.Info.Received.Project(projectId: "ERROR", notInvitedUsers: .empty)
        sut.fetchProjectRelation(OnGoingProjectDetails.Request.ProjectRelation())
        XCTAssertNotNil(error)
    }
    
    func testFetchUpdateProjectImage_Success() {
        XCTAssertNil(feedback)
        sut.projectData = OnGoingProjectDetails.Info.Model.Project(id: "idProj", firstCathegory: "Ação", secondCathegory: "Aventura", image: "old image", progress: 50, title: "Projeto Teste", sinopsis: "Sinopse do Projeto Teste", teamMembers: .empty, needing: "Artistas")
        sut.receivedData = OnGoingProjectDetails.Info.Received.Project(projectId: "idProj", notInvitedUsers: .empty)
        sut.fetchUpdateProjectImage(OnGoingProjectDetails.Request.UpdateImage(image: (Constants.testImage?.jpegData(compressionQuality: 0.5))!))
        let expectedFeedback = OnGoingProjectDetails.Info.Model.Feedback(title: "Alteração realizada", message: "Imagem do projeto foi alterada com sucesso")
        let expectedProject = OnGoingProjectDetails.Info.Model.Project(id: "idProj", firstCathegory: "Ação", secondCathegory: "Aventura", image: "image", progress: 50, title: "Projeto Teste", sinopsis: "Sinopse do Projeto Teste", teamMembers: .empty, needing: "Artistas")
        XCTAssertEqual(expectedProject, projectDetails)
        XCTAssertEqual(expectedFeedback, feedback)
    }
    
    func testFetchUpdateProjectImage_Error() {
        XCTAssertNil(error)
        sut.projectData = OnGoingProjectDetails.Info.Model.Project(id: "ERROR", firstCathegory: "Ação", secondCathegory: "Aventura", image: "old image", progress: 50, title: "Projeto Teste", sinopsis: "Sinopse do Projeto Teste", teamMembers: .empty, needing: "Artistas")
        sut.receivedData = OnGoingProjectDetails.Info.Received.Project(projectId: "ERROR", notInvitedUsers: .empty)
        sut.fetchUpdateProjectImage(OnGoingProjectDetails.Request.UpdateImage(image: Data()))
        XCTAssertNotNil(error)
    }
    
    func testFetchUpdateProjectInfo_Success() {
        XCTAssertNil(error)
        sut.projectData = OnGoingProjectDetails.Info.Model.Project(id: "idProj", firstCathegory: "Ação", secondCathegory: "Aventura", image: "old image", progress: 50, title: "Projeto Teste", sinopsis: "Sinopse do Projeto Teste", teamMembers: .empty, needing: "Artistas")
        sut.receivedData = OnGoingProjectDetails.Info.Received.Project(projectId: "idProj", notInvitedUsers: .empty)
        sut.fetchUpdateProjectInfo(OnGoingProjectDetails.Request.UpdateInfo(title: "Novo Título", sinopsis: "Nova Sinopse"))
        let expectedResult = OnGoingProjectDetails.Info.Model.Project(id: "idProj", firstCathegory: "Ação", secondCathegory: "Aventura", image: "old image", progress: 50, title: "Novo Título", sinopsis: "Nova Sinopse", teamMembers: .empty, needing: "Artistas")
        XCTAssertNil(error)
        XCTAssertEqual(expectedResult, projectDetails)
    }
    
    func testFetchUpdateProjectInfo_Error() {
        XCTAssertNil(error)
        sut.projectData = OnGoingProjectDetails.Info.Model.Project(id: "ERROR", firstCathegory: "Ação", secondCathegory: "Aventura", image: "old image", progress: 50, title: "Projeto Teste", sinopsis: "Sinopse do Projeto Teste", teamMembers: .empty, needing: "Artistas")
        sut.receivedData = OnGoingProjectDetails.Info.Received.Project(projectId: "ERROR", notInvitedUsers: .empty)
        sut.fetchUpdateProjectInfo(OnGoingProjectDetails.Request.UpdateInfo(title: "Novo Título", sinopsis: "Nova Sinopse"))
        XCTAssertNotNil(error)
    }
    
    func testFetchUpdateProjectNeeding_Success() {
        XCTAssertNil(error)
        sut.projectData = OnGoingProjectDetails.Info.Model.Project(id: "idProj", firstCathegory: "Ação", secondCathegory: "Aventura", image: "image", progress: 50, title: "Projeto Teste", sinopsis: "Sinopse do Projeto Teste", teamMembers: .empty, needing: "Artistas")
        sut.receivedData = OnGoingProjectDetails.Info.Received.Project(projectId: "idProj", notInvitedUsers: .empty)
        sut.fetchUpdateProjectNeeding(OnGoingProjectDetails.Request.UpdateNeeding(needing: "Novo Needing"))
        let expectedResult = OnGoingProjectDetails.Info.Model.Project(id: "idProj", firstCathegory: "Ação", secondCathegory: "Aventura", image: "image", progress: 50, title: "Projeto Teste", sinopsis: "Sinopse do Projeto Teste", teamMembers: .empty, needing: "Novo Needing")
        XCTAssertNil(error)
        XCTAssertEqual(expectedResult, projectDetails)
    }
    
    func testFetchUpdateProjectNeeding_Error() {
        XCTAssertNil(error)
        sut.projectData = OnGoingProjectDetails.Info.Model.Project(id: "ERROR", firstCathegory: "Ação", secondCathegory: "Aventura", image: "image", progress: 50, title: "Projeto Teste", sinopsis: "Sinopse do Projeto Teste", teamMembers: .empty, needing: "Artistas")
        sut.receivedData = OnGoingProjectDetails.Info.Received.Project(projectId: "ERROR", notInvitedUsers: .empty)
        sut.fetchUpdateProjectNeeding(OnGoingProjectDetails.Request.UpdateNeeding(needing: "Novo Needing"))
        XCTAssertNotNil(error)
    }
    
    func testDidCancelEditing() {
        XCTAssertNil(error)
        sut.projectData = OnGoingProjectDetails.Info.Model.Project(id: "idProj", firstCathegory: "Ação", secondCathegory: "Aventura", image: "image", progress: 50, title: "Projeto Teste", sinopsis: "Sinopse do Projeto Teste", teamMembers: .empty, needing: "Artistas")
        sut.didCancelEditing(OnGoingProjectDetails.Request.CancelEditing())
        let expectedResult = OnGoingProjectDetails.Info.Model.Project(id: "idProj", firstCathegory: "Ação", secondCathegory: "Aventura", image: "image", progress: 50, title: "Projeto Teste", sinopsis: "Sinopse do Projeto Teste", teamMembers: .empty, needing: "Artistas")
        XCTAssertEqual(expectedResult, projectDetails)
        XCTAssertTrue(presentProjectDetailsFlag)
    }
    
    func testFetchInteract() {
        XCTAssertNil(projectRelation)
        sut.projectRelation = OnGoingProjectDetails.Info.Model.ProjectRelation.simpleParticipating
        sut.fetchInteract(OnGoingProjectDetails.Request.FetchInteraction())
        let expectedResult = OnGoingProjectDetails.Info.Model.RelationModel(relation: .simpleParticipating)
        XCTAssertEqual(expectedResult, relation)
    }
    
    func testFetchConfirmInteraction_ExitProject() {
        XCTAssertNil(error)
        XCTAssertFalse(presentInteractionEffectivatedFlag)
        sut.projectRelation = OnGoingProjectDetails.Info.Model.ProjectRelation.simpleParticipating
        sut.fetchConfirmInteraction(OnGoingProjectDetails.Request.ConfirmInteraction())
        XCTAssertNil(error)
        XCTAssertTrue(presentInteractionEffectivatedFlag)
    }
    
    func testFetchConfirmInteraction_RemoveProjectParticipationRequest() {
        XCTAssertNil(error)
        XCTAssertFalse(presentInteractionEffectivatedFlag)
        sut.projectRelation = OnGoingProjectDetails.Info.Model.ProjectRelation.sentRequest
        sut.fetchConfirmInteraction(OnGoingProjectDetails.Request.ConfirmInteraction())
        XCTAssertNil(error)
        XCTAssertTrue(presentInteractionEffectivatedFlag)
    }
    
    func testFetchConfirmInteraction_AcceptProjectInvite() {
        XCTAssertNil(error)
        XCTAssertFalse(presentInteractionEffectivatedFlag)
        sut.projectRelation = OnGoingProjectDetails.Info.Model.ProjectRelation.receivedRequest
        sut.fetchConfirmInteraction(OnGoingProjectDetails.Request.ConfirmInteraction())
        XCTAssertNil(error)
        XCTAssertTrue(presentInteractionEffectivatedFlag)
    }
    
    func testFetchConfirmInteraction_SendProjectParticipationRequest() {
        XCTAssertNil(error)
        XCTAssertFalse(presentInteractionEffectivatedFlag)
        sut.projectRelation = OnGoingProjectDetails.Info.Model.ProjectRelation.nothing
        sut.fetchConfirmInteraction(OnGoingProjectDetails.Request.ConfirmInteraction())
        XCTAssertNil(error)
        XCTAssertTrue(presentInteractionEffectivatedFlag)
    }
    
    func testFetchRefuseInteraction_Author() {
        XCTAssertFalse(presentRefusedInteractionFlag)
        sut.projectRelation = .author
        sut.fetchRefuseInteraction(OnGoingProjectDetails.Request.RefuseInteraction())
        XCTAssertTrue(presentRefusedInteractionFlag)
    }
    
    func testFetchRefuseInteraction_SimpleParticipating() {
        XCTAssertFalse(presentRefusedInteractionFlag)
        sut.projectRelation = .simpleParticipating
        sut.fetchRefuseInteraction(OnGoingProjectDetails.Request.RefuseInteraction())
        XCTAssertTrue(presentRefusedInteractionFlag)
    }
    
    func testFetchRefuseInteraction_SentRequest() {
        XCTAssertFalse(presentRefusedInteractionFlag)
        sut.projectRelation = .sentRequest
        sut.fetchRefuseInteraction(OnGoingProjectDetails.Request.RefuseInteraction())
        XCTAssertTrue(presentRefusedInteractionFlag)
    }
    
    func testFetchRefuseInteraction_ReceivedRequest() {
        XCTAssertFalse(presentInteractionEffectivatedFlag)
        sut.projectRelation = .receivedRequest
        sut.projectData = OnGoingProjectDetails.Info.Model.Project(id: "idProj", firstCathegory: "Ação", secondCathegory: "Aventura", image: "image", progress: 50, title: "Projeto Teste", sinopsis: "Sinopse do Projeto Teste", teamMembers: .empty, needing: "Alguma coisa")
        sut.fetchRefuseInteraction(OnGoingProjectDetails.Request.RefuseInteraction())
        XCTAssertTrue(presentInteractionEffectivatedFlag)
    }
    
    func testFetchRefuseInteraction_Nothing() {
        XCTAssertFalse(presentRefusedInteractionFlag)
        sut.projectRelation = .nothing
        sut.fetchRefuseInteraction(OnGoingProjectDetails.Request.RefuseInteraction())
        XCTAssertTrue(presentRefusedInteractionFlag)
    }
    
    func testFetchProgressPercentage() {
        XCTAssertNil(progress)
        sut.projectData = OnGoingProjectDetails.Info.Model.Project(id: "idProj", firstCathegory: "Ação", secondCathegory: "Aventura", image: "image", progress: 50, title: "Projeto Teste", sinopsis: "Sinopse do Projeto Teste", teamMembers: .empty, needing: "Alguma coisa")
        sut.fetchProgressPercentage(OnGoingProjectDetails.Request.FetchProgress())
        let expectedResult = OnGoingProjectDetails.Info.Model.Progress(percentage: 50)
        XCTAssertEqual(expectedResult, progress)
    }
    
    func testFetchUpdateProgress_Success() {
        XCTAssertNil(error)
        XCTAssertNil(feedback)
        XCTAssertFalse(presentProjectDetailsFlag)
        sut.projectData =  OnGoingProjectDetails.Info.Model.Project(id: "idProj", firstCathegory: "Ação", secondCathegory: "Aventura", image: "image", progress: 50, title: "Projeto Teste", sinopsis: "Sinopse do Projeto Teste", teamMembers: .empty, needing: "Alguma coisa")
        sut.fetchUpdateProgress(OnGoingProjectDetails.Request.UpdateProgress(newProgress: 0.6))
        let expectedFeedback = OnGoingProjectDetails.Info.Model.Feedback(title: OnGoingProjectDetails.Constants.Texts.updatedProgressTitle, message: OnGoingProjectDetails.Constants.Texts.updateProgressMessage)
        let expectedProgress: Int = 60
        XCTAssertEqual(expectedFeedback, feedback)
        XCTAssertEqual(expectedProgress, projectDetails?.progress)
        XCTAssertTrue(presentProjectDetailsFlag)
    }
    
    func testFetchUpdateProgress_Error() {
        XCTAssertNil(error)
        sut.projectData =  OnGoingProjectDetails.Info.Model.Project(id: "ERROR", firstCathegory: "Ação", secondCathegory: "Aventura", image: "image", progress: 50, title: "Projeto Teste", sinopsis: "Sinopse do Projeto Teste", teamMembers: .empty, needing: "Alguma coisa")
        sut.fetchUpdateProgress(OnGoingProjectDetails.Request.UpdateProgress(newProgress: 60))
        XCTAssertNotNil(error)
    }
}

extension OnGoingProjectDetailsInteractor_Tests: OnGoingProjectDetailsPresentationLogic {
    
    func presentConfirmFinishedProjectAlert() {
        
    }
    
    func hideEditProgressModal() {
        
    }
    
    
    func presentProjectDetails(_ response: OnGoingProjectDetails.Info.Model.Project) {
        self.projectDetails = response
        self.presentProjectDetailsFlag = true
    }
    
    func presentProjectRelationUI(_ response: OnGoingProjectDetails.Info.Model.RelationModel) {
        self.projectRelation = response
    }
    
    func presentError(_ response: String) {
        self.error = response
    }
    
    func presentLoading(_ loading: Bool) {
        self.loadingFlag = loading
    }
    
    func presentFeedback(_ response: OnGoingProjectDetails.Info.Model.Feedback) {
        self.feedback = response
    }
    
    func presentUserDetails() {
        self.presentUserDetailsFlag = true
    }
    
    func presentConfirmationModal(forRelation relation: OnGoingProjectDetails.Info.Model.RelationModel) {
        self.relation = relation
    }
    
    func presentInteractionEffectivated() {
        self.presentInteractionEffectivatedFlag = true
    }
    
    func presentRefusedInteraction() {
        self.presentRefusedInteractionFlag = true
    }
    
    func presentEditProgressModal(withProgress response: OnGoingProjectDetails.Info.Model.Progress) {
        self.progress = response
    }
}
