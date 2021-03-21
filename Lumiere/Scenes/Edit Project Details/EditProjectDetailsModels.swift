//
//  EditProjectDetailsModels.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 21/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import ObjectMapper

struct EditProjectDetails {
    
    struct Constants {
        
        struct Colors {
            static let teamValueLblBackground = UIColor(rgb: 0xffffff)
            static let teamValueLblFieldLayer = UIColor(rgb: 0x000000).cgColor
            static let teamValueLblFieldText = UIColor(rgb: 0x000000)
            static let publishButtonBackground = ThemeColors.mainRedColor.rawValue
            static let publishButtonText = ThemeColors.whiteThemeColor.rawValue
            static let teamFixedLbl = UIColor(rgb: 0x707070)
            static let sinopsisFixedLbl = UIColor(rgb: 0x707070)
            static let sinopsisTextFieldBackground = UIColor(rgb: 0xffffff)
            static let sinopsisTextFieldLayer = UIColor(rgb: 0xe0e0e0).cgColor
            static let sinopsisTextFieldText = UIColor(rgb: 0x000000)
            static let needLbl = UIColor(rgb: 0x707070)
            static let needTextFieldBackground = UIColor(rgb: 0xffffff)
            static let needTextFieldLayer = UIColor(rgb: 0xe0e0e0).cgColor
            static let needTextFieldText = UIColor(rgb: 0x000000)
            static let projectTitleFixedLbl = UIColor(rgb: 0x707070)
            static let inviteFriendsButtonBackground = UIColor(rgb: 0xe3e0e0)
            static let inviteFriendsButtonText = UIColor(rgb: 0x000000)
        }
        
        struct Fonts {
            static let teamValueLbl = ThemeFonts.RobotoRegular(16).rawValue
            static let publishButton = ThemeFonts.RobotoBold(16).rawValue
            static let teamFixedLbl = ThemeFonts.RobotoRegular(16).rawValue
            static let sinopsisFixedLbl = ThemeFonts.RobotoRegular(16).rawValue
            static let sinopsisTextField = ThemeFonts.RobotoRegular(16).rawValue
            static let needLbl = ThemeFonts.RobotoRegular(16).rawValue
            static let needTextField = ThemeFonts.RobotoRegular(16).rawValue
            static let projectTitleLbl = ThemeFonts.RobotoRegular(16).rawValue
            static let inviteFriendsButton = ThemeFonts.RobotoRegular(16).rawValue
        }

        struct Texts {
            static let publishButton = "Publicar"
            static let teamFixedLbl = "Convites"
            static let sinopsisFixedLbl = "Sinopse"
            static let needLbl = "Preciso de:"
            static let teamValueLblEmpty = "Nenhum amigo convidado"
            static let projectTitleLbl = "Título do Projeto"
            static let errorTitle = "Erro"
            static let inviteFriendsButton = "Convidar mais Amigos"
            static let nextTitle = "Próximo"
        }
        
        struct Images {
            
        }
    }
    
    struct Info {
        
        struct Received {
            
            struct RoutingContext {
                let context: Model.Context
            }
            
            struct Project {
                let image: Data?
                let cathegories: [String]
                let progress: Float
            }
        }
        
        struct Model {
            
            enum Context {
                case finished
                case ongoing
            }
            
            struct PublishedProject {
                let id: String
                let title: String
                let authorId: String
                let image: String
                var userIdsNotInvited: [String]
            }
            
            struct PublishingProject {
                let image: Data?
                let cathegories: [String]
                let progress: Int
                let title: String
                let invitedUserIds: [String]
                let sinopsis: String
                let needing: String
            }
            
            struct InvitedUsers: Equatable {
                var users: [User]
            }
            
            struct User: Equatable {
                let id: String
                let name: String
                let image: String?
                let ocupation: String
            }
            
            struct ServerError {
                let error: WCError
            }
            
            struct LocalError {
                let description: String
            }
            
            enum InputErrors: String {
                case titleEmpty = "Insira um título para o seu projeto"
                case sinopsisEmpty = "Insira alguma sinopse sobre o seu projecto"
            }
        }
        
        struct ViewModel {
            
            struct InvitedUsers: Equatable {
                let users: [User]
            }
            
            struct User: Equatable {
                let name: String
                let ocupation: String
                let image: String?
            }
            
            struct DisplayError {
                let description: String
            }
        }
        
        struct Response {
            
            final class Project: Mappable {
                
                var id: String?
                var title: String?
                var image: String?
                var authorId: String?
                
                init?(map: Map) { }
                
                func mapping(map: Map) {
                    id <- map["id"]
                    title <- map["title"]
                    image <- map["image"]
                    authorId <- map["author_id"]
                }
            }
        }
    }
    
    struct Request {
        
        struct Invite {

        }
        
        struct Invitations {
            
        }
        
        struct Publish {
            let title: String
            let sinopsis: String
            let needing: String
        }
        
        struct CompletePublish {
            let project: Info.Model.PublishingProject
        }
        
        struct InviteUserToOngoingProject {
            let projectId: String
            let userId: String
            let title: String
            let image: String
            let authorId: String
        }
        
        struct FetchContext {
            
        }
    }
}

extension EditProjectDetails.Info.Response.Project: Stubbable {
    static var stub: EditProjectDetails.Info.Response.Project {
        return EditProjectDetails.Info.Response.Project(JSONString: """
                    {
                        "id": "idProj",
                        "title": "Projeto Teste",
                        "image": "image",
                        "author_id": "idUser"
                    }
                """)!
    }
}

extension EditProjectDetails.Info.Model.InvitedUsers: Stubbable {
    static var stub: EditProjectDetails.Info.Model.InvitedUsers {
        return EditProjectDetails
            .Info
            .Model
            .InvitedUsers(users: [EditProjectDetails.Info.Model.User(id: "idUser1",
                                                                     name: "Usuario Teste 1",
                                                                     image: "image",
                                                                     ocupation: "Artista"),
                                  EditProjectDetails.Info.Model.User(id: "idUser2",
                                                                     name: "Usuario Teste 2",
                                                                     image: "image",
                                                                     ocupation: "Artista"),
                                  EditProjectDetails.Info.Model.User(id: "idUser3",
                                                                     name: "Usuario Teste 3",
                                                                     image: "image",
                                                                     ocupation: "Artista")])
    }
}

