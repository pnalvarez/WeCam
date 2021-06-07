//
//  InviteProfileToProjectsModels.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 13/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit
import ObjectMapper

struct InviteProfileToProjects {
    
    static let bundle = Bundle(for: InviteProfileToProjectsController.self)
    
    struct Constants {
        
        struct Colors {
            static let nameLbl = UIColor(rgb: 0x707070)
            static let cathegoriesLbl = UIColor(rgb: 0x969494)
            static let mainLbl = UIColor(rgb: 0x000000)
            static let searchTextFieldText = UIColor(rgb: 0x000000)
            static let searchTextFieldLayer = UIColor(rgb: 0xe3e0e0).cgColor
            static let translucentView = UIColor.white.withAlphaComponent(0.5)
            static let progressLbl = ThemeColors.mainRedColor.rawValue
        }
        
        struct Fonts {
            static let nameLbl = ThemeFonts.RobotoBold(18).rawValue
            static let cathegoriesLbl = ThemeFonts.RobotoRegular(16).rawValue
            static let mainLbl = ThemeFonts.RobotoRegular(16).rawValue
            static let searchTextField = ThemeFonts.RobotoRegular(16).rawValue
            static let progressLbl = ThemeFonts.RobotoBold(16).rawValue
        }
        
        struct Texts {
            static let mainLbl = "Convidar para projeto"
            static let participatingAlert = "Deseja remover este usuário do projeto?"
            static let sentRequestAlert = "Deseja aceitar este usuário no projeto?"
            static let emptyText = "Você não possui projetos para convidar este usuário"
        }
        
        struct Images {
            static let participating = UIImage(named: "icone-usuario-participante", in: InviteProfileToProjects.bundle, compatibleWith: nil)
            static let receivedRequest = UIImage(named: "icone-usuario-convidado-projeto", in: InviteProfileToProjects.bundle, compatibleWith: nil)
            static let sentRequest = UIImage(named: "icone-solicitou-projeto", in: InviteProfileToProjects.bundle, compatibleWith: nil)
            static let nothing = UIImage(named: "icone-usuario-sem-relação-com-o-projeto 1", in: ProjectInvites.bundle, compatibleWith: nil)
        }
        
        struct Dimensions {
            
            struct Heights {
                static let cellHeight: CGFloat = 132
            }
        }
    }
    
    struct Info {
        
        struct Received {
            
            struct User {
                let userId: String
            }
        }
        
        struct Model {
            
            enum Relation {
                case participating
                case sentRequest
                case receivedRequest
                case nothing
            }
            
            struct Alert {
                let text: String
            }
            
            struct RelationUpdate {
                let index: Int
                let relation: Relation
            }
            
            struct UpcomingProjects {
                var projects: [Project]
            }
            
            struct Project {
                let id: String
                let name: String
                let image: String
                let authorId: String
                let firstCathegory: String
                let secondCathegory: String?
                let progress: Int
                var relation: Relation?
                
                var finished: Bool {
                    return progress >= 100
                }
            }
        }
        
        struct ViewModel {
            
            struct Alert {
                let text: String
            }
            
            struct UpcomingProjects {
                let projects: [Project]
            }
            
            struct Project {
                let name: String
                let image: String
                let cathegories: NSAttributedString
                let progress: String
                var relation: UIImage?
            }
            
            struct RelationUpdate {
                let index: Int
                let relation: UIImage?
            }
            
            struct ErrorViewModel {
                let title: String
                let message: String
            }
        }
        
        struct Response {
            
            final class OngoingProject: Mappable {
                
                var id: String?
                var title: String?
                var cathegories: [String]?
                var progress: Int?
                var image: String?
                var authorId: String?
                
                init?(map: Map) { }
                
                func mapping(map: Map) {
                    id <- map["id"]
                    title <- map["title"]
                    cathegories <- map["cathegories"]
                    progress <- map["progress"]
                    image <- map["image"]
                    authorId <- map["author_id"]
                }
            }
            
            final class FinishedProject: Mappable {
                
                var id: String?
                var title: String?
                var cathegories: [String]?
                var image: String?
                var authorId: String?
                
                init?(map: Map) { }
                
                func mapping(map: Map) {
                    id <- map["id"]
                    title <- map["title"]
                    cathegories <- map["cathegories"]
                    image <- map["image"]
                    authorId <- map["author_id"]
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
    }
    
    struct Request {
        
        struct FetchRelation {
            let userId: String
            let projectId: String
            let index: Int
        }
        
        struct InviteUserToOngoingProject {
            let userId: String
            let projectId: String
            let projectTitle: String
            let projectImage: String
            let authorId: String
        }
        
        struct InviteUserToFinishedProject {
            let userId: String
            let projectId: String
        }
        
        struct RemoveInvite {
            let userId: String
            let projectId: String
        }
        
        struct AcceptUser {
            let userId: String
            let projectId: String
        }
        
        struct RefuseUser {
            let userId: String
            let projectId: String
        }
        
        struct RemoveUser {
            let userId: String
            let projectId: String
        }
        
        struct FetchProjects {
            
        }
        
        struct Interaction {
            let index: Int
        }
        
        struct ConfirmInteraction {
            
        }
        
        struct RefuseInteraction {
            
        }
        
        struct SearchProject {
            let preffix: String
        }
        
        struct FetchUserProjectRelation {
            let userId: String
            let projectId: String
        }
    }
}
