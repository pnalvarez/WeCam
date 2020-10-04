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
    
    func testFetchBeginSearch() {
        
    }
    
    func testFetchSearch() {
        sut.fetchSearch(SearchResults.Request.SearchWithPreffix(preffix: "Test"))
        let expectedResult = SearchResults.Info.Model.Results(users: [SearchResults.Info.Model.Profile(id: "idUser1", name: "Usuario Teste 1", image: "image", ocupation: "Artist"), SearchResults.Info.Model.Profile(id: "idUser2", name: "Usuario Teste 2", image: "image", ocupation: "Artist"), SearchResults.Info.Model.Profile(id: "idUser3", name: "Usuario Teste 3", image: "image", ocupation: "Artist")], projects: [SearchResults.Info.Model.Project(id: "idProj1", title: "Projeto Teste 1", progress: 50, firstCathegory: "Ação", secondCathegory: "Animação", image: "image"), SearchResults.Info.Model.Project(id: "idProj2", title: "Projeto Teste 2", progress: 70, firstCathegory: "Ação", secondCathegory: "Animação", image: "image"), SearchResults.Info.Model.Project(id: "idProj3", title: "Projeto Teste 3", progress: 50, firstCathegory: "Ação", secondCathegory: "Animação", image: "image")])
        XCTAssertEqual(expectedResult, results)
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
    
    func testFetchSelectProject() {
        sut.results = SearchResults.Info.Model.Results.stub
        XCTAssertNil(sut.selectedItem)
        XCTAssertFalse(presentProjectDetailsFlag)
        sut.fetchSelectProject(SearchResults.Request.SelectProject(index: 0))
        let expectedResult = SearchResults.Info.Model.SelectedItem.project(SearchResults.Info.Model.Project(id: "idProj1",
                                                                                                            title: "Projeto Teste 1", progress: 50, firstCathegory: "Ação", secondCathegory: nil, image:
                                                                                                            "image"))
        XCTAssertEqual(expectedResult, sut.selectedItem)
        XCTAssertTrue(presentProjectDetailsFlag)
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
