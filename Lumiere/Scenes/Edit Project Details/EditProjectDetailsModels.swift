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
        }
        
        struct Fonts {
            static let teamValueLbl = ThemeFonts.RobotoRegular(16).rawValue
            static let publishButton = ThemeFonts.RobotoBold(16).rawValue
            static let teamFixedLbl = ThemeFonts.RobotoRegular(16).rawValue
            static let sinopsisFixedLbl = ThemeFonts.RobotoRegular(16).rawValue
            static let sinopsisTextField = ThemeFonts.RobotoRegular(16).rawValue
            static let needLbl = ThemeFonts.RobotoRegular(16).rawValue
            static let needTextField = ThemeFonts.RobotoRegular(16).rawValue
        }
        
        struct Texts {
            static let publishButton = "Publicar"
            static let teamFixedLbl = "Equipe"
            static let sinopsisFixedLbl = "Sinopse"
            static let needLbl = "Preciso de:"
            static let teamValueLblEmpty = "Nenhum amigo convidado"
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
            
        }
        
        struct ViewModel {
            
        }
        
        struct Response {
            
        }
        
        struct Errors {
            
        }
    }
    
    struct Request {
        
    }
}
