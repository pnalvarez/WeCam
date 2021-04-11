//
//  MainFeedModels.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit
import ObjectMapper

struct MainFeed {
    
    static let bundle = Bundle(for: MainFeedController.self)
    
    struct Constants {
        
        struct Colors {
            static let searchTextFieldText = UIColor(rgb: 0x000000)
            static let searchTextFieldLayer = UIColor(rgb: 0xe3e0e0).cgColor
            static let dividerView = UIColor(rgb: 0xc4c4c4)
            static let recentSearchTitle = UIColor(rgb: 0x000000)
            static let profileSuggestionsHeaderLbl = UIColor(rgb: 0x969494)
            static let profileSuggestionsSeeAllButton = ThemeColors.mainRedColor.rawValue
            static let ongoingProjectsHeaderLbl = UIColor(rgb: 0x969494)
            static let optionButtonUnselected = ThemeColors.whiteThemeColor.rawValue
            static let optionButtonSelected = UIColor(rgb: 0xe3e0e0)
            static let finishedProjectFeedFixedLbl = UIColor(rgb: 0x969494)
        }
        
        struct Fonts {
            static let searchTextField = ThemeFonts.RobotoRegular(14).rawValue
            static let recentSearchTitle = ThemeFonts.RobotoBold(16).rawValue
            static let profileSuggestionsHeaderLbl = ThemeFonts.RobotoBold(16).rawValue
            static let profileSuggestionsSeeAllButton = ThemeFonts.RobotoBold(16).rawValue
            static let ongoingProjectsHeaderLbl = ThemeFonts.RobotoBold(16).rawValue
            static let finishedProjectFeedFixedLbl = ThemeFonts.RobotoBold(16).rawValue
        }
        
        struct Texts {
            static let profileSuggestionsHeaderLbl = "Sugestões de Perfil"
            static let profileSuggestionsSeeAllButton = "Ver Tudo"
            static let ongoingProjectsHeaderLbl = "Projetos em Andamento"
            static let allCriteria = "Todos"
            static let relativeToConnectionsCriteria = "Conexões"
            static let genericError = "Ocorreu um erro genérico"
            static let emptySearchErrorTitle = "Busca vazia"
            static let emptySearchErrorMessage = "Insira alguma palavra a procurar usuários ou projetos"
        }
        
        struct Images {
            static let lumiere = UIImage(named: "tipografia-projeto 2",
                                         in: MainFeed.bundle,
                                         compatibleWith: nil)
            static let tabBarImage = UIImage(named: "home-antes-de-clicar 1",
                                             in: MainFeed.bundle,
                                             compatibleWith: nil)?.withRenderingMode(.alwaysOriginal)
            static let tabBarSelectedImage = UIImage(named: "home-depois-de-clicar 1",
                                                     in: MainFeed.bundle,
                                                     compatibleWith: nil)
            static let search = UIImage(named: "lupa",
                                        in: MainFeed.bundle,
                                        compatibleWith: nil)
        }
        
        struct Dimensions {
            
            struct Heighs {
                static let headerCell: CGFloat = 85
                static let recentSearchCell: CGFloat = 34
                static let profileSuggestionsCell: CGFloat = 190
                static let ongoingProjectsFeedCell: CGFloat = 150
                static let ongoingProjectsResumeButton: CGFloat = 95
                static let finishedProjectButton: CGFloat = 182
                static let finishedProjectsFeedCell: CGFloat = 238
            }
            
            struct Widths {
                static let ongoingProjectResumeButton: CGFloat = 86
                static let ongoingProjectsFeedOffset: CGFloat = 22
                static let ongoingProfojectsFeedInterval: CGFloat = 10
                static let finishedProjectButton: CGFloat = 128
                static let finishedProjectsFeedOffset: CGFloat = 22
                static let finishedProjectsFeedInterval: CGFloat = 15
            }
        }
        
        struct BusinessLogic {
            
            static let suggestionsLimit: Int = 10
            static let ongoingProjectsLimit: Int = 50
            static let finishedProjectsLimit: Int = 50
            
