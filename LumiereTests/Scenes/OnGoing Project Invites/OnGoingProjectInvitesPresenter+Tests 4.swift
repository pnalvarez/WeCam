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
    
    var sut: OnGoingProjectInvitesPresenter!
    
    var users: OnGoingProjectInvites.Info.ViewModel.UpcomingUsers?
    var project: OnGoingProjectInvites.Info.ViewModel.Project?
    var alert: OnGoingProjectInvites.Info.ViewModel.Alert?
    var hideConfirmationViewFlag = false
    var displayLoadingFLag = false
    var displayProfileDetailsFlag = false
    var error: OnGoingProjectInvites.Info.ViewModel.ErrorViewModel?
    var relationUpdate: OnGoingProjectInvites.Info.ViewModel.RelationUpdate?
    
    override func setUp() {
        super.setUp()
        sut = OnGoingProjectInvitesPresenter(viewController: self)
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
        sut.presentUsers(OnGoingProjectInvites.Info.Model.UpcomingUsers.stub)
        let expectedResult = OnGoingProjectInvites.Info.ViewModel.UpcomingUsers(users: [OnGoingProjectInvites.Info.ViewModel.User(image: "image", name: "Usuário Teste 1", ocupation: "Artista", email:  NSAttributedString(string: "user_test1@hotmail.com",
                                                                                                                                                                                                                             attributes: [NSAttributedString.Key.font: OnGoingProjectInvites.Constants.Fonts.emailLbl,
                                                                                                                                                                                                                                          NSAttributedString.Key.foregroundColor: OnGoingProjectInvites.Constants.Colors.emailLbl,
                                                                                                                                                                                                                                          NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]), relation: OnGoingProjectInvites.Constants.Images.member), OnGoingProjectInvites.Info.ViewModel.User(image: "image", name: "Usuário Teste 2", ocupation: "Artista", email:NSAttributedString(string: "user_test2@hotmail.com",
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  attributes: [NSAttributedString.Key.font: OnGoingProjectInvites.Constants.Fonts.emailLbl,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               NSAttributedString.Key.foregroundColor: OnGoingProjectInvites.Constants.Colors.emailLbl,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]), relation: OnGoingProjectInvites.Constants.Images.sentRequest), OnGoingProjectInvites.Info.ViewModel.User(image: "image", name: "Usuário Teste 3", ocupation: "Artista", email: NSAttributedString(string: "user_test3@hotmail.com",
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             attributes: [NSAttributedString.Key.font: OnGoingProjectInvites.Constants.Fonts.emailLbl,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          NSAttributedString.Key.foregroundColor: OnGoingProjectInvites.Constants.Colors.emailLbl,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]), relation: OnGoingProjectInvites.Constants.Images.invite), OnGoingProjectInvites.Info.ViewModel.User(image: "image", name: "Usuário Teste 4", ocupation: "Artista", email: NSAttributedString(string: "user_test4@hotmail.com",
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   attributes: [NSAttributedString.Key.font: OnGoingProjectInvites.Constants.Fonts.emailLbl,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                NSAttributedString.Key.foregroundColor: OnGoingProjectInvites.Constants.Colors.emailLbl,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]), relation: OnGoingProjectInvites.Constants.Images.receivedRequest)])
        XCTAssertEqual(expectedResult, users)
    }
    
    func testPresentProject() {
        XCTAssertNil(project)
        XCTAssertNil(error)
        sut.presentProject(OnGoingProjectInvites.Info.Model.Project.stub)
        let expectedResult = OnGoingProjectInvites.Info.ViewModel.Project(title: "Projeto Teste 1")
        XCTAssertEqual(expectedResult, project)
        XCTAssertNil(error)
    }
    
    func testPresentModalAlert() {
        XCTAssertNil(error)
        XCTAssertNil(alert)
        sut.presentModalAlert(OnGoingProjectInvites.Info.Model.Alert(text: "Teste"))
        let expectedResult = OnGoingProjectInvites.Info.ViewModel.Alert(text: "Teste")
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
        sut.presentRelationUpdate(OnGoingProjectInvites.Info.Model.RelationUpdate(index: 0, relation: .simpleParticipant))
        let expectedResult = OnGoingProjectInvites.Info.ViewModel.RelationUpdate(index: 0, relation: OnGoingProjectInvites.Constants.Images.member)
        XCTAssertEqual(expectedResult, relationUpdate)
    }
}

extension OnGoingProjectInvitesPresenter_Tests: OnGoingProjectInvitesDisplayLogic {
    
    func displayUsers(_ viewModel: OnGoingProjectInvites.Info.ViewModel.UpcomingUsers) {
        self.users = viewModel
    }
    
    func displayProjectInfo(_ viewModel: OnGoingProjectInvites.Info.ViewModel.Project) {
        self.project = viewModel
    }
    
    func displayConfirmationView(_ viewModel: OnGoingProjectInvites.Info.ViewModel.Alert) {
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
    
    func displayError(_ viewModel: OnGoingProjectInvites.Info.ViewModel.ErrorViewModel) {
        self.error = viewModel
    }
    
    func displayRelationUpdate(_ viewModel: OnGoingProjectInvites.Info.ViewModel.RelationUpdate) {
        self.relationUpdate = viewModel
    }
}
