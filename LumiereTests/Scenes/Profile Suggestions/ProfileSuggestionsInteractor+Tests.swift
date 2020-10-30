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
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
}

extension ProfileSuggestionsInteractor_Tests: ProfileSuggestionsPresentationLogic {
    
    func presentProfileSuggestions(_ response: ProfileSuggestions.Info.Model.UpcomingSuggestions) {
        
    }
    
    func presentProfileDetails() {
        <#code#>
    }
    
    func presentFadeItem(_ response: ProfileSuggestions.Info.Model.ProfileFade) {
        <#code#>
    }
    
    func presentError(_ response: ProfileSuggestions.Info.Model.ProfileSuggestionsError) {
        <#code#>
    }
    
    func presentLoading(_ loading: Bool) {
        <#code#>
    }
    
    func presentCriterias(_ response: ProfileSuggestions.Info.Model.UpcomingCriteria) {
        <#code#>
    }
}
