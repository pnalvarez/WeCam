//
//  OnGoingProjectDetailsModels.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 22/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import ObjectMapper

struct OnGoingProjectDetails {
    
    static let bundle = Bundle(for: OnGoingProjectDetailsController.self)
    
    struct Constants {
        
        struct Colors {
            static let moreInfoButtonText = UIColor(rgb: 0x000000)
            static let containerInfoBackground = UIColor(rgb: 0xffffff)
            static let containerInfoLayer = UIColor(rgb: 0xe3e0e0).cgColor
            static let titleLbl = UIColor(rgb: 0x707070)
            static let sinopsisLbl = UIColor(rgb: 0x000000)
            static let teamFixedLbl = UIColor(rgb: 0x707070)
            static let needFixedLbl = UIColor(rgb: 0x707070)
            static let dotView = ThemeColors.mainRedColor.rawValue
            static let needValueLbl = UIColor(rgb: 0x000000)
            static let activity = ThemeColors.mainRedColor.rawValue
            static let activityBackground = UIColor(rgb: 0xffffff).withAlphaComponent(0.5)
        }
        
        struct Fonts {
            static let moreInfoButton = ThemeFonts.RobotoRegular(16).rawValue
            static let titleLbl = ThemeFonts.RobotoBold(16).rawValue
            static let sinopsisLbl = ThemeFonts.RobotoRegular(12).rawValue
            static let teamFixedLbl = ThemeFonts.RobotoRegular(16).rawValue
            static let needFixedLbl = ThemeFonts.RobotoRegular(16).rawValue
            static let needValueLbl = ThemeFonts.RobotoRegular(16).rawValue
        }
        
        struct Texts {
            static let moreInfoButton = "+ informações"
            static let teamFixedLbl = "Equipe"
            static let needFixedLbl = "Precisam de"
        }
        
        struct Images {
            
        }
    }
    
    struct Info {
        
        struct Received {
        
            struct Project {
                let projectId: String
            }
        }
        
        struct Model {
            
            struct Project {
                let id: String
                let image: String?
                let title: String
                let sinopsis: String
                var teamMembers: [TeamMember]
                let needing: String
            }
            
            struct TeamMember {
                let id: String
                let name: String
                let ocupation: String
                let image: String?
            }
        }
        
        struct ViewModel {
            
            struct Project {
                let image: String?
                let title: String
                let sinopsis: String
                let teamMembers: [TeamMember]
                let needing: String
            }
            
            struct TeamMember {
                let id: String
                let image: String?
                let name: String
                let ocupation: String
            }
        }
        
        struct Response {
            
            final class Project: Mappable {
                
                var authorId: String?
                var cathegories: [String]?
                var image: String?
                var needing: String?
                var progress: Float?
                var title: String?
                var sinopsis: String?
                var participants: [String]?
                
                init?(map: Map) { }
                
                func mapping(map: Map) {
                    authorId <- map["author_id"]
                    cathegories <- map["cathegories"]
                    image <- map["image"]
                    needing <- map["needing"]
                    progress <- map["progress"]
                    title <- map["title"]
                    sinopsis <- map["sinopsis"]
                    participants <- map["participants"]
                }
            }
            
            final class TeamMember: Mappable {
                
                var name: String?
                var ocupation: String?
                var image: String?
                
                init?(map: Map) { }
                
                func mapping(map: Map) {
                    name <- map["name"]
                    ocupation <- map["professional_area"]
                    image <- map["profile_image_url"]
                }
            }
        }
    }
    
    struct Request {
        
        struct FetchProject {
            
        }
        
        struct FetchProjectWithId {
            let id: String
        }
        
        struct FetchUserWithId {
            let id: String
        }
        
        struct SelectedTeamMember {
            let index: Int
        }
        
        struct MoreInfo {
            
        }
    }
}
