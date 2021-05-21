//
//  ProfileSuggestionsModels.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 10/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit
import ObjectMapper

struct ProfileSuggestions {
    
    static let bundle = Bundle(for: ProfileSuggestionsController.self)
    
    struct Constants {
        
        struct Colors {
            static let mainLbl = ThemeColors.hex707070.rawValue
            static let nameLbl = UIColor(rgb: 0x000000)
            static let ocupationLbl = UIColor(rgb: 0x000000)
            static let addButtonBackground = ThemeColors.mainRedColor.rawValue
            static let addButtonText = ThemeColors.whiteThemeColor.rawValue
            static let removeButtonBackground = UIColor(rgb: 0xededed)
            static let removeButtonText = UIColor(rgb: 0x000000)
        }
        
        struct Fonts {
            static let mainLbl = ThemeFonts.RobotoBold(16).rawValue
            static let nameLbl = ThemeFonts.RobotoBold(16).rawValue
            static let ocupationLbl = ThemeFonts.RobotoRegular(16).rawValue
            static let addButton = ThemeFonts.RobotoBold(16).rawValue
            static let removeButton = ThemeFonts.RobotoBold(16).rawValue
        }
        
        struct Texts {
            static let mainLbl = "Sugestões de Perfil"
            static let addButton = "Adicionar"
            static let removeButton = "Remover"
            static let emptySuggestions = "Nenhuma sugestão no momento :("
        }
        
        struct Images {
            static let lumiere = UIImage(named: "tipografia-projeto 2",
                                         in: ProfileSuggestions.bundle,
                                         compatibleWith: nil)
        }
        
        struct Dimensions {
            
            struct Heights {
                static let defaultCellHeight: CGFloat = 128
            }
        }
        
        struct BusinessLogic {
            static let suggestionsLimit: Int = 20
        }
    }
    
    struct Info {
        
        struct Response {
            
            final class UpcomingSuggestions: Mappable {
                
                var profiles: [Profile]?
                
                init?(map: Map) { }
                
                func mapping(map: Map) {
                    profiles <- map["profiles"]
                }
            }
            
            final class Profile: Mappable {
                
                var id: String?
                var name: String?
                var image: String?
                var ocupation: String?
                
                init?(map: Map) { }
                
                func mapping(map: Map) {
                    id <- map["id"]
                    name <- map["name"]
                    image <- map["profile_image_url"]
                    ocupation <- map["professional_area"]
                }
            }
        }
        
        struct Model {
            
            enum SuggestionsCriteria: String, CaseIterable {
                case commonFriends = "  Amigos em comum"
                case commonProjects = "  Projetos em comum"
                case commonInterestCathegories = "  Categorias em comum"
                
                static func toArray() -> [Self] {
                    var criterias = [Self]()
                    for criteria in allCases {
                        criterias.append(criteria)
                    }
                    return criterias
                }
            }
            
            struct UpcomingCriteria: Equatable {
                let criterias: [SuggestionsCriteria]
            }
            
            struct UpcomingSuggestions: Equatable {
                var profiles: [Profile]
            }
            
            struct Profile: Equatable {
                let id: String
                let name: String
                let image: String
                let ocupation: String
            }
            
            struct ProfileFade: Equatable {
                let index: Int
            }
            
            struct ProfileSuggestionsError {
                let error: WCError
            }
        }
        
        struct ViewModel {
            
            struct UpcomingCriteria: Equatable {
                let criterias: [String]
            }
            
            struct UpcomingSuggestions: Equatable {
                var profiles: [Profile]
            }
            
            struct Profile: Equatable {
                let name: String
                let image: String
                let ocupation: String
            }
            
            struct ProfileItemToFade: Equatable {
                let index: Int
            }
            
            struct ProfileSuggestionsError {
                let error: String
            }
        }
        
        struct Received {
            
        }
    }
    
    struct Request {
        
        struct FetchCriteria {
            
        }
        
        struct FetchProfileSuggestions {
            
        }
        
        struct AddUser {
            let index: Int
        }
        
