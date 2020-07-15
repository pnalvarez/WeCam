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
            static let signUpButtonDeactivatedColor = UIColor(rgb: 0xff1893)
            static let signUpButtonTextColor = UIColor(rgb: 0xffffff)
            static let signUpCollectionViewCellText = UIColor(rgb: 0xffffff)
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
        }
        
        struct Fonts {
            static let placeholderFont = UIFont(name: "Roboto-Regular", size: 12)
            static let cathegoriesLblFont = UIFont(name: "Roboto-Bold", size: 16)
            static let signUpButtonFont = UIFont(name: "Roboto-Regular", size: 16)
        }
    }
    
    struct Request {
        
        struct SelectedCathegory {
            let cathegory: MovieStyle
        }
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
