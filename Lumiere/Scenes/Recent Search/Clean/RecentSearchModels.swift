//
//  RecentSearchModels.swift
//  WeCam
//
//  Created by Pedro Alvarez on 10/03/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit
import ObjectMapper

struct RecentSearch {
    
    struct Constants {
        
        struct Colors {
            static let searchLbl = ThemeColors.alertGray.rawValue
        }
        
        struct Fonts {
            static let searchLbl = ThemeFonts.RobotoBold(16).rawValue
        }
        
        struct Texts {
            static let searchLbl = "Pesquisas Recentes"
            static let errorDefaultTitle = "Ocorreu um erro"
        }
        
        struct Images { }
        
        struct Dimensions {
            
            struct Heights {
                static let recentSearchTableViewCell: CGFloat = 63
            }
        }
        
        struct BusinessLogic { }
    }
    
    struct Info {
        
        struct Received { }
        
        struct Response {
            
            final class Search: Mappable {
                
                var id: String?
                var type: String?
                
                init?(map: Map) { }
                
                func mapping(map: Map) {
                    id <- map["id"]
                    type <- map["type"]
                }
            }
            
            final class User: Mappable {
                
                var userId: String?
                var image: String?
                var name: String?
                var ocupation: String?
                
                init?(map: Map) { }
                
                func mapping(map: Map) {
                    userId <- map["userId"]
                    image <- map["profile_image_url"]
                    name <- map["name"]
                    ocupation <- map["professional_area"]
                }
            }
            
            final class Project: Mappable {
                
                var projectId: String?
                var image: String?
                var title: String?
                var cathegories: [String]?
                
                init?(map: Map) { }
                
                func mapping(map: Map) {
                    projectId <- map["projectId"]
                    image <- map["image"]
                    title <- map["title"]
                    cathegories <- map["cathegories"]
                }
            }
        }
        
        struct Model {
            
            enum SearchType: String {
                case user = "user"
                case ongoingProject = "ongoing_project"
                case finishedProject = "finished_project"
            }
            
            enum Search {
                case user(user: UserSearch)
                case project(project: ProjectSearch)
            }
            
            struct UpcomingResults {
                var results: [Search]
            }
            
            struct UserSearch {
                let userId: String
                let image: String
                let name: String
                let ocupation: String
            }
            
            struct ProjectSearch {
                let projectId: String
                let image: String
                let title: String
                let firstCathegory: String
                let secondCathegory: String?
                let finished: Bool
            }
            
            struct Error {
                let title: String
                let message: String
            }
        }
        
        struct ViewModel {
            
            struct UpcomingResults {
                let searches: [Search]
            }
            
            struct Search {
                let image: String
                let name: String
                let secondaryInfo: String
            }
            
            struct Error {
                let title: String
                let message: String
            }
        }
    }
    
    struct Request {
        
        struct FetchRecentSearches { }
        
        struct SelectSearch {
            let index: Int
        }
        
        struct SearchAction {
            let text: String
        }
        
        struct FetchUserData {
            let userId: String
        }
        
        struct FetchProjectData {
            let projectId: String
        }
        
        struct RegisterSearch {
            let id: String
            let type: String
        }
    }
}
