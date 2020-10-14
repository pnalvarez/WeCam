//
//  OnGoingProjectDetailsPresenter+Tests.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 04/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import XCTest
@testable import Lumiere

class OnGoingProjectDetailsPresenter_Tests: XCTestCase {
    
    var sut: OnGoingProjectDetailsPresenter!
    
    var projectDetails: OnGoingProjectDetails.Info.ViewModel.Project?
    var error: String?
    var loadingFlag = false
    var relation: OnGoingProjectDetails.Info.ViewModel.RelationModel?
    var feedback: OnGoingProjectDetails.Info.ViewModel.Feedback?
    var displayUserDetailsFlag = false
    var confirmation: OnGoingProjectDetails.Info.ViewModel.RelationModel?
    var hideConfirmationModalFlag = false
    var displayInteractionEffectivatedFlag = false
    var displayRefusedInteractionFlag = false
    var progress: OnGoingProjectDetails.Info.ViewModel.Progress?
    var hideProgressModalFlag = false
    
    override func setUp() {
        super.setUp()
        sut = OnGoingProjectDetailsPresenter(viewController: self)
    }
    
    override func tearDown() {
        sut = nil
        projectDetails = nil
        error = nil
        loadingFlag = false
        relation = nil
        feedback = nil
        displayUserDetailsFlag = false
        confirmation = nil
        hideConfirmationModalFlag = false
        displayInteractionEffectivatedFlag = false
        displayRefusedInteractionFlag = false
        progress = nil
        hideConfirmationModalFlag = false
        super.tearDown()
    }
    
    func testPresentProjectDetails() {
        XCTAssertNil(projectDetails)
        XCTAssertNil(error)
        sut.presentProjectDetails(OnGoingProjectDetails.Info.Model.Project.stub)
        let expectedResult = OnGoingProjectDetails.Info.ViewModel.Project(image: "image", cathegories: NSAttributedString(string: "Ação / Aventura", attributes: [NSAttributedString.Key.font: OnGoingProjectDetails.Constants.Fonts.cathegoryLbl, NSAttributedString.Key.foregroundColor: OnGoingProjectDetails.Constants.Colors.cathegoryLbl, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]), title: "Projeto Teste 1", progress: NSAttributedString(string: "50%", attributes: [NSAttributedString.Key.font: OnGoingProjectDetails.Constants.Fonts.progressButton, NSAttributedString.Key.foregroundColor: OnGoingProjectDetails.Constants.Colors.progressButton, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]), sinopsis: "Sinopse do Projeto Teste 1", teamMembers: .empty, needing: "Artistas")
        XCTAssertNil(error)
        XCTAssertEqual(expectedResult, projectDetails)
    }
    
    func testPresentProjectRelationUI() {
        XCTAssertNil(relation)
        sut.presentProjectRelationUI(OnGoingProjectDetails.Info.Model.RelationModel.stub)
        let expectedResult = OnGoingProjectDetails.Info.ViewModel.RelationModel(relation: .simpleParticipating)
        XCTAssertEqual(expectedResult, relation)
    }
    
    func testPresentError() {
        XCTAssertNil(error)
        sut.presentError("Error")
        XCTAssertNotNil(error)
    }
    
    func testPresentLoading() {
        XCTAssertFalse(loadingFlag)
        sut.presentLoading(true)
        XCTAssertTrue(loadingFlag)
    }
    
    func testPresentFeedback() {
        XCTAssertNil(feedback)
        sut.presentFeedback(OnGoingProjectDetails.Info.Model.Feedback(title: "Title", message: "Message"))
        let expectedResult = OnGoingProjectDetails.Info.ViewModel.Feedback(title: "Title", message: "Message")
        XCTAssertEqual(expectedResult, feedback)
    }
    
    func testPresentUserDetails() {
        XCTAssertFalse(displayUserDetailsFlag)
        sut.presentUserDetails()
        XCTAssertTrue(displayUserDetailsFlag)
    }
    
    func testPresentConfirmationModal() {
        XCTAssertNil(confirmation)
        sut.presentConfirmationModal(forRelation: .stub)
        let expectedResult = OnGoingProjectDetails.Info.ViewModel.RelationModel(relation: .simpleParticipating)
        XCTAssertEqual(expectedResult, confirmation)
    }
    
    func testPresentInteractionEffectivated() {
        XCTAssertFalse(displayInteractionEffectivatedFlag)
        sut.presentInteractionEffectivated()
        XCTAssertTrue(displayInteractionEffectivatedFlag)
    }
    
    func testPresentRefusedInteraction() {
        XCTAssertFalse(displayRefusedInteractionFlag)
        sut.presentRefusedInteraction()
        XCTAssertTrue(displayRefusedInteractionFlag)
    }
    
    func testPresentEditProgressModal() {
        XCTAssertNil(progress)
        sut.presentEditProgressModal(withProgress: OnGoingProjectDetails.Info.Model.Progress(percentage: 50))
        let expectedResult = OnGoingProjectDetails.Info.ViewModel.Progress(percentage: 50)
        XCTAssertEqual(expectedResult, progress)
    }
}

extension OnGoingProjectDetailsPresenter_Tests: OnGoingProjectDetailsDisplayLogic {
    
    func displayProjectDetails(_ viewModel: OnGoingProjectDetails.Info.ViewModel.Project) {
        self.projectDetails = viewModel
    }
    
    func displayError(_ viewModel: String) {
        self.error = viewModel
    }
    
    func displayLoading(_ loading: Bool) {
        self.loadingFlag = loading
    }
    
    func displayUIForRelation(_ viewModel: OnGoingProjectDetails.Info.ViewModel.RelationModel) {
        self.relation = viewModel
    }
    
    func displayFeedback(_ viewModel: OnGoingProjectDetails.Info.ViewModel.Feedback) {
        self.feedback = viewModel
    }
    
    func displayUserDetails() {
        self.displayUserDetailsFlag = true
    }
    
    func displayConfirmationModal(_ viewModel: OnGoingProjectDetails.Info.ViewModel.RelationModel) {
        self.confirmation = viewModel
    }
    
    func hideConfirmationModal() {
        self.hideConfirmationModalFlag = true
    }
    
    func displayInteractionEffectivated() {
        self.displayInteractionEffectivatedFlag = true
    }
    
    func displayRefusedInteraction() {
        self.displayRefusedInteractionFlag = true
    }
    
    func displayEditProgressModal(_ viewModel: OnGoingProjectDetails.Info.ViewModel.Progress) {
        self.progress = viewModel
    }
    
    func hideEditProgressModal() {
        self.hideConfirmationModalFlag = true
    }
}
