//
//  ProfileSuggestionsInteractor+Tests.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 27/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

@testable import Lumiere
import XCTest

class ProfileSuggestionsInteractor_Tests: XCTestCase {
    
    var sut: ProfileSuggestionsInteractor!
    var workerMock: ProfileSuggestionsWorkerMock!
    
    var profileSuggestions: ProfileSuggestions.Info.Model.UpcomingSuggestions?
    var presentProfileDetailsFlag = false
    var fadeItem: ProfileSuggestions.Info.Model.ProfileFade?
    var error: ProfileSuggestions.Info.Model.ProfileSuggestionsError?
    var loadingFlag = false
    var criterias: ProfileSuggestions.Info.Model.UpcomingCriteria?
    
    override func setUp() {
        super.setUp()
        workerMock = ProfileSuggestionsWorkerMock()
        sut = ProfileSuggestionsInteractor(worker: workerMock,
                                           presenter: self)
    }
    
    override func tearDown() {
        workerMock = nil
        sut = nil
        profileSuggestions = nil
        presentProfileDetailsFlag = false
        fadeItem = nil
        error = nil
        loadingFlag = false
        criterias = nil
        super.tearDown()
    }
    
    func testFetchProfileSuggestions_CommonConnections() {
        XCTAssertNil(profileSuggestions)
        sut.fetchProfileSuggestions(ProfileSuggestions.Request.FetchProfileSuggestions())
        let expectedResult = ProfileSuggestions
            .Info
            .Model
            .UpcomingSuggestions(profiles: [ProfileSuggestions.Info.Model.Profile(id: "idUser1", name: "Usuario Teste 1", image: "image", ocupation: "Artista"),
                                            ProfileSuggestions.Info.Model.Profile(id: "idUser2", name: "Usuario Teste 2", image: "image", ocupation: "Artista"),
                                            ProfileSuggestions.Info.Model.Profile(id: "idUser3", name: "Usuario Teste 3", image: "image", ocupation: "Artista"),
                                            ProfileSuggestions.Info.Model.Profile(id: "idUser4", name: "Usuario Teste 4", image: "image", ocupation: "Artista"),
                                            ProfileSuggestions.Info.Model.Profile(id: "idUser5", name: "Usuario Teste 5", image: "image", ocupation: "Artista")])
        XCTAssertEqual(expectedResult, profileSuggestions)
        XCTAssertNil(error)
    }
    
    func testFetchProfileSuggestions_CommonProjects() {
        XCTAssertNil(profileSuggestions)
        sut.suggestionCriteria = .commonProjects
        sut.fetchProfileSuggestions(ProfileSuggestions.Request.FetchProfileSuggestions())
        let expectedResult = ProfileSuggestions
            .Info
            .Model
            .UpcomingSuggestions(profiles: [ProfileSuggestions.Info.Model.Profile(id: "idUser1", name: "Usuario Teste 1", image: "image", ocupation: "Artista"),
                                            ProfileSuggestions.Info.Model.Profile(id: "idUser2", name: "Usuario Teste 2", image: "image", ocupation: "Artista"),
                                            ProfileSuggestions.Info.Model.Profile(id: "idUser3", name: "Usuario Teste 3", image: "image", ocupation: "Artista"),
                                            ProfileSuggestions.Info.Model.Profile(id: "idUser4", name: "Usuario Teste 4", image: "image", ocupation: "Artista"),
                                            ProfileSuggestions.Info.Model.Profile(id: "idUser5", name: "Usuario Teste 5", image: "image", ocupation: "Artista")])
        XCTAssertEqual(expectedResult, profileSuggestions)
        XCTAssertNil(error)
    }
    
