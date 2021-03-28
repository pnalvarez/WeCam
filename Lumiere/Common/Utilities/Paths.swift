//
//  Constants.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 21/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

enum Paths {
    static let usersPath = "users"
    static let profileImagesPath = "profile_images"
    static let projectsPath = "projects"
    static let finishedProjectsPath = "finished"
    static let ongoingProjectsPath = "on_going"
    static let projectImagesPath = "project_images"
    static let allUsersCataloguePath = "all_users"
    static let allProjectsCataloguePath = "all_projects"
    static let finishedProjectsCataloguePath = "finished_projects"
    static let userEmailPath = "user_email"
    static let recentSearchesPath = "recent_searches"
    static let entitiesPath = "entities_identifiers"
}

enum Dimens {
    
    enum Margins {
        static let smallestMargin: CGFloat = 4
        static let smallMargin: CGFloat = 8
        static let defaultMargin: CGFloat = 12
        static let mediumMargin: CGFloat = 16
        static let bigMargin: CGFloat = 24
        static let biggestMargin: CGFloat = 32
    }
}

extension Paths {
    
    static let testImage = UIImage(named: "tipografia-projeto 1")
}


