//
//  SignUpModels.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 03/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

struct SignUp {
    
    struct Constants {
        struct Colors {
            static let backgroundColor = UIColor(rgb: 0xffffff)
            static let imageButtonLayerColor = UIColor(rgb: 0xe0e0e0)
            static let textFieldBackgroundColor = UIColor(rgb: 0xededed)
            static let textFieldPlaceHolderColor = UIColor(rgb: 0x707070)
            static let cathegoriesLblColor = UIColor(rgb: 0x707070)
            static let signUpButtonBackgroundColor = UIColor(rgb: 0xe50c3c)
            static let signUpButtonDeactivatedColor = UIColor(rgb: 0xe50c3c).withAlphaComponent(0.6)
            static let signUpButtonTextColor = UIColor(rgb: 0xffffff)
            static let signUpCollectionViewCellText = UIColor(rgb: 0xffffff)
            static let textFieldColor = UIColor(rgb: 0x222222)
        }
        
        struct Texts {
            static let namePlaceholder = "Nome"
            static let cellphonePlaceholder = "Celular"
            static let emailPlaceholder = "E-mail"
            static let passwordPlaceholder = "Senha"
            static let confirmationPlaceholder = "Confirmar senha"
            static let professionalArea = "Area Profissional"
            static let cathegories = "Categorias de Interesse"
            static let signUpButton = "Cadastrar"
        }
        
        struct Dimensions {
            static let mainViewHeight: CGFloat = 1150
            static let scrollViewHeigh: CGFloat = 1200
        }
        
        struct Fonts {
            static let placeholderFont = ThemeFonts.RobotoRegular(12).rawValue
            static let cathegoriesLblFont = ThemeFonts.RobotoBold(16).rawValue
            static let signUpButtonFont = ThemeFonts.RobotoRegular(12).rawValue
            static let textFieldFont = ThemeFonts.RobotoRegular(12).rawValue
        }
        
        struct Images {
            static let titleHeaderIcon = UIImage(named: "tipografia-projeto 2")
            static let backButton = UIImage(named: "voltar 1")
        }
    }
    
    struct Request {
        
        struct SelectedCathegory {
            let cathegory: MovieStyle
        }
        
        struct SignUp {
            let name: String
            let email: String
            let password: String
            let confirmation: String
            let phoneNumber: String
            let professionalArea: String
        }
        
        struct SignUpProviderRequest {
            let userData: Info.Data.UserData
        }
    }
    
    struct Error {

    }
    
    struct Info {
        
        struct Data {
            
            struct UserData {
                let name: String
                let cellPhone: String
                let email: String
                let password: String
                let professionalArea: String
                let interestCathegories: InteretCathegories
            }
            
            struct InteretCathegories {
                var cathegories: [MovieStyle]
            }
        }
    }
}
