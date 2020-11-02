//
//  MainFeedInteractor+Tests.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 02/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
@testable import Lumiere
import XCTest

class MainFeedInteractor_Tests: XCTestCase {
    
    var sut: MainFeedInteractor!
    var workerMock: MainFeedWorkerProtocol!
    
    var presentSearchResultsFlag = false
    var presentProfileDetailsFlag = false
    var presentOnGoingProjectDetailsFlag = false
    var feedData: MainFeed.Info.Model.UpcomingFeedData!

    override func setUp() {
        super.setUp()
        workerMock = MainFeedWorkerMock()
        sut = MainFeedInteractor(worker: workerMock, presenter: self)
    }
    
    override func tearDown() {
        workerMock = nil
        sut = nil
        presentSearchResultsFlag = false
        presentProfileDetailsFlag = false
        presentOnGoingProjectDetailsFlag = false
        feedData = nil
        super.tearDown()
    }
    
    func testFetchSearch() {
        XCTAssertNil(sut.searchKey)
        XCTAssertFalse(presentSearchResultsFlag)
        sut.fetchSearch(MainFeed.Request.Search(key: "Chave"))
        let expectedResult = MainFeed.Info.Model.SearchKey(key: "Chave")
        XCTAssertEqual(expectedResult, sut.searchKey)
        XCTAssertTrue(presentSearchResultsFlag)
    }
    
    func testFetchMainFeed() {
        XCTAssertNil(feedData)
        sut.fetchMainFeed(MainFeed.Request.MainFeed())
        let expectedResult = MainFeed.Info.Model.UpcomingFeedData(profileSuggestions: MainFeed.Info.Model.UpcomingProfiles(suggestions: [MainFeed.Info.Model.ProfileSuggestion(userId: "idUser1", image: "image", name: "Usuario Teste 1", ocupation: "Artista"), MainFeed.Info.Model.ProfileSuggestion(userId: "idUser2", image: "image", name: "Usuario Teste 2", ocupation: "Artista"), MainFeed.Info.Model.ProfileSuggestion(userId: "idUser3", image: "image", name: "Usuario Teste 3", ocupation: "Artista")]), ongoingProjects: MainFeed.Info.Model.UpcomingProjects(projects: [MainFeed.Info.Model.OnGoingProject(id: "-MJT-LQSKyEK4fC3hr1g", image: "https://firebasestorage.googleapis.com/v0/b/lumiere-b1a80.appspot.com/o/projects%2F-MJT-LQSKyEK4fC3hr1g?alt=media&token=96b8b01f-268b-4b5f-b8a4-03d7f5c3e1c9", progress: 67), MainFeed.Info.Model.OnGoingProject(id: "-MJT-LQSKyEK4fC3hr1g", image: "https://firebasestorage.googleapis.com/v0/b/lumiere-b1a80.appspot.com/o/projects%2F-MJT-LQSKyEK4fC3hr1g?alt=media&token=96b8b01f-268b-4b5f-b8a4-03d7f5c3e1c9", progress: 67), MainFeed.Info.Model.OnGoingProject(id: "-MJT-LQSKyEK4fC3hr1g", image: "https://firebasestorage.googleapis.com/v0/b/lumiere-b1a80.appspot.com/o/projects%2F-MJT-LQSKyEK4fC3hr1g?alt=media&token=96b8b01f-268b-4b5f-b8a4-03d7f5c3e1c9", progress: 67), MainFeed.Info.Model.OnGoingProject(id: "-MJT-LQSKyEK4fC3hr1g", image: "https://firebasestorage.googleapis.com/v0/b/lumiere-b1a80.appspot.com/o/projects%2F-MJT-LQSKyEK4fC3hr1g?alt=media&token=96b8b01f-268b-4b5f-b8a4-03d7f5c3e1c9", progress: 67), MainFeed.Info.Model.OnGoingProject(id: "-MJT-LQSKyEK4fC3hr1g", image: "https://firebasestorage.googleapis.com/v0/b/lumiere-b1a80.appspot.com/o/projects%2F-MJT-LQSKyEK4fC3hr1g?alt=media&token=96b8b01f-268b-4b5f-b8a4-03d7f5c3e1c9", progress: 67), MainFeed.Info.Model.OnGoingProject(id: "-MJT-LQSKyEK4fC3hr1g", image: "https://firebasestorage.googleapis.com/v0/b/lumiere-b1a80.appspot.com/o/projects%2F-MJT-LQSKyEK4fC3hr1g?alt=media&token=96b8b01f-268b-4b5f-b8a4-03d7f5c3e1c9", progress: 67)]), interestCathegories: MainFeed.Info.Model.UpcomingOnGoingProjectCriterias(selectedCriteria: .all, criterias: [.all, .connections,.cathegory(.action), .cathegory(.animation), .cathegory(.adventure)]))
        XCTAssertEqual(expectedResult.ongoingProjects, feedData.ongoingProjects)
        XCTAssertEqual(expectedResult.interestCathegories, feedData.interestCathegories)
        XCTAssertEqual(expectedResult.profileSuggestions, feedData.profileSuggestions)
    }
    
