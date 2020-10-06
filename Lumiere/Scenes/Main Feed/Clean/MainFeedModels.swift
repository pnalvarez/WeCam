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
        }
        
        struct Fonts {
            static let searchTextField = ThemeFonts.RobotoRegular(14).rawValue
            static let recentSearchTitle = ThemeFonts.RobotoBold(16).rawValue
        }
        
        struct Texts {
            
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
                static let headerCell: CGFloat = 60
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
            
            struct SearchKey {
                let key: String
            }
            
            struct RecentSearch {
                let id: String
                let image: String
                let title: String
                let type: ItemType
            }
        }
        
        struct ViewModel {
            
            struct RecentSearch: Equatable {
                let image: String
                let title: String
            }
        }
        
        struct Response {
            
        }
    }
    
    struct Request {
        
        struct Search {
            let key: String
        }
    }
}
