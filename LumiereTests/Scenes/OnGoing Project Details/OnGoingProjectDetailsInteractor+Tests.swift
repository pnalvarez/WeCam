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
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
}

extension OnGoingProjectDetailsInteractor_Tests: OnGoingProjectDetailsPresentationLogic {
    
    func presentProjectDetails(_ response: OnGoingProjectDetails.Info.Model.Project) {
        
    }
    
    func presentProjectRelationUI(_ response: OnGoingProjectDetails.Info.Model.RelationModel) {
        
    }
    
    func presentError(_ response: String) {
        
    }
    
    func presentLoading(_ loading: Bool) {
        
    }
    
    func presentFeedback(_ response: OnGoingProjectDetails.Info.Model.Feedback) {
        
    }
    
    func presentUserDetails() {
        
    }
    
    func presentConfirmationModal(forRelation relation: OnGoingProjectDetails.Info.Model.RelationModel) {
        
    }
    
    func presentInteractionEffectivated() {
        
    }
    
    func presentRefusedInteraction() {
        
    }
    
    func presentEditProgressModal(withProgress response: OnGoingProjectDetails.Info.Model.Progress) {
        
    }
}