            enum CellIndexes: Int {
                case search = 0
                case profileSuggestions = 1
                case ongoingProjectsSuggestions = 2
                case finishedProjects = 3
            }
            
            enum Sections: Int {
                case defaultFeed = 0
                case finishedProjects = 1
            }
        }
    }
    
    struct Info {
        
        struct Received {
            
            struct CurrentUser {
                let currentUserId: String
            }
        }
        
        struct Model {
            
            enum ItemType {
                case profile
                case project
            }
            
            enum FinishedProjectsFeedLogicCriteria: String {
                case connections = "Conexões"
                case popular = "Popular"
                case recentlyWatched = "Recente"
            }
            
            struct SearchKey: Equatable {
                let key: String
            }
            
            struct RecentSearch {
                let id: String
                let image: String
                let title: String
                let type: ItemType
            }
            
            struct UpcomingFeedData: Equatable {
                var profileSuggestions: UpcomingProfiles?
                var ongoingProjects: UpcomingProjects?
                var interestCathegories: UpcomingOnGoingProjectCriterias?
                var finishedProjectsFeeds: UpcomingFinishedProjectsFeeds?
            }
            
            struct UpcomingProfiles: Equatable {
                let suggestions: [ProfileSuggestion]
            }
            
            struct ProfileSuggestion: Equatable{
                let userId: String
                let image: String
                let name: String
                let ocupation: String
            }
            
            struct UpcomingProjects: Equatable {
                let projects: [OnGoingProject]
            }
            
            struct OnGoingProject: Equatable {
                let id: String
                let image: String
                let progress: Int
            }
            
            struct UpcomingFinishedProjectsFeeds: Equatable {
                var feeds: [FinishedProjectFeed]
            }
            
            struct FinishedProjectFeed: Equatable {
                let criteria: String
                let projects: [FinishedProject]
            }
            
            struct FinishedProject: Equatable {
                let id: String
                let image: String
            }
            
            enum OnGoingProjectFeedCriteria: Equatable {
                case all
                case connections
                case cathegory(_ style: MovieStyle)
                
                func mapToString() -> String {
                    switch self {
                    case .all:
                        return MainFeed.Constants.Texts.allCriteria
                    case .connections:
                        return MainFeed.Constants.Texts.relativeToConnectionsCriteria
                    case .cathegory(let style):
                        return style.rawValue
                    }
                }
            }
            
            struct UpcomingOnGoingProjectCriterias: Equatable {
                var selectedCriteria: OnGoingProjectFeedCriteria
                var criterias: [OnGoingProjectFeedCriteria]
            }
            
            struct Error {
                let title: String
                let message: String
            }
        }
        
        struct ViewModel {
            
            struct RecentSearch: Equatable {
                let image: String
                let title: String
            }
            
            struct UpcomingFeedData: Equatable {
                let suggestedProfiles: UpcomingProfiles
                let ongoingProjects: UpcomingProjects
                let interestCathegories: UpcomingOnGoingProjectsCriterias
                let finishedProjects: UpcomingFinishedProjectsFeeds
            }
            
            struct UpcomingProfiles: Equatable {
                let suggestions: [ProfileSuggestion]
            }
            
            struct ProfileSuggestion: Equatable {
                let image: String
                let name: String
                let ocupation: String
            }
            
            struct UpcomingProjects: Equatable {
                let projects: [OnGoingProject]
            }
            
            struct OnGoingProject: Equatable {
                let image: String
                let progress: Float
            }
            
            struct OnGoingProjectFeedCriteria: Equatable {
                let criteria: String
            }
            
            struct UpcomingOnGoingProjectsCriterias: Equatable {
                let selectedCriteria: OnGoingProjectFeedCriteria
                let criterias: [OnGoingProjectFeedCriteria]
            }
            
            struct UpcomingFinishedProjectsFeeds: Equatable {
                let feeds: [FinishedProjectFeed]
            }
            
            struct FinishedProjectFeed: Equatable {
                let criteria: String
                let projects: [FinishedProject]
            }
            