    func testFetchProfileSuggestions_CommonInterestCathegories() {
        XCTAssertNil(profileSuggestions)
        sut.suggestionCriteria = .commonInterestCathegories
        sut.fetchProfileSuggestions(ProfileSuggestions.Request.FetchProfileSuggestions())
        let expectedResult = ProfileSuggestions
            .Info
            .Model
            .UpcomingSuggestions(profiles: [ProfileSuggestions.Info.Model.Profile(id: "idUser1", name: "Usuario Teste 1", image: "image", ocupation: "Artista"),
                                            ProfileSuggestions.Info.Model.Profile(id: "idUser2", name: "Usuario Teste 2", image: "image", ocupation: "Artista"),
                                            ProfileSuggestions.Info.Model.Profile(id: "idUser3", name: "Usuario Teste 3", image: "image", ocupation: "Artista"),
                                            ProfileSuggestions.Info.Model.Profile(id: "idUser4", name: "Usuario Teste 4", image: "image", ocupation: "Artista"),
                                            ProfileSuggestions.Info.Model.Profile(id: "idUser5", name: "Usuario Teste 5", image: "image", ocupation: "Artista")])
        XCTAssertEqual(expectedResult, profileSuggestions)
        XCTAssertNil(error)
    }
    
    func testFetchAddUser() {
        sut.profileSuggestions = ProfileSuggestions.Info.Model.UpcomingSuggestions(profiles: ProfileSuggestions.Info.Model.Profile.stubArray)
        XCTAssertNil(fadeItem)
        sut.fetchAddUser(ProfileSuggestions.Request.AddUser(index: 0))
        let expectedFadeItem = ProfileSuggestions.Info.Model.ProfileFade(index: 0)
        let expectedSuggestionsCount = 4
        XCTAssertEqual(expectedFadeItem, fadeItem)
        XCTAssertEqual(expectedSuggestionsCount, sut.profileSuggestions?.profiles.count)
    }
    
    func testFetchRemoveUser() {
        sut.profileSuggestions = ProfileSuggestions.Info.Model.UpcomingSuggestions(profiles: ProfileSuggestions.Info.Model.Profile.stubArray)
        XCTAssertNil(fadeItem)
        sut.fetchRemoveUser(ProfileSuggestions.Request.RemoveUser(index: 0))
        let expectedFadeItem = ProfileSuggestions.Info.Model.ProfileFade(index: 0)
        let expectedSuggestionsCount = 4
        XCTAssertEqual(expectedFadeItem, fadeItem)
        XCTAssertEqual(expectedSuggestionsCount, sut.profileSuggestions?.profiles.count)
    }
    
    func testDidSelectProfile() {
        sut.profileSuggestions = ProfileSuggestions.Info.Model.UpcomingSuggestions(profiles: ProfileSuggestions.Info.Model.Profile.stubArray)
        XCTAssertFalse(presentProfileDetailsFlag)
        sut.didSelectProfile(ProfileSuggestions.Request.SelectProfile(index: 0))
        XCTAssertTrue(presentProfileDetailsFlag)
    }
    
    func testDidChangeCriteria_CommonProjects() {
        XCTAssertNil(profileSuggestions)
        sut.didChangeCriteria(ProfileSuggestions.Request.ChangeCriteria(criteria: ProfileSuggestions.Info.Model.SuggestionsCriteria.commonProjects.rawValue))
        let expectedResult = ProfileSuggestions
            .Info
            .Model
            .UpcomingSuggestions(profiles: [ProfileSuggestions.Info.Model.Profile(id: "idUser1", name: "Usuario Teste 1", image: "image", ocupation: "Artista"),
                                            ProfileSuggestions.Info.Model.Profile(id: "idUser2", name: "Usuario Teste 2", image: "image", ocupation: "Artista"),
                                            ProfileSuggestions.Info.Model.Profile(id: "idUser3", name: "Usuario Teste 3", image: "image", ocupation: "Artista"),
                                            ProfileSuggestions.Info.Model.Profile(id: "idUser4", name: "Usuario Teste 4", image: "image", ocupation: "Artista"),
                                            ProfileSuggestions.Info.Model.Profile(id: "idUser5", name: "Usuario Teste 5", image: "image", ocupation: "Artista")])
        XCTAssertEqual(expectedResult, profileSuggestions)
        XCTAssertNil(error)
    }
    
