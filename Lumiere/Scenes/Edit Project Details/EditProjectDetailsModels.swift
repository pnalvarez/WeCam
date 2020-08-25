//
//  EditProjectDetailsModels.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 21/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

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
            static let projectTitleTextFieldBackground = UIColor(rgb: 0xffffff)
            static let projectTitleTextFieldLayer = UIColor(rgb: 0xe0e0e0).cgColor
            static let projectTitleTextFieldText = UIColor(rgb: 0x000000)
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
            static let projectTitleTextField = ThemeFonts.RobotoRegular(16).rawValue
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
        }
        
        struct Images {
            
        }
    }
    
    struct Info {
        
        struct Received {
            
            struct Project {
                let image: Data?
                let cathegories: [String]
                let progress: Float
            }
        }
        
        struct Model {
            
            struct Project {
                let image: Data?
                let cathegories: [String]
                let progress: Float
                let title: String
                let invitedUserIds: [String]
                let sinopsis: String
                let needing: String
            }
            
            struct InvitedUsers {
                let users: [User]
            }
            
            struct User {
                let id: String
                let name: String
                let image: String?
                let ocupation: String
            }
            
            struct ServerError {
                let error: Error
            }
            
            struct LocalError {
                let description: String
            }
        }
        
        struct ViewModel {
            
            struct InvitedUsers {
                let text: String
            }
            
            struct DisplayError {
                let description: String
            }
        }
        
        struct Response {
            
        }
    }
    
    struct Request {
        
        struct Invite {
            
        }
        
        struct Publish {
            let title: String
            let sinopsis: String
            let invitedUserIds: [String]
            let needing: String
        }
        
        struct CompletePublish {
            let project: Info.Model.Project
        }
    }
}