            struct FinishedProject: Equatable {
                let image: String
            }
            
            struct Error {
                let title: String
                let message: String
            }
        }
        
        struct Response {
            
            final class RecentSearch: Mappable {

                var image: String?
                var title: String?
                
                init?(map: Map) { }
                
                func mapping(map: Map) {
                    image <- map["image"]
                    title <- map["title"]
                }
            }
            
            final class ProfileSuggestion: Mappable {
                
                var userId: String?
                var image: String?
                var name: String?
                var ocupation: String?
                
                init?(map: Map) { }
                
                func mapping(map: Map) {
                    userId <- map["id"]
                    image <- map["profile_image_url"]
                    name <- map["name"]
                    ocupation <- map["professional_area"]
                }
            }
            
            final class OnGoingProject: Mappable {
                
                var id: String?
                var image: String?
                var progress: Int?
                
                init?(map: Map) { }
                
                func mapping(map: Map) {
                    id <- map["id"]
                    image <- map["image"]
                    progress <- map["progress"]
                }
            }
            
            final class InterestCathegories: Mappable {
                
                var cathegories: [String]?
                
                init?(map: Map) { }
                
                func mapping(map: Map) {
                    cathegories <- map["interest_cathegories"]
                }
            }
            
            final class FinishedProject: Mappable {
                
                var id: String?
                var image: String?
                
                init?(map: Map) { }
                
                func mapping(map: Map) {
                    id <- map["id"]
                    image <- map["image"]
                }
            }
        }
    }
    
    struct Request {
        
        struct MainFeed {
            
        }
        
        struct Search {
            let key: String
        }
        
        struct RecentSearches {
            
        }
        
        struct FetchData {
            let id: String
        }
        
        struct SelectSuggestedProfile {
            let index: Int
        }
        
        struct SelectOnGoingProject {
            let index: Int
        }
        
        struct FetchSuggestedProfiles {
            
        }
        
        struct FetchOnGoingProjects {
            let fromConnections: Bool
            let cathegory: String
        }
        
        struct RequestOnGoingProjectsFeed {
            let item: String
        }
        
        struct FetchInterestCathegories {
            
        }
        
        struct SelectOnGoingProjectCathegory {
            let text: String
        }
        
        struct FinishedProjectsLogicFeed {
            let criteria: String
        }
        
        struct FinishedProjectsCathegoryFeed {
            let cathegory: String
        }
        
        struct SelectFinishedProject {
            let projectIndex: Int
            let catheghoryIndex: Int
        }
        
        struct FinishedProjectsNewFeed {
            
        }
    }
}