    func testDidSelectSuggestedProfile() {
        sut.mainFeedData = MainFeed.Info.Model.UpcomingFeedData(profileSuggestions: MainFeed.Info.Model.UpcomingProfiles(suggestions: [MainFeed.Info.Model.ProfileSuggestion(userId: "idUser1", image: "image", name: "Usuario Teste 1", ocupation: "Artista"), MainFeed.Info.Model.ProfileSuggestion(userId: "idUser2", image: "image", name: "Usuario Teste 2", ocupation: "Artista"), MainFeed.Info.Model.ProfileSuggestion(userId: "idUser3", image: "image", name: "Usuario Teste 3", ocupation: "Artista")]), ongoingProjects: MainFeed.Info.Model.UpcomingProjects(projects: [MainFeed.Info.Model.OnGoingProject(id: "-MJT-LQSKyEK4fC3hr1g", image: "https://firebasestorage.googleapis.com/v0/b/lumiere-b1a80.appspot.com/o/projects%2F-MJT-LQSKyEK4fC3hr1g?alt=media&token=96b8b01f-268b-4b5f-b8a4-03d7f5c3e1c9", progress: 67), MainFeed.Info.Model.OnGoingProject(id: "-MJT-LQSKyEK4fC3hr1g", image: "https://firebasestorage.googleapis.com/v0/b/lumiere-b1a80.appspot.com/o/projects%2F-MJT-LQSKyEK4fC3hr1g?alt=media&token=96b8b01f-268b-4b5f-b8a4-03d7f5c3e1c9", progress: 67), MainFeed.Info.Model.OnGoingProject(id: "-MJT-LQSKyEK4fC3hr1g", image: "https://firebasestorage.googleapis.com/v0/b/lumiere-b1a80.appspot.com/o/projects%2F-MJT-LQSKyEK4fC3hr1g?alt=media&token=96b8b01f-268b-4b5f-b8a4-03d7f5c3e1c9", progress: 67), MainFeed.Info.Model.OnGoingProject(id: "-MJT-LQSKyEK4fC3hr1g", image: "https://firebasestorage.googleapis.com/v0/b/lumiere-b1a80.appspot.com/o/projects%2F-MJT-LQSKyEK4fC3hr1g?alt=media&token=96b8b01f-268b-4b5f-b8a4-03d7f5c3e1c9", progress: 67), MainFeed.Info.Model.OnGoingProject(id: "-MJT-LQSKyEK4fC3hr1g", image: "https://firebasestorage.googleapis.com/v0/b/lumiere-b1a80.appspot.com/o/projects%2F-MJT-LQSKyEK4fC3hr1g?alt=media&token=96b8b01f-268b-4b5f-b8a4-03d7f5c3e1c9", progress: 67), MainFeed.Info.Model.OnGoingProject(id: "-MJT-LQSKyEK4fC3hr1g", image: "https://firebasestorage.googleapis.com/v0/b/lumiere-b1a80.appspot.com/o/projects%2F-MJT-LQSKyEK4fC3hr1g?alt=media&token=96b8b01f-268b-4b5f-b8a4-03d7f5c3e1c9", progress: 67)]), interestCathegories: MainFeed.Info.Model.UpcomingOnGoingProjectCriterias(selectedCriteria: .all, criterias: [.all, .connections,.cathegory(.action), .cathegory(.animation), .cathegory(.adventure)]))
        XCTAssertFalse(presentProfileDetailsFlag)
        XCTAssertNil(sut.selectedProfile)
        sut.didSelectSuggestedProfile(MainFeed.Request.SelectSuggestedProfile(index: 0))
        let expectedResult = "idUser1"
        XCTAssertEqual(expectedResult, sut.selectedProfile)
        XCTAssertTrue(presentProfileDetailsFlag)
    }
    
