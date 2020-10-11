//
//  MainFeedModels.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
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
        }
        
        struct Fonts {
            static let searchTextField = ThemeFonts.RobotoRegular(14).rawValue
            static let recentSearchTitle = ThemeFonts.RobotoBold(16).rawValue
            static let profileSuggestionsHeaderLbl = ThemeFonts.RobotoBold(16).rawValue
            static let profileSuggestionsSeeAllButton = ThemeFonts.RobotoBold(16).rawValue
        }
        
        struct Texts {
            static let profileSuggestionsHeaderLbl = "Sugestões de Perfil"
            static let profileSuggestionsSeeAllButton = "Ver Tudo"
        }
        
        struct Images {
            static let lumiere = UIImage(named: "tipografia-projeto 2",
                                         in: MainFeed.bundle,
                                         compatibleWith: nil)
            static let tabBarImage = UIImage(named: "home-antes-de-clicar 1",
                                             in: MainFeed.bundle,
                                             compatibleWith: nil)
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
                static let profileSuggestionsCell: CGFloat = 170
            }
        }
        
        struct BusinessLogic {
            static let suggestionsLimit: Int = 10
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
            
            struct SearchKey {
                let key: String
            }
            
            struct RecentSearch {
                let id: String
                let image: String
                let title: String
                let type: ItemType
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
        }
        
        struct ViewModel {
            
            struct RecentSearch: Equatable {
                let image: String
                let title: String
            }
            
            struct UpcomingProfiles: Equatable {
                let suggestions: [ProfileSuggestion]
            }
            
            struct ProfileSuggestion: Equatable {
                let image: String
                let name: String
                let ocupation: String
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
        }
    }
    
    struct Request {
        
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
        
        struct FetchSuggestedProfiles {
            
        }
    }
}