extension MainFeed.Info.Response.OnGoingProject: MultipleStubbable {
    static var stubArray: [MainFeed.Info.Response.OnGoingProject] {
        return [MainFeed.Info.Response.OnGoingProject(JSONString: """
                        {
                            "id": "-MJT-LQSKyEK4fC3hr1g",
                            "image": "https://firebasestorage.googleapis.com/v0/b/lumiere-b1a80.appspot.com/o/projects%2F-MJT-LQSKyEK4fC3hr1g?alt=media&token=96b8b01f-268b-4b5f-b8a4-03d7f5c3e1c9",
                            "progress": 67
                        }
                """)!,
                MainFeed.Info.Response.OnGoingProject(JSONString: """
                                {
                                    "id": "-MJT-LQSKyEK4fC3hr1g",
                                    "image": "https://firebasestorage.googleapis.com/v0/b/lumiere-b1a80.appspot.com/o/projects%2F-MJT-LQSKyEK4fC3hr1g?alt=media&token=96b8b01f-268b-4b5f-b8a4-03d7f5c3e1c9",
                                    "progress": 67
                                }
                        """)!,
                MainFeed.Info.Response.OnGoingProject(JSONString: """
                                {
                                    "id": "-MJT-LQSKyEK4fC3hr1g",
                                    "image": "https://firebasestorage.googleapis.com/v0/b/lumiere-b1a80.appspot.com/o/projects%2F-MJT-LQSKyEK4fC3hr1g?alt=media&token=96b8b01f-268b-4b5f-b8a4-03d7f5c3e1c9",
                                    "progress": 67
                                }
                        """)!,
                MainFeed.Info.Response.OnGoingProject(JSONString: """
                                {
                                    "id": "-MJT-LQSKyEK4fC3hr1g",
                                    "image": "https://firebasestorage.googleapis.com/v0/b/lumiere-b1a80.appspot.com/o/projects%2F-MJT-LQSKyEK4fC3hr1g?alt=media&token=96b8b01f-268b-4b5f-b8a4-03d7f5c3e1c9",
                                    "progress": 67
                                }
                        """)!,
                MainFeed.Info.Response.OnGoingProject(JSONString: """
                                {
                                    "id": "-MJT-LQSKyEK4fC3hr1g",
                                    "image": "https://firebasestorage.googleapis.com/v0/b/lumiere-b1a80.appspot.com/o/projects%2F-MJT-LQSKyEK4fC3hr1g?alt=media&token=96b8b01f-268b-4b5f-b8a4-03d7f5c3e1c9",
                                    "progress": 67
                                }
                        """)!,
                MainFeed.Info.Response.OnGoingProject(JSONString: """
                                {
                                    "id": "-MJT-LQSKyEK4fC3hr1g",
                                    "image": "https://firebasestorage.googleapis.com/v0/b/lumiere-b1a80.appspot.com/o/projects%2F-MJT-LQSKyEK4fC3hr1g?alt=media&token=96b8b01f-268b-4b5f-b8a4-03d7f5c3e1c9",
                                    "progress": 67
                                }
                        """)!]
    }
}

extension MainFeed.Info.Response.ProfileSuggestion: MultipleStubbable {
    static var stubArray: [MainFeed.Info.Response.ProfileSuggestion] = [
        MainFeed.Info.Response.ProfileSuggestion(JSONString: """
                        {
                            "id": "idUser1",
                            "profile_image_url": "image",
                            "name": "Usuario Teste 1",
                            "professional_area": "Artista"
                        }
        """)!,
        MainFeed.Info.Response.ProfileSuggestion(JSONString: """
                        {
                            "id": "idUser2",
                            "profile_image_url": "image",
                            "name": "Usuario Teste 2",
                            "professional_area": "Artista"
                        }
        """)!,
        MainFeed.Info.Response.ProfileSuggestion(JSONString: """
                        {
                            "id": "idUser3",
                            "profile_image_url": "image",
                            "name": "Usuario Teste 3",
                            "professional_area": "Artista"
                        }
        """)!
    ]
}

extension MainFeed.Info.Response.InterestCathegories: Stubbable {
    static var stub: MainFeed.Info.Response.InterestCathegories =
        MainFeed.Info.Response.InterestCathegories(JSON: ["interest_cathegories": ["Ação", "Animação", "Aventura"]])!
}

extension MainFeed.Info.Model.UpcomingFeedData: Stubbable {
    static var stub: MainFeed.Info.Model.UpcomingFeedData {
        return MainFeed
            .Info
            .Model
            .UpcomingFeedData(profileSuggestions: MainFeed
                                .Info
                                .Model
                                .UpcomingProfiles(suggestions: [MainFeed
                                                                    .Info
                                                                    .Model
                                                                    .ProfileSuggestion(userId: "idUser1",
                                                                                       image: "image",
                                                                                       name: "Usuario Teste 1",
                                                                                       ocupation: "Artista")]), ongoingProjects: MainFeed
                                                                                        .Info
                                                                                        .Model
                                                                                        .UpcomingProjects(projects: [MainFeed.Info.Model.OnGoingProject(id: "idProj1",
                                                                                                                                                        image: "image", progress: 0)]), interestCathegories: MainFeed.Info.Model.UpcomingOnGoingProjectCriterias(selectedCriteria: .all, criterias: [.all, .connections, .cathegory(.action)]))
    }
}
