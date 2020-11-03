//
//  MainFeedPresenter+Tests.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 02/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
@testable import Lumiere
import XCTest

class MainFeedPresenter_Tests: XCTestCase {

    var sut: MainFeedPresenter!
    
    var displaySearchResultsFlag = false
    var displayProfileDetailsFlag = false
    var displayOnGoingProjectDetailsFlag = false
    var feedData: MainFeed.Info.ViewModel.UpcomingFeedData!
    
    override func setUp() {
        super.setUp()
        sut = MainFeedPresenter(viewController: self)
    }
    
    override func tearDown() {
        sut = nil
        displaySearchResultsFlag = false
        displayProfileDetailsFlag = false
        displayOnGoingProjectDetailsFlag = false
        feedData = nil
        super.tearDown()
    }
    
    func testPresentSearchResults() {
        XCTAssertFalse(displaySearchResultsFlag)
        sut.presentSearchResults()
        XCTAssertTrue(displaySearchResultsFlag)
    }
    
    func testPresentProfileDetails() {
        XCTAssertFalse(displayProfileDetailsFlag)
        sut.presentProfileDetails()
        XCTAssertTrue(displayProfileDetailsFlag)
    }
    
    func testPresentOnGoingProjectDetails() {
        XCTAssertFalse(displayOnGoingProjectDetailsFlag)
        sut.presentOnGoingProjectDetails()
        XCTAssertTrue(displayOnGoingProjectDetailsFlag)
    }
    
    func testPresentFeedData() {
        XCTAssertNil(feedData)
        sut.presentFeedData(MainFeed.Info.Model.UpcomingFeedData.stub)
        let expectedResult = MainFeed.Info.ViewModel.UpcomingFeedData(suggestedProfiles: MainFeed.Info.ViewModel.UpcomingProfiles(suggestions: [MainFeed.Info.ViewModel.ProfileSuggestion(image: "image", name: "Usuario Teste 1", ocupation: "Artista")]), ongoingProjects: MainFeed.Info.ViewModel.UpcomingProjects(projects: [MainFeed.Info.ViewModel.OnGoingProject(image: "image", progress: 0)]), interestCathegories: MainFeed.Info.ViewModel.UpcomingOnGoingProjectsCriterias(selectedCriteria: MainFeed.Info.ViewModel.OnGoingProjectFeedCriteria(criteria: "Todos"), criterias: [MainFeed.Info.ViewModel.OnGoingProjectFeedCriteria(criteria: "Todos"), MainFeed.Info.ViewModel.OnGoingProjectFeedCriteria(criteria: "Conexões"), MainFeed.Info.ViewModel.OnGoingProjectFeedCriteria(criteria: "Ação")]))
        XCTAssertEqual(expectedResult, feedData)
    }
}

extension MainFeedPresenter_Tests: MainFeedDisplayLogic {
    
    func displaySearchResults() {
        self.displaySearchResultsFlag = true
    }
    
    func displayProfileDetails() {
        self.displayProfileDetailsFlag = true
    }
    
    func displayOnGoingProjectDetails() {
        self.displayOnGoingProjectDetailsFlag = true
    }
    
    func displayFeedData(_ viewModel: MainFeed.Info.ViewModel.UpcomingFeedData) {
        self.feedData = viewModel
    }
    
    func displayGenericError() {
        
    }
}