    func testDidSelectOnGoingProject() {
        sut.mainFeedData = MainFeed.Info.Model.UpcomingFeedData(profileSuggestions: MainFeed.Info.Model.UpcomingProfiles(suggestions: [MainFeed.Info.Model.ProfileSuggestion(userId: "idUser1", image: "image", name: "Usuario Teste 1", ocupation: "Artista"), MainFeed.Info.Model.ProfileSuggestion(userId: "idUser2", image: "image", name: "Usuario Teste 2", ocupation: "Artista"), MainFeed.Info.Model.ProfileSuggestion(userId: "idUser3", image: "image", name: "Usuario Teste 3", ocupation: "Artista")]), ongoingProjects: MainFeed.Info.Model.UpcomingProjects(projects: [MainFeed.Info.Model.OnGoingProject(id: "-MJT-LQSKyEK4fC3hr1g", image: "https://firebasestorage.googleapis.com/v0/b/lumiere-b1a80.appspot.com/o/projects%2F-MJT-LQSKyEK4fC3hr1g?alt=media&token=96b8b01f-268b-4b5f-b8a4-03d7f5c3e1c9", progress: 67), MainFeed.Info.Model.OnGoingProject(id: "-MJT-LQSKyEK4fC3hr1g", image: "https://firebasestorage.googleapis.com/v0/b/lumiere-b1a80.appspot.com/o/projects%2F-MJT-LQSKyEK4fC3hr1g?alt=media&token=96b8b01f-268b-4b5f-b8a4-03d7f5c3e1c9", progress: 67), MainFeed.Info.Model.OnGoingProject(id: "-MJT-LQSKyEK4fC3hr1g", image: "https://firebasestorage.googleapis.com/v0/b/lumiere-b1a80.appspot.com/o/projects%2F-MJT-LQSKyEK4fC3hr1g?alt=media&token=96b8b01f-268b-4b5f-b8a4-03d7f5c3e1c9", progress: 67), MainFeed.Info.Model.OnGoingProject(id: "-MJT-LQSKyEK4fC3hr1g", image: "https://firebasestorage.googleapis.com/v0/b/lumiere-b1a80.appspot.com/o/projects%2F-MJT-LQSKyEK4fC3hr1g?alt=media&token=96b8b01f-268b-4b5f-b8a4-03d7f5c3e1c9", progress: 67), MainFeed.Info.Model.OnGoingProject(id: "-MJT-LQSKyEK4fC3hr1g", image: "https://firebasestorage.googleapis.com/v0/b/lumiere-b1a80.appspot.com/o/projects%2F-MJT-LQSKyEK4fC3hr1g?alt=media&token=96b8b01f-268b-4b5f-b8a4-03d7f5c3e1c9", progress: 67), MainFeed.Info.Model.OnGoingProject(id: "-MJT-LQSKyEK4fC3hr1g", image: "https://firebasestorage.googleapis.com/v0/b/lumiere-b1a80.appspot.com/o/projects%2F-MJT-LQSKyEK4fC3hr1g?alt=media&token=96b8b01f-268b-4b5f-b8a4-03d7f5c3e1c9", progress: 67)]), interestCathegories: MainFeed.Info.Model.UpcomingOnGoingProjectCriterias(selectedCriteria: .all, criterias: [.all, .connections,.cathegory(.action), .cathegory(.animation), .cathegory(.adventure)]))
        XCTAssertFalse(presentOnGoingProjectDetailsFlag)
        XCTAssertNil(sut.selectedProject)
        sut.didSelectOnGoingProject(MainFeed.Request.SelectOnGoingProject(index: 0))
        let expectedResult = "-MJT-LQSKyEK4fC3hr1g"
        XCTAssertTrue(presentOnGoingProjectDetailsFlag)
        XCTAssertEqual(expectedResult, sut.selectedProject)
    }
    