    func testDidChangeCriteria_CommonFriends() {
        XCTAssertNil(profileSuggestions)
        sut.didChangeCriteria(ProfileSuggestions.Request.ChangeCriteria(criteria: ProfileSuggestions.Info.Model.SuggestionsCriteria.commonFriends.rawValue))
        let expectedResult = ProfileSuggestions
            .Info
            .Model
            .UpcomingSuggestions(profiles: [ProfileSuggestions.Info.Model.Profile(id: "idUser1", name: "Usuario Teste 1", image: "image", ocupation: "Artista"),
                                            ProfileSuggestions.Info.Model.Profile(id: "idUser2", name: "Usuario Teste 2", image: "image", ocupation: "Artista"),
                                            ProfileSuggestions.Info.Model.Profile(id: "idUser3", name: "Usuario Teste 3", image: "image", ocupation: "Artista"),
                                            ProfileSuggestions.Info.Model.Profile(id: "idUser4", name: "Usuario Teste 4", image: "image", ocupation: "Artista"),
                                            ProfileSuggestions.Info.Model.Profile(id: "idUser5", name: "Usuario Teste 5", image: "image", ocupation: "Artista")])
        XCTAssertEqual(expectedResult, profileSuggestions)
        XCTAssertNil(error)
    }
    
    func testDidChangeCriteria_CommonInterestCathegories() {
        XCTAssertNil(profileSuggestions)
        sut.didChangeCriteria(ProfileSuggestions.Request.ChangeCriteria(criteria: ProfileSuggestions.Info.Model.SuggestionsCriteria.commonInterestCathegories.rawValue))
        let expectedResult = ProfileSuggestions
            .Info
            .Model
            .UpcomingSuggestions(profiles: [ProfileSuggestions.Info.Model.Profile(id: "idUser1", name: "Usuario Teste 1", image: "image", ocupation: "Artista"),
                                            ProfileSuggestions.Info.Model.Profile(id: "idUser2", name: "Usuario Teste 2", image: "image", ocupation: "Artista"),
                                            ProfileSuggestions.Info.Model.Profile(id: "idUser3", name: "Usuario Teste 3", image: "image", ocupation: "Artista"),
                                            ProfileSuggestions.Info.Model.Profile(id: "idUser4", name: "Usuario Teste 4", image: "image", ocupation: "Artista"),
                                            ProfileSuggestions.Info.Model.Profile(id: "idUser5", name: "Usuario Teste 5", image: "image", ocupation: "Artista")])
        XCTAssertEqual(expectedResult, profileSuggestions)
        XCTAssertNil(error)
    }
    
    func testFetchCriterias() {
        XCTAssertNil(criterias)
        sut.fetchCriterias(ProfileSuggestions.Request.FetchCriteria())
        let expectedResult = ProfileSuggestions.Info.Model.UpcomingCriteria(selectedCriteria: .commonFriends, criterias: [.commonFriends, .commonProjects, .commonInterestCathegories])
        XCTAssertEqual(expectedResult, criterias)
    }
}

extension ProfileSuggestionsInteractor_Tests: ProfileSuggestionsPresentationLogic {
    
    func presentProfileSuggestions(_ response: ProfileSuggestions.Info.Model.UpcomingSuggestions) {
        self.profileSuggestions = response
    }
    
    func presentProfileDetails() {
        self.presentProfileDetailsFlag = true
    }
    
    func presentFadeItem(_ response: ProfileSuggestions.Info.Model.ProfileFade) {
        self.fadeItem = response
    }
    
    func presentError(_ response: ProfileSuggestions
                        .Info
                        .Model
                        .ProfileSuggestionsError) {
        self.error = response
    }
    
    func presentLoading(_ loading: Bool) {
        self.loadingFlag = loading
    }
    
    func presentCriterias(_ response: ProfileSuggestions.Info.Model.UpcomingCriteria) {
        self.criterias = response
    }
}
