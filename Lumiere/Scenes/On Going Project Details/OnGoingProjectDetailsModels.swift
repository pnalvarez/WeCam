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
            static let inviteContactsButtonBackground = UIColor(rgb: 0xededed)
            static let inviteContactsButtonText = UIColor(rgb: 0x000000)
            static let changeImageLbl = ThemeColors.mainRedColor.rawValue
            static let editButtonBackground = UIColor(rgb: 0xededed)
            static let editButtonText = UIColor(rgb: 0x000000)
            static let editButtonLayer = UIColor(rgb: 0xe0e0e0).cgColor
            static let interactionButtonBackground = ThemeColors.mainRedColor.rawValue
            static let interactionButtonText = ThemeColors.whiteThemeColor.rawValue
            static let editConclude = ThemeColors.mainRedColor.rawValue
            static let editConcludeText = ThemeColors.whiteThemeColor.rawValue
            static let cathegoryLbl = UIColor(rgb: 0x969494)
            static let progressButton = ThemeColors.mainRedColor.rawValue
            static let progressFixedLbl = UIColor(rgb: 0x707070)
        }
        
        struct Fonts {
            static let moreInfoButton = ThemeFonts.RobotoRegular(16).rawValue
            static let titleLbl = ThemeFonts.RobotoBold(16).rawValue
            static let sinopsisLbl = ThemeFonts.RobotoRegular(12).rawValue
            static let teamFixedLbl = ThemeFonts.RobotoRegular(16).rawValue
            static let needFixedLbl = ThemeFonts.RobotoRegular(16).rawValue
            static let needValueLbl = ThemeFonts.RobotoRegular(16).rawValue
            static let inviteContactsButton = ThemeFonts.RobotoRegular(16).rawValue
            static let changeImageLbl = ThemeFonts.RobotoBold(16).rawValue
            static let editButton = ThemeFonts.RobotoRegular(10).rawValue
            static let interactionButton = ThemeFonts.RobotoBold(16).rawValue
            static let cathegoryLbl = ThemeFonts.RobotoBold(16).rawValue
            static let progressButton = ThemeFonts.RobotoBold(14).rawValue
            static let progressFixedLbl = ThemeFonts.RobotoBold(14).rawValue
        }
        
        struct Texts {
            static let moreInfoButton = "+ informações"
            static let teamFixedLbl = "Equipe"
            static let needFixedLbl = "Precisam de"
            static let inviteError = "Não foi possível adicionar todos os usuários"
            static let inviteContactsButton = "Convidar mais amigos"
            static let changeImageLbl = "Alterar foto de perfil"
            static let editButton = "Editar"
            static let interactionAuthor = "Publicar"
            static let interactionSimpleParticipating = "Sair do projeto"
            static let interactionSentRequest = "Remover Solicitação"
            static let interactionReceivedRequest = "Responder Convite"
            static let interactionNothing = "Participar"
            static let editConclude = "Concluir"
            static let projectInviteAcceptedTitle = "Convite Aceito"
            static let projectInviteAcceptedMessage = "Você agora faz parte deste projeto"
            static let authorModalText = "Deseja publica este projeto?"
            static let simpleParticipatingModalText = "Deseja sair deste projeto?"
            static let sentRequestModalText = "Deseja remover sua solicitação de participação?"
            static let receivedRequestModalText = "Deseja aceitar participar deste projeto?"
            static let nothingModalText = "Deseja enviar uma solicitação para este projeto?"
            static let progressFixedLbl = "Concluído"
        }
        
        struct Images {
            
        }
    }
    
    struct Info {
        
        struct Received {
        
            struct Project {
                let projectId: String
                let notInvitedUsers: [String]
            }
        }
        
        struct Model {
            
            enum ProjectRelation {
                case author
                case simpleParticipating
                case sentRequest
                case receivedRequest
                case nothing
            }
            
            struct RelationModel {
                var relation: ProjectRelation
            }
            
            struct Project {
                let id: String
                let firstCathegory: String
                let secondCathegory: String?
                var image: String?
                let progress: Int
                var title: String
                var sinopsis: String
                var teamMembers: [TeamMember]
                var needing: String
                var relation: ProjectRelation?
            }
            
            struct TeamMember {
                let id: String
                let name: String
                let ocupation: String
                let image: String?
            }
            
            struct Feedback {
                let title: String
                let message: String
            }
        }
        
        struct ViewModel {
            
            struct Project {
                let image: String?
                let cathegories: NSAttributedString
                let title: String
                let progress: NSAttributedString
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
            
            struct RelationModel {
                let relation: Model.ProjectRelation
            }
            
            struct Feedback {
                let title: String
                let message: String
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
            
            final class ProjectRelation: Mappable {
                
                var relation: String?
                
                init?(map: Map) { }
                
                func mapping(map: Map) {
                    relation <- map["relation"]
                }
            }
            
            final class ProjectImage: Mappable {
                
                var imageURL: String?
                
                init?(map: Map) { }
                
                func mapping(map: Map) {
                    imageURL <- map["image"]
                }
            }
        }
    }
    
    struct Request {
        
        struct ExitProject {
            let projectId: String
        }
        
        struct RemoveProjectParticipationRequest {
            let projectId: String
        }
        
        struct ProjectParticipationRequest {
            let projectId: String
        }
        
        struct RefuseProjectInvite {
            let projectId: String
        }
        
        struct AcceptProjectInvite {
            let projectId: String
        }
        
        struct ConfirmInteraction {
            
        }
        
        struct RefuseInteraction {
            
        }
        
        struct FetchInteraction {
            
        }
        
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
        
        struct ProjectRelation {
            
        }

        struct ProjectRelationWithId {
            let projectId: String
        }
        
        struct UpdateInfo {
            let title: String
            let sinopsis: String
        }
        
        struct UpdateImage {
            let image: Data
        }
        
        struct UpdateNeeding {
            let needing: String
        }
        
        struct UpdateInfoWithId {
            let projectId: String
            let title: String
            let sinopsis: String
        }
        
        struct UpdateImageWithId {
            let projectId: String
            let image: Data
        }
        
        struct UpdateNeedingWithId {
            let projectId: String
            let needing: String
        }
        
        struct CancelEditing {
            
        }
    }
}
