//
//  OnGoingProjectInvitesModels.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 12/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import ObjectMapper

struct OnGoingProjectInvites {
    
    static let bundle = Bundle(for: OnGoingProjectInvitesController.self)
    
    struct Constants {
        
        struct Colors {
            static let nameLbl = UIColor(rgb: 0x000000)
            static let ocupationLbl = UIColor(rgb: 0x000000)
            static let emailLbl = UIColor(rgb: 0x000000)
            static let projectTitleLbl = UIColor(rgb: 0x707070)
            static let searchTextField = UIColor(rgb: 0x000000)
        }
        
        struct Fonts {
            static let nameLbl = ThemeFonts.RobotoBold(16).rawValue
            static let ocupationLbl = ThemeFonts.RobotoRegular(16).rawValue
            static let emailLbl = ThemeFonts.RobotoRegular(16).rawValue
            static let projectTitleLbl = ThemeFonts.RobotoRegular(16).rawValue
            static let searchTextField = ThemeFonts.RobotoRegular(16).rawValue
        }
        
        struct Texts {
            
        }
        
        struct Images {
            static let invite = UIImage(named: "icone-usuario-sem-relacao-com-o-projeto 1", in: OnGoingProjectInvites.bundle, compatibleWith: nil)
            static let member = UIImage(named: "icone-conexao-feita 1", in: OnGoingProjectInvites.bundle, compatibleWith: nil)
            static let receivedRequest = UIImage(named: "icone-pendente 1", in: OnGoingProjectInvites.bundle, compatibleWith: nil)
            static let sentRequest = UIImage(named: "pendente 1", in: OnGoingProjectInvites.bundle, compatibleWith: nil)
        }
        
        struct Dimensions {
            
            struct Heights {
                static let cellHeight: CGFloat = 112
            }
        }
    }
    
    struct Info {
        
        struct Received {
            
            struct Project {
                let projectId: String
            }
        }
        
        struct Model {
            
            enum Relation {
                case simpleParticipant
                case sentRequest
                case receivedRequest
                case nothing
            }
            
            struct UpcomingUsers {
                var users: [User]
            }
            
            struct User {
                let userId: String
                let image: String
                let name: String
                let ocupation: String
                let email: String
                let relation: Relation
            }
            
            struct Project {
                let projectId: String
                let title: String
            }
            
            struct Alert {
                let text: String
            }
        }
        
        struct ViewModel {
            
            struct UpcomingUsers {
                let users: [User]
            }
            
            struct User {
                let image: String
                let name: String
                let ocupation: String
                let email: NSAttributedString
                let relation: Model.Relation
            }
            
            struct Project {
                let title: String
            }
            
            struct Alert {
                let text: String
            }
        }
        
        struct Response {
            
            final class User: Mappable {
                
                var image: String?
                var name: String?
                var ocupation: String?
                var email: String?
                
                init?(map: Map) { }
                
                func mapping(map: Map) {
                    image <- map["profile_image_url"]
                    name <- map["name"]
                    ocupation <- map["professional_area"]
                    email <- map["email"]
                }
            }
            
            final class UserRelation: Mappable {
                
                var relation: String?
                
                init?(map: Map) { }
                
                func mapping(map: Map) {
                    relation <- map["relation"]
                }
            }
            
            final class Project: Mappable {
                
                var title: String?
                
                init?(map: Map) { }
                
                func mapping(map: Map) {
                    title <- map["title"]
                }
            }
        }
    }
    
    struct Request {
         
        struct FetchUsers {
            
        }
        
        struct FetchProject {
            
        }
        
        struct Interaction {
            let index: Int
        }
        
        struct ConfirmInteraction {
            
        }
        
        struct RefuseInteraction {
            
        }
        
        struct Search {
            let preffix: String
        }
        
        struct SelectUser {
            let index: Int
        }
    }
}
