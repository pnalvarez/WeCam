//
//  EditProfileDetailsInteractor+Tests.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 28/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import XCTest
@testable import Lumiere

class EditProfileDetailsInteractor_Tests: XCTestCase {

    var sut: EditProfileDetailsInteractor!
    var workerMock: EditProfileDetailsWorkerProtocol!
    
    var userData: EditProfileDetails.Info.Model.User?
    var didUpdateUserFlag = false
    var loadingFlag = false
    var serverError: Error?
    var inputErrors: EditProfileDetails.Errors.InputErrors?
    var interestCathegories: EditProfileDetails.Info.Model.InterestCathegories?

    override func setUp() {
        super.setUp()
        workerMock = EditProfileDetailsWorkerMock()
        sut = EditProfileDetailsInteractor(worker: workerMock, presenter: self)
    }
    
    override func tearDown() {
        workerMock = nil
        sut = nil
        userData = nil
        didUpdateUserFlag = false
        serverError = nil
        inputErrors = nil
        interestCathegories = nil
        super.tearDown()
    }
    
    func testFetchUserData() {
        XCTAssertNil(userData)
        sut.fetchUserData(EditProfileDetails.Request.UserData())
        let expectedResult = EditProfileDetails.Info.Model.User(id: "idUser", image: "image", name: "Usuario Teste", cellphone: "(20)2827-2933", ocupation: .empty, interestCathegories: EditProfileDetails.Info.Model.InterestCathegories(cathegories: [EditProfileDetails.Info.Model.Cathegory(style: .action, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .animation, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .adventure, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .comedy, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .drama, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .dance, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .documentary, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .fiction, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .war, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .musical, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .police, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .series, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .suspense, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .horror, selected: false)]))
        XCTAssertEqual(expectedResult, userData)
    }
    
    func testDidSelectCathegory() {
        sut.cathegoriesData = EditProfileDetails.Info.Model.InterestCathegories(cathegories: [EditProfileDetails.Info.Model.Cathegory(style: .action, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .animation, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .adventure, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .comedy, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .drama, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .dance, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .documentary, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .fiction, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .war, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .musical, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .police, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .series, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .suspense, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .horror, selected: false)])
        sut.userData = EditProfileDetails.Info.Model.User(id: "idUser", image: "image", name: "Usuario Teste", cellphone: "(20)2827-2933", ocupation: .empty, interestCathegories: EditProfileDetails.Info.Model.InterestCathegories(cathegories: [EditProfileDetails.Info.Model.Cathegory(style: .action, selected: true), EditProfileDetails.Info.Model.Cathegory(style: .animation, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .adventure, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .comedy, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .drama, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .dance, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .documentary, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .fiction, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .war, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .musical, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .police, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .series, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .suspense, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .horror, selected: false)]))
        XCTAssertNil(interestCathegories)
        sut.didSelectCathegory(EditProfileDetails.Request.SelectCathegory(index: 0))
        let expectedResult = EditProfileDetails.Info.Model.InterestCathegories(cathegories: [EditProfileDetails.Info.Model.Cathegory(style: .action, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .animation, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .adventure, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .comedy, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .drama, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .dance, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .documentary, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .fiction, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .war, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .musical, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .police, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .series, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .suspense, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .horror, selected: false)])
        XCTAssertEqual(expectedResult, interestCathegories)
    }

    func testFetchFinish_Success() {
        sut.userData = EditProfileDetails.Info.Model.User(id: "idUser", image: "image", name: "Usuario Teste", cellphone: "123456789012345", ocupation: .empty, interestCathegories: EditProfileDetails.Info.Model.InterestCathegories(cathegories: [EditProfileDetails.Info.Model.Cathegory(style: .action, selected: true), EditProfileDetails.Info.Model.Cathegory(style: .animation, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .adventure, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .comedy, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .drama, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .dance, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .documentary, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .fiction, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .war, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .musical, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .police, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .series, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .suspense, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .horror, selected: false)]))
        sut.cathegoriesData = EditProfileDetails.Info.Model.InterestCathegories(cathegories: [EditProfileDetails.Info.Model.Cathegory(style: .action, selected: true), EditProfileDetails.Info.Model.Cathegory(style: .animation, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .adventure, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .comedy, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .drama, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .dance, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .documentary, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .fiction, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .war, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .musical, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .police, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .series, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .suspense, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .horror, selected: false)])
        XCTAssertFalse(didUpdateUserFlag)
        sut.fetchFinish(EditProfileDetails.Request.Finish(image: Data(), name: "Usuario Novo Teste", cellphone: "123456789012345", ocupation: "Artista"))
        XCTAssertTrue(didUpdateUserFlag)
    }