    func testDidSelectOnGoingProjectCathegory() {
        sut.mainFeedData = MainFeed.Info.Model.UpcomingFeedData(profileSuggestions: MainFeed.Info.Model.UpcomingProfiles(suggestions: [MainFeed.Info.Model.ProfileSuggestion(userId: "idUser1", image: "image", name: "Usuario Teste 1", ocupation: "Artista"), MainFeed.Info.Model.ProfileSuggestion(userId: "idUser2", image: "image", name: "Usuario Teste 2", ocupation: "Artista"), MainFeed.Info.Model.ProfileSuggestion(userId: "idUser3", image: "image", name: "Usuario Teste 3", ocupation: "Artista")]), ongoingProjects: nil, interestCathegories: MainFeed.Info.Model.UpcomingOnGoingProjectCriterias(selectedCriteria: .all, criterias: [.all, .connections,.cathegory(.action), .cathegory(.animation), .cathegory(.adventure)]))
        XCTAssertNil(feedData)
        sut.didSelectOnGoingProjectCathegory(MainFeed.Request.SelectOnGoingProjectCathegory(text: "Todos"))
        let expectedResult =  MainFeed.Info.Model.UpcomingFeedData(profileSuggestions: MainFeed.Info.Model.UpcomingProfiles(suggestions: [MainFeed.Info.Model.ProfileSuggestion(userId: "idUser1", image: "image", name: "Usuario Teste 1", ocupation: "Artista"), MainFeed.Info.Model.ProfileSuggestion(userId: "idUser2", image: "image", name: "Usuario Teste 2", ocupation: "Artista"), MainFeed.Info.Model.ProfileSuggestion(userId: "idUser3", image: "image", name: "Usuario Teste 3", ocupation: "Artista")]), ongoingProjects: MainFeed.Info.Model.UpcomingProjects(projects: [MainFeed.Info.Model.OnGoingProject(id: "-MJT-LQSKyEK4fC3hr1g", image: "https://firebasestorage.googleapis.com/v0/b/lumiere-b1a80.appspot.com/o/projects%2F-MJT-LQSKyEK4fC3hr1g?alt=media&token=96b8b01f-268b-4b5f-b8a4-03d7f5c3e1c9", progress: 67), MainFeed.Info.Model.OnGoingProject(id: "-MJT-LQSKyEK4fC3hr1g", image: "https://firebasestorage.googleapis.com/v0/b/lumiere-b1a80.appspot.com/o/projects%2F-MJT-LQSKyEK4fC3hr1g?alt=media&token=96b8b01f-268b-4b5f-b8a4-03d7f5c3e1c9", progress: 67), MainFeed.Info.Model.OnGoingProject(id: "-MJT-LQSKyEK4fC3hr1g", image: "https://firebasestorage.googleapis.com/v0/b/lumiere-b1a80.appspot.com/o/projects%2F-MJT-LQSKyEK4fC3hr1g?alt=media&token=96b8b01f-268b-4b5f-b8a4-03d7f5c3e1c9", progress: 67), MainFeed.Info.Model.OnGoingProject(id: "-MJT-LQSKyEK4fC3hr1g", image: "https://firebasestorage.googleapis.com/v0/b/lumiere-b1a80.appspot.com/o/projects%2F-MJT-LQSKyEK4fC3hr1g?alt=media&token=96b8b01f-268b-4b5f-b8a4-03d7f5c3e1c9", progress: 67), MainFeed.Info.Model.OnGoingProject(id: "-MJT-LQSKyEK4fC3hr1g", image: "https://firebasestorage.googleapis.com/v0/b/lumiere-b1a80.appspot.com/o/projects%2F-MJT-LQSKyEK4fC3hr1g?alt=media&token=96b8b01f-268b-4b5f-b8a4-03d7f5c3e1c9", progress: 67), MainFeed.Info.Model.OnGoingProject(id: "-MJT-LQSKyEK4fC3hr1g", image: "https://firebasestorage.googleapis.com/v0/b/lumiere-b1a80.appspot.com/o/projects%2F-MJT-LQSKyEK4fC3hr1g?alt=media&token=96b8b01f-268b-4b5f-b8a4-03d7f5c3e1c9", progress: 67)]), interestCathegories: MainFeed.Info.Model.UpcomingOnGoingProjectCriterias(selectedCriteria: .all, criterias: [.all, .connections,.cathegory(.action), .cathegory(.animation), .cathegory(.adventure)]))
        XCTAssertEqual(expectedResult, feedData)
    }
}

extension MainFeedInteractor_Tests: MainFeedPresentationLogic {
    
    func presentSearchResults() {
        self.presentSearchResultsFlag = true
    }
    
    func presentProfileDetails() {
        self.presentProfileDetailsFlag = true
    }
    
    func presentOnGoingProjectDetails() {
        self.presentOnGoingProjectDetailsFlag = true
    }
    
    func presentFeedData(_ response: MainFeed.Info.Model.UpcomingFeedData) {
        self.feedData = response
    }
}
