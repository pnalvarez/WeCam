//
//  FinishedProjectDetailsModels.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 08/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import ObjectMapper

struct FinishedProjectDetails {
    
    struct Constants {
        
        struct Colors {
            static let titleLbl = UIColor(rgb: 0x000000)
            static let sinopsisLbl = UIColor(rgb: 0x000000)
            static let containerViewLayer = UIColor(rgb: 0xe3e0e0).cgColor
            static let containerViewBackground = UIColor(rgb: 0xffffff)
            static let teamFixedLbl = UIColor(rgb: 0x707070)
            static let watchButtonBackground = ThemeColors.mainRedColor.rawValue
            static let watchButtonText = ThemeColors.whiteThemeColor.rawValue
            static let interactionButtonBackground = UIColor(rgb: 0xededed)
            static let interactionButtonLayer = UIColor(rgb: 0xe3e0e0).cgColor
            static let interactionButtonText = UIColor(rgb: 0x000000)
            static let moreInfoButtonText = UIColor(rgb: 0x000000)
            static let moreInfoButtonBackground = UIColor(rgb: 0xffffff)
        }
        
        struct Fonts {
            static let titleLbl = ThemeFonts.RobotoRegular(16).rawValue
            static let sinopsisLbl = ThemeFonts.RobotoRegular(12).rawValue
            static let teamFixedLbl = ThemeFonts.RobotoRegular(16).rawValue
            static let watchButton = ThemeFonts.RobotoRegular(16).rawValue
            static let interactionButton = ThemeFonts.RobotoRegular(16).rawValue
            static let moreInfoButton = ThemeFonts.RobotoRegular(16).rawValue
        }
        
        struct Texts {
            static let teamFixedLbl = "Equipe"
            static let watchButton = "Assistir"
            static let interactionInviteFriends = "Convidar amigos"
            static let interactionExit = "Sair do projeto"
            static let interactionAcceptInvite = "Responder convite"
            static let moreInfoButton = "+ informações"
        }
        
        struct Images {
            
        }
        
        struct BusinessLogic {
            
        }
        
        struct Dimensions {
            
        }
    }
    
    struct Info {
        
        struct Received {
            
            struct Project {
                let id: String
                let userIdsNotInvited: [String]
            }
            
            struct Routing {
                let routingMethod: RoutingMethod
            }
        }
        
        struct Response {
            
            final class Project: Mappable {
                
                var authorId: String?
                var cathegories: [String]?
                var image: String?
                var needing: String?
                var progress: Int?
                var title: String?
                var sinopsis: String?
                var participants: [String]?
                var finishDate: Int?
                
                init?(map: Map) { }
                
                func mapping(map: Map) {
                    authorId <- map["author_id"]
                    cathegories <- map["cathegories"]
                    image <- map["image"]
                    title <- map["title"]
                    sinopsis <- map["sinopsis"]
                    participants <- map["participants"]
                    finishDate <- map["finish_date"]
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
            
            final class ProjectRelation: Mappable {
                var relation: String?
                
                init?(map: Map) { }
                
                func mapping(map: Map) {
                    relation <- map["relation"]
                }
            }
        }
        
        struct Model {
            
            struct Project {
                let id: String
                let image: String
                let title: String
                let sinopsis: String
                var participants: [TeamMember]
            }
            
            struct TeamMember {
                let id: String
                let name: String
                let ocupation: String
                let image: String
            }
            
            enum ProjectRelation {
                case author
                case simpleParticipant
                case receivedInvite
                case nothing
            }
            
            struct Relation {
                let relation: ProjectRelation
            }
            
            struct Routing {
                let method: RoutingMethod
            }
        }
        
        struct ViewModel {
            
            struct Project {
                let image: String
                let title: String
                let sinopsis: String
                let participants: [TeamMember]
            }
            
            struct TeamMember {
                let id: String
                let image: String
                let name: String
                let ocupation: String
            }
            
            struct Relation {
                let relation: Model.ProjectRelation
            }
            
            struct Routing {
                let method: RoutingMethod
            }
        }
    }
    
    struct Request {
        
        struct FetchProjectData {
            
        }
        
        struct FetchProjectDataWithId {
            let id: String
        }
        
        struct ProjectRelation {
            
        }

        struct ProjectRelationWithId {
            let projectId: String
        }
        
        struct Interaction {
            
        }
        
        struct AcceptInvite {
            let projectId: String
        }
        
        struct RefuseInvite {
            let projectId: String
        }
        
        struct FetchTeamMembers {
            
        }
        
        struct FetchTeamMembersWithId {
            let id: String
        }
    }
}
