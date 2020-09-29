//
//  SearchResultsInteractor+Tests.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 29/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import XCTest
@testable import Lumiere

class SearchResultsInteractor_Tests: XCTestCase {

    var sut: SearchResultsInteractor!
    var workerMock: SearchResultsWorkerMock!
    
    var loadingFlag = false
    var results: SearchResults.Info.Model.Results?
    var presentProfileDetailsFlag = false
    var presentProjectDetailsFlag = false

    override func setUp() {
        super.setUp()
        workerMock = SearchResultsWorkerMock()
        sut = SearchResultsInteractor(worker: workerMock,
                                      presenter: self)
    }
    
    override func tearDown() {
        sut = nil
        workerMock = nil
        loadingFlag = false
        results = nil
        presentProfileDetailsFlag = false
        presentProjectDetailsFlag = false
        super.tearDown()
    }
    
    func testFetchSelectProfile() {
        sut.results = SearchResults.Info.Model.Results.stub
        XCTAssertNil(sut.selectedItem)
        XCTAssertFalse(presentProjectDetailsFlag)
        sut.fetchSelectProfile(SearchResults.Request.SelectProfile(index: 0))
        XCTAssertEqual(sut.selectedItem, SearchResults
                        .Info
                        .Model
                        .SelectedItem.profile(SearchResults.Info.Model.Profile(id: "idUser1",
                                                                               name: "Usuario Teste 1",
                                                                               image: "image",
                                                                               ocupation: "Artist")))
        XCTAssertTrue(presentProfileDetailsFlag)
    }
}

extension SearchResultsInteractor_Tests: SearchResultsPresentationLogic {
    
    func presentLoading(_ loading: Bool) {
        self.loadingFlag = true
    }
    
    func presentResults(_ response: SearchResults.Info.Model.Results) {
        self.results = response
    }
    
    func presentProfileDetails() {
        self.presentProfileDetailsFlag = true
    }
    
    func presentProjectDetails() {
        self.presentProjectDetailsFlag = true
    }
}
