//
//  OnGoingProjectInvitesPresenter+Tests.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 05/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import XCTest
@testable import Lumiere

class OnGoingProjectInvitesPresenter_Tests: XCTestCase {
    
    var sut: ProjectInvitesPresenter!
    
    var users: ProjectInvites.Info.ViewModel.UpcomingUsers?
    var project: ProjectInvites.Info.ViewModel.Project?
    var alert: ProjectInvites.Info.ViewModel.Alert?
    var hideConfirmationViewFlag = false
    var displayLoadingFLag = false
    var displayProfileDetailsFlag = false
    var error: ProjectInvites.Info.ViewModel.ErrorViewModel?
    var relationUpdate: ProjectInvites.Info.ViewModel.RelationUpdate?
    
    override func setUp() {
        super.setUp()
        sut = ProjectInvitesPresenter(viewController: self)
    }
    
    override func tearDown() {
        sut = nil
        users = nil
        project = nil
        alert = nil
        hideConfirmationViewFlag = false
        displayLoadingFLag = false
        displayProfileDetailsFlag = false
        error = nil
        relationUpdate = nil
        super.tearDown()
    }
    
    func testPresentUsers() {
        XCTAssertNil(users)
        sut.presentUsers(ProjectInvites.Info.Model.UpcomingUsers.stub)
        let expectedResult = ProjectInvites.Info.ViewModel.UpcomingUsers(users: [ProjectInvites.Info.ViewModel.User(image: "image", name: "Usuário Teste 1", ocupation: "Artista", email:  NSAttributedString(string: "user_test1@hotmail.com",
                                                                                                                                                                                                                             attributes: [NSAttributedString.Key.font: ProjectInvites.Constants.Fonts.emailLbl,
                                                                                                                                                                                                                                          NSAttributedString.Key.foregroundColor: ProjectInvites.Constants.Colors.emailLbl,
                                                                                                                                                                                                                                          NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]), relation: ProjectInvites.Constants.Images.member), ProjectInvites.Info.ViewModel.User(image: "image", name: "Usuário Teste 2", ocupation: "Artista", email:NSAttributedString(string: "user_test2@hotmail.com",
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  attributes: [NSAttributedString.Key.font: ProjectInvites.Constants.Fonts.emailLbl,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               NSAttributedString.Key.foregroundColor: ProjectInvites.Constants.Colors.emailLbl,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]), relation: ProjectInvites.Constants.Images.sentRequest), ProjectInvites.Info.ViewModel.User(image: "image", name: "Usuário Teste 3", ocupation: "Artista", email: NSAttributedString(string: "user_test3@hotmail.com",
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             attributes: [NSAttributedString.Key.font: ProjectInvites.Constants.Fonts.emailLbl,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          NSAttributedString.Key.foregroundColor: ProjectInvites.Constants.Colors.emailLbl,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]), relation: ProjectInvites.Constants.Images.invite), ProjectInvites.Info.ViewModel.User(image: "image", name: "Usuário Teste 4", ocupation: "Artista", email: NSAttributedString(string: "user_test4@hotmail.com",
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   attributes: [NSAttributedString.Key.font: ProjectInvites.Constants.Fonts.emailLbl,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                NSAttributedString.Key.foregroundColor: ProjectInvites.Constants.Colors.emailLbl,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]), relation: ProjectInvites.Constants.Images.receivedRequest)])
        XCTAssertEqual(expectedResult, users)
    }
    
    func testPresentProject() {
        XCTAssertNil(project)
        XCTAssertNil(error)
        sut.presentProject(ProjectInvites.Info.Model.Project.stub)
        let expectedResult = ProjectInvites.Info.ViewModel.Project(title: "Projeto Teste 1")
        XCTAssertEqual(expectedResult, project)
        XCTAssertNil(error)
    }
    
    func testPresentModalAlert() {
        XCTAssertNil(error)
        XCTAssertNil(alert)
        sut.presentModalAlert(ProjectInvites.Info.Model.Alert(text: "Teste"))
        let expectedResult = ProjectInvites.Info.ViewModel.Alert(text: "Teste")
        XCTAssertNil(error)
        XCTAssertEqual(expectedResult, alert)
    }
    
    func testHideModalAlert() {
        XCTAssertFalse(hideConfirmationViewFlag)
        sut.hideModalAlert()
        XCTAssertTrue(hideConfirmationViewFlag)
    }
    
    func testPresentLoading() {
        XCTAssertFalse(displayLoadingFLag)
        sut.presentLoading(true)
        XCTAssertTrue(displayLoadingFLag)
    }
    
    func testPresentProfileDetails() {
        XCTAssertFalse(displayProfileDetailsFlag)
        sut.presentProfileDetails()
        XCTAssertTrue(displayProfileDetailsFlag)
    }
    
    func testPresentError() {
        XCTAssertNil(error)
        sut.presentError(FirebaseErrors.genericError)
        XCTAssertNotNil(error)
    }
    
    func testPresentRelationUpdate() {
        XCTAssertNil(relationUpdate)
        sut.presentRelationUpdate(ProjectInvites.Info.Model.RelationUpdate(index: 0, relation: .simpleParticipant))
        let expectedResult = ProjectInvites.Info.ViewModel.RelationUpdate(index: 0, relation: ProjectInvites.Constants.Images.member)
        XCTAssertEqual(expectedResult, relationUpdate)
    }
}

extension OnGoingProjectInvitesPresenter_Tests: ProjectInvitesDisplayLogic {
    
    func displayUsers(_ viewModel: ProjectInvites.Info.ViewModel.UpcomingUsers) {
        self.users = viewModel
    }
    
    func displayProjectInfo(_ viewModel: ProjectInvites.Info.ViewModel.Project) {
        self.project = viewModel
    }
    
    func displayConfirmationView(_ viewModel: ProjectInvites.Info.ViewModel.Alert) {
        self.alert = viewModel
    }
    
    func hideConfirmationView() {
        self.hideConfirmationViewFlag = true
    }
    
    func displayLoading(_ loading: Bool) {
        self.displayLoadingFLag = true
    }
    
    func displayProfileDetails() {
        self.displayProfileDetailsFlag = true
    }
    
    func displayError(_ viewModel: ProjectInvites.Info.ViewModel.ErrorViewModel) {
        self.error = viewModel
    }
    
    func displayRelationUpdate(_ viewModel: ProjectInvites.Info.ViewModel.RelationUpdate) {
        self.relationUpdate = viewModel
    }
}
