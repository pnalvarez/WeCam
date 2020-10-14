//
//  SearchResultsPresenter+Tests.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 04/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import XCTest
@testable import Lumiere

class SearchResultsPresenter_Tests: XCTestCase {
    
    var sut: SearchResultsPresenter!
    
    var results: SearchResults.Info.ViewModel.UpcomingResults?
    var displayProfileDetailsFlag = false
    var displayProjectDetailsFlag = false
    var loadingFlag = false
    var error: SearchResults.Info.ViewModel.ResultError?
    
    override func setUp() {
        super.setUp()
        sut = SearchResultsPresenter(viewController: self)
    }
    
    override func tearDown() {
        sut = nil
        results = nil
        displayProfileDetailsFlag = false
        displayProjectDetailsFlag = false
        loadingFlag = false
        error = nil
        super.tearDown()
    }
    
    func testPresentLoading() {
        XCTAssertFalse(loadingFlag)
        sut.presentLoading(true)
        XCTAssertTrue(loadingFlag)
    }
    
    func testPresentResults() {
        XCTAssertNil(results)
        sut.presentResults(SearchResults.Info.Model.Results.stub)
        let expectedResult = SearchResults.Info.ViewModel.UpcomingResults(users: [SearchResults.Info.ViewModel.Profile(offset: 0, name: "Usuario Teste 1", ocupation: "Artist", image: "image"), SearchResults.Info.ViewModel.Profile(offset: 1, name: "Usuario Teste 2", ocupation: "Artist", image: "image")], projects: [SearchResults.Info.ViewModel.Project(offset: 0, title: "Projeto Teste 1", cathegories: "Ação", progress: "50 %", image: "image"), SearchResults.Info.ViewModel.Project(offset: 1, title: "Projeto Teste 2", cathegories: "Ação", progress: "50 %", image: "image")])
        XCTAssertEqual(expectedResult, results)
    }
    
    func testPresentProfileDetails() {
        XCTAssertFalse(displayProfileDetailsFlag)
        sut.presentProfileDetails()
        XCTAssertTrue(displayProfileDetailsFlag)
    }
    
    func testPresentProjectDetails() {
        XCTAssertFalse(displayProjectDetailsFlag)
        sut.presentProjectDetails()
        XCTAssertTrue(displayProjectDetailsFlag)
    }
    
    func testPresentError() {
        XCTAssertNil(error)
        sut.presentError(SearchResults.Info.Model.ResultError(error: FirebaseErrors.genericError))
        XCTAssertNotNil(error)
    }
}

extension SearchResultsPresenter_Tests: SearchResultsDisplayLogic {
    
    func displaySearchResults(_ viewModel: SearchResults.Info.ViewModel.UpcomingResults) {
        self.results = viewModel
    }
    
    func displayProfileDetails() {
        self.displayProfileDetailsFlag = true
    }
    
    func displayProjectDetails() {
        self.displayProjectDetailsFlag = true
    }
    
    func displayLoading(_ loading: Bool) {
        self.loadingFlag = loading
    }
    
    func displayError(_ viewModel: SearchResults.Info.ViewModel.ResultError) {
        self.error = viewModel
    }
}
