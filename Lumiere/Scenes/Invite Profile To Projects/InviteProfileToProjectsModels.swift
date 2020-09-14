//
//  InviteProfileToProjectsModels.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 13/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import ObjectMapper

struct InviteProfileToProjects {
    
    struct Constants {
        
        struct Colors {
            static let nameLbl = UIColor(rgb: 0x707070)
            static let cathegoriesLbl = UIColor(rgb: 0x969494)
            static let mainLbl = UIColor(rgb: 0x000000)
            static let searchTextFieldText = UIColor(rgb: 0x000000)
            static let searchTextFieldLayer = UIColor(rgb: 0xe3e0e0).cgColor
        }
        
        struct Fonts {
            static let nameLbl = ThemeFonts.RobotoBold(18).rawValue
            static let cathegoriesLbl = ThemeFonts.RobotoRegular(16).rawValue
            static let mainLbl = ThemeFonts.RobotoRegular(16).rawValue
            static let searchTextField = ThemeFonts.RobotoRegular(16).rawValue
        }
        
        struct Texts {
            static let mainLbl = "Convidar para projeto"
        }
        
        struct Images {
            
        }
        
        struct Dimensions {
            
            struct Heights {
                
            }
        }
    }
    
    struct Info {
        
        struct Received {
            
        }
        
        struct Model {
            
        }
        
        struct ViewModel {
            
            struct Project {
                let name: String
                let image: String
                let cathegories: NSAttributedString
                var relation: UIImage?
            }
        }
        
        struct Response {
            
        }
    }
    
    struct Request {
        
    }
}
