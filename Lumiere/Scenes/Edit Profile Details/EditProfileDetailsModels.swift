//
//  EditProfileDetails.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 23/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import ObjectMapper

struct EditProfileDetails {
    
    struct Constants {
        
        struct Colors {
            static let cancelButton = UIColor(rgb: 0xc4c4c4)
            static let finishButton = ThemeColors.mainRedColor.rawValue
            static let titleLbl = UIColor(rgb: 0x000000)
            static let imageButtonLayer = UIColor(rgb: 0xe0e0e0).cgColor
            static let changeImageLbl = ThemeColors.mainRedColor.rawValue
            static let textFieldBackground =  UIColor(rgb: 0xededed)
            static let textFieldPlaceholder = UIColor(rgb: 0x707070)
            static let textFieldText = UIColor(rgb: 0x222222)
            static let cathegoriesLbl = UIColor(rgb: 0x707070)
        }
        
        struct Fonts {
            static let cancelButton = ThemeFonts.RobotoBold(16).rawValue
            static let finishButton = ThemeFonts.RobotoBold(16).rawValue
            static let titleLbl = ThemeFonts.RobotoBold(16).rawValue
            static let changeImageLbl = ThemeFonts.RobotoBold(16).rawValue
            static let placeHolderFont = ThemeFonts.RobotoRegular(12).rawValue
            static let textFieldFont = ThemeFonts.RobotoRegular(12).rawValue
            static let cathegoriesLbl = ThemeFonts.RobotoBold(16).rawValue
        }
        
        struct Texts {
            static let cancelButton = "Cancelar"
            static let finishButton = "Concluir"
            static let titleLBl = "Editar perfil"
            static let changeImageLbl = "Alterar foto de perfil"
            static let cathegoriesLbl = "Categorias de interesse"
            static let nameTextFieldPlaceHolder = "Nome"
            static let cellPhoneTextFieldPlaceHolder = "Celular"
            static let ocupationTextFieldPlaceHolder = "Area Profissional"
        }
        
        struct Images {
            
        }
    }
    
    struct Info {
        
        struct Received {

        }
        
        struct Model {
            
            struct User {
                let id: String
                let image: String?
                let name: String
                let cellphone: String
                let ocupation: String
                let interestCathegories: InterestCathegories
            }
            
            struct InterestCathegories {
                var cathegories: [Cathegory]
            }
            
            struct Cathegory {
                let style: MovieStyle
                var selected: Bool
            }
        }
        
        struct ViewModel {
            
            struct User {
                let image: String?
                let name: String
                let cellphone: String
                let ocupation: String
            }
            
            struct Cathegories {
                let cathegories: Model.InterestCathegories
            }
        }
        
        struct Response {
            
            final class User: Mappable {
                
                var id: String?
                var name: String?
                var cellphone: String?
                var ocupation: String?
                var image: String?
                var interestCathegories: [String]?
                
                init?(map: Map) { }
                
                func mapping(map: Map) {
                    id <- map["id"]
                    name <- map["name"]
                    cellphone <- map["phone_number"]
                    ocupation <- map["professional_area"]
                    image <- map["profile_image_url"]
                    interestCathegories <- map["interest_cathegories"]
                }
            }
        }
    }
    
    struct Request {
        
        struct UserData {
            
        }
    }
}