        struct RemoveUser {
            let index: Int
        }
        
        struct AddUserWithId {
            let userId: String
        }
        
        struct RemoveUserWithId {
            let userId: String
        }
        
        struct SelectProfile {
            let index: Int
        }
        
        struct ChangeCriteria {
            let index: Int
        }
        
        struct FetchCommonConnectionsProfileSuggestions {
            let limit: Int
        }
        
        struct FetchCommonProjectsProfileSuggestions {
            let limit: Int
        }
        
        struct FetchCommonCathegoriesProfileSuggestions {
            let limit: Int
        }
        
        struct SendConnectionRequest {
            let userId: String
        }
        
        struct RemoveSuggestion {
            let userId: String
        }
    }
}

extension ProfileSuggestions.Info.Response.Profile: MultipleStubbable {
    static var stubArray: [ProfileSuggestions.Info.Response.Profile] {
        return [ProfileSuggestions
                    .Info
                    .Response
                    .Profile(JSONString: """
                            {
                                "id": "idUser1",
                                "name": "Usuario Teste 1",
                                "profile_image_url": "image",
                                "professional_area": "Artista"
                            }
                    """)!,
                ProfileSuggestions
                            .Info
                            .Response
                            .Profile(JSONString: """
                                    {
                                        "id": "idUser2",
                                        "name": "Usuario Teste 2",
                                        "profile_image_url": "image",
                                        "professional_area": "Artista"
                                    }
                            """)!,
                ProfileSuggestions
                            .Info
                            .Response
                            .Profile(JSONString: """
                                    {
                                        "id": "idUser3",
                                        "name": "Usuario Teste 3",
                                        "profile_image_url": "image",
                                        "professional_area": "Artista"
                                    }
                            """)!,
                ProfileSuggestions
                            .Info
                            .Response
                            .Profile(JSONString: """
                                    {
                                        "id": "idUser4",
                                        "name": "Usuario Teste 4",
                                        "profile_image_url": "image",
                                        "professional_area": "Artista"
                                    }
                            """)!,
                ProfileSuggestions
                            .Info
                            .Response
                            .Profile(JSONString: """
                                    {
                                        "id": "idUser5",
                                        "name": "Usuario Teste 5",
                                        "profile_image_url": "image",
                                        "professional_area": "Artista"
                                    }
                            """)!]
    }
}

extension ProfileSuggestions.Info.Model.Profile: MultipleStubbable {
    static var stubArray: [ProfileSuggestions.Info.Model.Profile] {
        return [ProfileSuggestions.Info.Model.Profile(id: "idUser1",
                                                      name: "Usuario Teste 1",
                                                      image: "image",
                                                      ocupation: "Artista"),
                ProfileSuggestions.Info.Model.Profile(id: "idUser2",
                                                      name: "Usuario Teste 2",
                                                      image: "image",
                                                      ocupation: "Artista"),
                ProfileSuggestions.Info.Model.Profile(id: "idUser3",
                                                      name: "Usuario Teste 3",
                                                      image: "image",
                                                      ocupation: "Artista"),
                ProfileSuggestions.Info.Model.Profile(id: "idUser4",
                                                      name: "Usuario Teste 4",
                                                      image: "image",
                                                      ocupation: "Artista"),
                ProfileSuggestions.Info.Model.Profile(id: "idUser5",
                                                      name: "Usuario Teste 5",
                                                      image: "image",
                                                      ocupation: "Artista")]
    }
}

extension ProfileSuggestions.Info.Model.ProfileFade: Stubbable {
    static var stub: ProfileSuggestions.Info.Model.ProfileFade {
        return ProfileSuggestions.Info.Model.ProfileFade(index: 0)
    }
}

extension ProfileSuggestions.Info.Model.UpcomingCriteria: Stubbable {
    static var stub: ProfileSuggestions.Info.Model.UpcomingCriteria {
        return ProfileSuggestions.Info.Model.UpcomingCriteria(criterias: [.commonFriends, .commonProjects, .commonInterestCathegories])
    }
}