    func testFetchFinish_InputErrors() {
        XCTAssertNil(inputErrors)
        sut.userData = EditProfileDetails.Info.Model.User(id: "idUser", image: "image", name: "Usuario Teste", cellphone: "123456789012345", ocupation: .empty, interestCathegories: EditProfileDetails.Info.Model.InterestCathegories(cathegories: [EditProfileDetails.Info.Model.Cathegory(style: .action, selected: true), EditProfileDetails.Info.Model.Cathegory(style: .animation, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .adventure, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .comedy, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .drama, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .dance, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .documentary, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .fiction, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .war, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .musical, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .police, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .series, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .suspense, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .horror, selected: false)]))
        sut.cathegoriesData = EditProfileDetails.Info.Model.InterestCathegories(cathegories: [EditProfileDetails.Info.Model.Cathegory(style: .action, selected: true), EditProfileDetails.Info.Model.Cathegory(style: .animation, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .adventure, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .comedy, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .drama, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .dance, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .documentary, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .fiction, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .war, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .musical, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .police, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .series, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .suspense, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .horror, selected: false)])
        sut.fetchFinish(EditProfileDetails.Request.Finish(image: Data(), name: "Usuario Novo Teste", cellphone: "123456789012", ocupation: "Artista"))
        XCTAssertNotNil(inputErrors)
    }
    
    func testFetchFinish_ServerError() {
        sut.userData = EditProfileDetails.Info.Model.User(id: "idUser", image: "image", name: "Usuario Teste", cellphone: "123456789012345", ocupation: .empty, interestCathegories: EditProfileDetails.Info.Model.InterestCathegories(cathegories: [EditProfileDetails.Info.Model.Cathegory(style: .action, selected: true), EditProfileDetails.Info.Model.Cathegory(style: .animation, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .adventure, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .comedy, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .drama, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .dance, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .documentary, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .fiction, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .war, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .musical, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .police, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .series, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .suspense, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .horror, selected: false)]))
        sut.cathegoriesData = EditProfileDetails.Info.Model.InterestCathegories(cathegories: [EditProfileDetails.Info.Model.Cathegory(style: .action, selected: true), EditProfileDetails.Info.Model.Cathegory(style: .animation, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .adventure, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .comedy, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .drama, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .dance, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .documentary, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .fiction, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .war, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .musical, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .police, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .series, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .suspense, selected: false), EditProfileDetails.Info.Model.Cathegory(style: .horror, selected: false)])
        XCTAssertNil(serverError)
        sut.fetchFinish(EditProfileDetails.Request.Finish(image: Data(), name: "ERROR MOCK", cellphone: "123456789012345", ocupation: "Artista"))
        XCTAssertNotNil(serverError)
    }
}

extension EditProfileDetailsInteractor_Tests: EditProfileDetailsPresentationLogic {
    
    func presentUserData(_ response: EditProfileDetails.Info.Model.User) {
        self.userData = response
    }
    
    func didUpdateUser() {
        self.didUpdateUserFlag = true
    }
    
    func presentLoading(_ loading: Bool) {
        self.loadingFlag = true
    }
    
    func presentServerError(_ response: Error) {
        self.serverError = response
    }
    
    func presentInputError(_ response: EditProfileDetails.Errors.InputErrors) {
        self.inputErrors = response
    }
    
    func presentCathegories(_ response: EditProfileDetails.Info.Model.InterestCathegories) {
        self.interestCathegories = response
    }
}
