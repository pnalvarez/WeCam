//
//  SearchResultsModels.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 29/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import ObjectMapper

struct SearchResults {
    
    static let bundle = Bundle(for: SearchResultsController.self)
    
    struct Constants {
        
        struct Colors {
            static let background = UIColor(rgb: 0xe0e0e0)
            static let nameLbl = UIColor(rgb: 0x000000)
            static let ocupationLbl = UIColor(rgb: 0x000000)
            static let searchTextFieldText = UIColor(rgb: 0x000000)
            static let searchTextFieldLayer = UIColor(rgb: 0xe3e0e0).cgColor
            static let dividerView = UIColor(rgb: 0xc4c4c4)
            static let titleLbl = UIColor(rgb: 0x000000)
            static let cathegoriesLbl = UIColor(rgb: 0x000000)
            static let progressLbl = ThemeColors.mainRedColor.rawValue
            static let footerView = UIColor.white
        }
        
        struct Fonts {
            static let nameLbl = ThemeFonts.RobotoBold(16).rawValue
            static let ocupationLbl = ThemeFonts.RobotoRegular(16).rawValue
            static let searchTextField = ThemeFonts.RobotoRegular(16).rawValue
            static let titleLbl = ThemeFonts.RobotoBold(16).rawValue
            static let cathegoriesLbl = ThemeFonts.RobotoRegular(16).rawValue
            static let progressLbl = ThemeFonts.RobotoRegular(16).rawValue
        }
        
        struct Texts {
            
        }
        
        struct Images {
            static let headerImageView = UIImage(named: "tipografia-projeto 2",
                                                 in: SearchResults.bundle,
                                                 compatibleWith: nil)
        }
        
        struct Dimensions {
            
            struct Heights {
                static let defaultCellHeight: CGFloat = 63
            }
        }
    }
    
    struct Info {
        
        struct Received {
            
            struct SearchKey {
                let key: String
            }
        }
        
        struct Model {
            
            enum SelectedItem: Equatable {
                case profile(Profile)
                case project(Project)
            }
            
            struct Results: Equatable {
                let users: [Profile]
                var projects: [Project]
            }
            
            struct Profile: Equatable {
                let id: String
                let name: String
                let image: String
                let ocupation: String
            }
            
            struct Project: Equatable {
                let id: String
                let title: String
                let progress: Int
                let firstCathegory: String
                let secondCathegory: String?
                let image: String
            }
            
            struct ResultError {
                let error: Error
            }
        }
        
        struct ViewModel {
            
            struct UpcomingResults: Equatable {
                let users: [Profile]
                let projects: [Project]
            }
            
            struct Project: Equatable {
                let offset: Int
                let title: String
                let cathegories: String
                let progress: String
                let image: String
            }
            
            struct Profile: Equatable {
                let offset: Int
                let name: String
                let ocupation: String
                let image: String
            }
            
            struct ResultError {
                let error: String
            }
        }
        
        struct Response {
            
            final class Profile: Mappable {
                
                var id: String?
                var name: String?
                var ocupation: String?
                var image: String?
                
                init?(map: Map) { }
                
                func mapping(map: Map) {
                    id <- map["id"]
                    name <- map["name"]
                    ocupation <- map["professional_area"]
                    image <- map["profile_image_url"]
                }
            }
            
            final class Project: Mappable {
                
                var id: String?
                var title: String?
                var progress: Int?
                var firstCathegory: String?
                var secondCathegory: String?
                var image: String?
                
                init?(map: Map) { }
                
                func mapping(map: Map) {
                    id <- map["id"]
                    title <- map["title"]
                    progress <- map["progress"]
                    firstCathegory <- map["firstCathegory"]
                    secondCathegory <- map["secondCathegory"]
                    image <- map["image"]
                }
            }
        }
    }
    
    struct Request {
        
        struct Search {
            
        }
        
        struct SearchWithPreffix {
            let preffix: String
        }
        
        struct SelectItem {
            let index: Int
        }
        
        struct SelectProfile {
            let index: Int
        }
        
        struct SelectProject {
            let index: Int
        }
    }
}

extension SearchResults.Info.Response.Profile: MultipleStubbable {
    static var stubArray: [SearchResults.Info.Response.Profile] {
        return [SearchResults.Info.Response.Profile(JSONString: """
                        {
                            "id": "idUser1",
                            "name": "Usuario Teste 1",
                            "professional_area": "Artist",
                            "profile_image_url": "image"
                        }
                """)!,
                SearchResults.Info.Response.Profile(JSONString: """
                                {
                                    "id": "idUser2",
                                    "name": "Usuario Teste 2",
                                    "professional_area": "Artist",
                                    "profile_image_url": "image"
                                }
                        """)!,
                SearchResults.Info.Response.Profile(JSONString: """
                                {
                                    "id": "idUser3",
                                    "name": "Usuario Teste 3",
                                    "professional_area": "Artist",
                                    "profile_image_url": "image"
                                }
                        """)!]
    }
}

extension SearchResults.Info.Response.Project: MultipleStubbable {
    static var stubArray: [SearchResults.Info.Response.Project] {
        return [SearchResults.Info.Response.Project(JSONString: """
                        {
                            "id": "idProj1",
                            "title": "Projeto Teste 1",
                            "progress": 50,
                            "firstCathegory": "Ação",
                            "secondCathegory": "Animação",
                            "image": "image"
                        }
                """)!,
                SearchResults.Info.Response.Project(JSONString: """
                                {
                                    "id": "idProj2",
                                    "title": "Projeto Teste 2",
                                    "progress": 70,
                                    "firstCathegory": "Ação",
                                    "secondCathegory": "Animação",
                                    "image": "image"
                                }
                        """)!,
                SearchResults.Info.Response.Project(JSONString: """
                                {
                                    "id": "idProj3",
                                    "title": "Projeto Teste 3",
                                    "progress": 50,
                                    "firstCathegory": "Ação",
                                    "secondCathegory": "Animação",
                                    "image": "image"
                                }
                        """)!]
    }
}

extension SearchResults.Info.Model.Results: Stubbable {
    static var stub: SearchResults.Info.Model.Results {
        return SearchResults.Info.Model.Results(users: [SearchResults.Info.Model.Profile(id: "idUser1",
                                                                                         name: "Usuario Teste 1",
                                                                                         image: "image",
                                                                                         ocupation: "Artist"),
                                                        SearchResults.Info.Model.Profile(id: "idUser2",
                                                                                         name: "Usuario Teste 2",
                                                                                         image: "image",
                                                                                         ocupation: "Artist")],
                                                projects: [SearchResults.Info.Model.Project(id: "idProj1",
                                                                                             title: "Projeto Teste 1",
                                                                                             progress: 50,
                                                                                             firstCathegory: "Ação",
                                                                                             secondCathegory: nil,
                                                                                             image: "image"),
                                                           SearchResults.Info.Model.Project(id: "idProj2",
                                                                                            title: "Projeto Teste 2",
                                                                                            progress: 50,
                                                                                            firstCathegory: "Ação",
                                                                                            secondCathegory: nil,
                                                                                            image: "image")
                                                                                         ])
    }
}
