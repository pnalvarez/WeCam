//
//  EditProfileDetailsPresenter+Tests.swift
//  LumiereTests
//
//  Created by Pedro Alvarez on 29/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import XCTest
@testable import Lumiere

class EditProfileDetailsPresenter_Tests: XCTestCase {

    var sut: EditProfileDetailsPresenter!
    
    var user: EditProfileDetails.Info.ViewModel.User?
    var cathegories: EditProfileDetails.Info.ViewModel.Cathegories?
    var displayProfileDetailsFlag = false
    var loadingFlag = false
    var error: String?
    
    override func setUp() {
        super.setUp()
        sut = EditProfileDetailsPresenter(viewController: self)
    }

    override func tearDown() {
        sut = nil
        user = nil
        cathegories = nil
        displayProfileDetailsFlag = false
        loadingFlag = false
        error = nil
        super.tearDown()
    }
    
    func testPresentUserData() {
        XCTAssertNil(user)
        XCTAssertNil(cathegories)
        sut.presentUserData(EditProfileDetails.Info.Model.User(id: "idUser", image: "image", name: "Usuario Teste", cellphone: "123456789", ocupation: "Artista", interestCathegories: EditProfileDetails.Info.Model.InterestCathegories(cathegories: .empty)))
        let expectedUser = EditProfileDetails.Info.ViewModel.User(image: "image", name: "Usuario Teste", cellphone: "123456789", ocupation: "Artista")
        let expectedCathegories = EditProfileDetails.Info.ViewModel.Cathegories(cathegories: EditProfileDetails.Info.Model.InterestCathegories(cathegories: .empty))
        XCTAssertEqual(expectedUser, user)
        XCTAssertEqual(expectedCathegories, cathegories)
    }
    
    func testDidUpdateUser() {
        XCTAssertFalse(displayProfileDetailsFlag)
        sut.didUpdateUser()
        XCTAssertTrue(displayProfileDetailsFlag)
    }
    
    func testPresentLoading() {
        XCTAssertFalse(loadingFlag)
        sut.presentLoading(true)
        XCTAssertTrue(loadingFlag)
    }
    
    func testPresentServerError() {
        XCTAssertNil(error)
        sut.presentServerError(FirebaseErrors.genericError)
        XCTAssertNotNil(error)
    }
    
    func testPresentInputError() {
        XCTAssertNil(error)
        sut.presentInputError(EditProfileDetails.Errors.InputErrors.cellphoneInvalid)
        XCTAssertNotNil(error)
    }
    
    func testPresentCathegories() {
        XCTAssertNil(cathegories)
        sut.presentCathegories(EditProfileDetails.Info.Model.InterestCathegories(cathegories: .empty))
        let expectedResult = EditProfileDetails.Info.ViewModel.Cathegories(cathegories: EditProfileDetails.Info.Model.InterestCathegories(cathegories: .empty))
        XCTAssertEqual(expectedResult, cathegories)
    }
}

extension EditProfileDetailsPresenter_Tests: EditProfileDetailsDisplayLogic {
    
    func displayUserData(_ viewModel: EditProfileDetails.Info.ViewModel.User, cathegories: EditProfileDetails.Info.ViewModel.Cathegories) {
        self.user = viewModel
        self.cathegories = cathegories
    }
    
    func displayProfileDetails() {
        self.displayProfileDetailsFlag = true
    }
    
    func displayLoading(_ loading: Bool) {
        self.loadingFlag = true
    }
    
    func displayError(_ viewModel: String) {
        self.error = viewModel
    }
    
    func displayInterestCathegories(_ viewModel: EditProfileDetails.Info.ViewModel.Cathegories) {
        self.cathegories = viewModel
    }
}
