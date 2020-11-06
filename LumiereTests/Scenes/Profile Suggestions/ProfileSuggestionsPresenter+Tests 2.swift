//
//  ProfileSuggestionsPresenter+Tests.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 02/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

@testable import Lumiere
import XCTest

class ProfileSuggestionsPresenter_Tests: XCTestCase {
    
    var sut: ProfileSuggestionsPresenter!
    
    var suggestions: ProfileSuggestions.Info.ViewModel.UpcomingSuggestions?
    var fadeItem: ProfileSuggestions.Info.ViewModel.ProfileItemToFade?
    var displayProfileDetailsFlag = false
    var error: ProfileSuggestions.Info.ViewModel.ProfileSuggestionsError?
    var loadingFlag = false
    var criterias: ProfileSuggestions.Info.ViewModel.UpcomingCriteria?
    
    override func setUp() {
        super.setUp()
        sut = ProfileSuggestionsPresenter(viewController: self)
    }
    
    override func tearDown() {
        sut = nil
        suggestions = nil
        fadeItem = nil
        displayProfileDetailsFlag = false
        error = nil
        loadingFlag = false
        criterias = nil
        super.tearDown()
    }
    
    func testPresentProfileSuggestions() {
        XCTAssertNil(suggestions)
        sut.presentProfileSuggestions(ProfileSuggestions.Info.Model.UpcomingSuggestions(profiles: ProfileSuggestions.Info.Model.Profile.stubArray))
        let expectedResult = ProfileSuggestions.Info.ViewModel.UpcomingSuggestions(profiles: [ProfileSuggestions.Info.ViewModel.Profile(name: "Usuario Teste 1", image: "image", ocupation: "Artista"), ProfileSuggestions.Info.ViewModel.Profile(name: "Usuario Teste 2", image: "image", ocupation: "Artista"), ProfileSuggestions.Info.ViewModel.Profile(name: "Usuario Teste 3", image: "image", ocupation: "Artista"), ProfileSuggestions.Info.ViewModel.Profile(name: "Usuario Teste 4", image: "image", ocupation: "Artista"), ProfileSuggestions.Info.ViewModel.Profile(name: "Usuario Teste 5", image: "image", ocupation: "Artista")])
        XCTAssertEqual(expectedResult, suggestions)
        XCTAssertNil(error)
    }
    
    func testPresentProfileDetails() {
        XCTAssertFalse(displayProfileDetailsFlag)
        sut.presentProfileDetails()
        XCTAssertTrue(displayProfileDetailsFlag)
    }
    
    func testPresentFadeItem() {
        XCTAssertNil(fadeItem)
        sut.presentFadeItem(ProfileSuggestions.Info.Model.ProfileFade.stub)
        let expectedResult = ProfileSuggestions.Info.ViewModel.ProfileItemToFade(index: 0)
        XCTAssertEqual(expectedResult, fadeItem)
        XCTAssertNil(error)
    }
    
    func testPresentError() {
        XCTAssertNil(error)
        sut.presentError(ProfileSuggestions.Info.Model.ProfileSuggestionsError(error: FirebaseErrors.genericError))
        XCTAssertNotNil(error)
    }
    
    func testPresentLoading() {
        XCTAssertFalse(loadingFlag)
        sut.presentLoading(true)
        XCTAssertTrue(loadingFlag)
    }
}

extension ProfileSuggestionsPresenter_Tests: ProfileSuggestionsDisplayLogic {
    
    func displayProfileSuggestions(_ viewModel: ProfileSuggestions.Info.ViewModel.UpcomingSuggestions) {
        self.suggestions = viewModel
    }
    
    func fadeProfileItem(_ viewModel: ProfileSuggestions.Info.ViewModel.ProfileItemToFade) {
        self.fadeItem = viewModel
    }
    
    func displayProfileDetails() {
        self.displayProfileDetailsFlag = true
    }
    
    func displayError(_ viewModel: ProfileSuggestions.Info.ViewModel.ProfileSuggestionsError) {
        self.error = viewModel
    }
    
    func displayLoading(_ loading: Bool) {
        self.loadingFlag = loading
    }
    
    func displayCriterias(_ viewModel: ProfileSuggestions.Info.ViewModel.UpcomingCriteria) {
        self.criterias = viewModel
    }
}
