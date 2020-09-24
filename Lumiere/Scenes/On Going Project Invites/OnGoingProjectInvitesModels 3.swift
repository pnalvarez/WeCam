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
            static let searchTextFieldText = UIColor(rgb: 0x000000)
            static let searchTextFieldLayer = UIColor(rgb: 0xe3e0e0e0).cgColor
        }
        
        struct Fonts {
            static let nameLbl = ThemeFonts.RobotoBold(16).rawValue
            static let ocupationLbl = ThemeFonts.RobotoRegular(16).rawValue
            static let emailLbl = ThemeFonts.RobotoRegular(16).rawValue
            static let projectTitleLbl = ThemeFonts.RobotoRegular(16).rawValue
            static let searchTextField = ThemeFonts.RobotoRegular(16).rawValue
        }
        
        struct Texts {
            static let removeUserAlert = "Deseja remover este usuário do projeto?"
            static let removeInvite = "Deseja desfazer o convite que fez a este usuário?"
            static let acceptUserAlert = "Aceita este usuário como membro do projeto?"
        }
        
        struct Images {
            static let invite = UIImage(named: "icone-usuario-sem-relação-com-o-projeto 1", in: OnGoingProjectInvites.bundle, compatibleWith: nil)
            static let member = UIImage(named: "icone-usuario-participante", in: OnGoingProjectInvites.bundle, compatibleWith: nil)
            static let receivedRequest = UIImage(named: "icone-usuario-convidado-projeto", in: OnGoingProjectInvites.bundle, compatibleWith: nil)
            static let sentRequest = UIImage(named: "icone-solicitou-projeto", in: OnGoingProjectInvites.bundle, compatibleWith: nil)
        }
        
        struct Dimensions {
            
            struct Heights {
                static let cellHeight: CGFloat = 123
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
                var relation: Relation?
            }
            
            struct Project {
                let projectId: String
                let title: String
                let image: String
                let authorId: String
            }
            
            struct Alert {
                let text: String
            }
            
            struct RelationUpdate {
                let index: Int
                let relation: Relation
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
                let relation: UIImage?
            }
            
            struct Project {
                let title: String
            }
            
            struct Alert {
                let text: String
            }
            
            struct ErrorViewModel {
                let title: String
                let message: String
            }
            
            struct RelationUpdate {
                let index: Int
                let relation: UIImage?
            }
        }
        
        struct Response {
            
            final class User: Mappable {
                
                var id: String?
                var image: String?
                var name: String?
                var ocupation: String?
                var email: String?
                
                init?(map: Map) { }
                
                func mapping(map: Map) {
                    id <- map["userId"]
                    image <- map["image"]
                    name <- map["name"]
                    ocupation <- map["ocupation"]
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
                var image: String?
                var authorId: String?
                
                init?(map: Map) { }
                
                func mapping(map: Map) {
                    title <- map["title"]
                    image <- map["image"]
                    authorId <- map["author_id"]
                }
            }
        }
    }
    
    struct Request {
        
        struct RemoveInvite {
            let userId: String
            let projectId: String
        }
        
        struct InviteUser {
            let userId: String
            let projectId: String
            let projectImage: String
            let projectTitle: String
            let authorId: String
        }
        
        struct AcceptUser {
            let userId: String
            let projectId: String
        }
        
        struct RefuseUser {
            let userId: String
            let projectId: String
        }
        
        struct RemoveUserFromProject {
            let userId: String
            let projectId: String
        }
         
        struct FetchUsers {
            
        }
        
        struct FetchProject {
            
        }
        
        struct FetchProjectWithId {
            let id: String
        }
        
        struct FetchRelation {
            let userId: String
            let projectId: String
            let index: Int
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
