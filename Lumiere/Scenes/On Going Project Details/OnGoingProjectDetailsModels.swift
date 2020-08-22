//
//  OnGoingProjectDetailsModels.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 22/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

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
            
        }
        
        struct Model {
            
        }
        
        struct ViewModel {
            
            struct Project {
                let image: UIImage?
                let title: String
                let sinopsis: String
                let teamMembers: [TeamMember]
                let needing: String
            }
            
            struct TeamMember {
                let name: String
                let ocupation: String
            }
        }
        
        struct Response {
            
        }
    }
    
    struct Request {
        
    }
}
