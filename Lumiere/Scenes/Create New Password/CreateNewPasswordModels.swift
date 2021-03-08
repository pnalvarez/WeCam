//
//  CreateNewPasswordModels.swift
//  WeCam
//
//  Created by Pedro Alvarez on 07/03/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit

struct CreateNewPassword {
    
    struct Constants {
        
        struct Colors {
            static let messageLbl = UIColor(rgb: 0x707070)
        }
        
        struct Fonts {
            static let messageLbl = ThemeFonts.RobotoRegular(14).rawValue
        }
        
        struct Texts {
            static let messageLbl = "Crie uma nova senha para sua conta"
            static let passwordPlaceholder = "Sua nova senha"
            static let confirmationPlaceholder = "Confirme sua nova senha"
            static let changePasswordButton = "Alterar senha"
            static let passwordEmptyErrorTitle = "Senha inválida"
            static let passwordEmptyErrorMessage = "Insira uma senha não vazia de formato válido"
            static let passwordMatchErrorTitle = "Senhas não coinscidem"
            static let passwordMatchErrorMessage = "Confirme a mesma senha que você deseja alterar"
            static let passwordSuccessfullyChangedTitle = "Senha alterada com sucesso"
            static let passwordSuccessfullyChangedMessage = "Sua nova senha agora está ativa e deverá ser usada para logar na sua conta WeCam. Memorize-a!"
            static let genericErrorTitle = "Erro"
        }
    }
    
    struct Info {
        
        struct Received {
            
            struct Account {
                let userId: String
            }
        }
        
        struct Response { }
        
        struct Model {
            
            enum ErrorType {
                case passwordFormat
                case passwordMatch
                case server
            }
            
            struct Error {
                let type: ErrorType
                let title: String
                let message: String
            }
        }
        
        struct ViewModel {
            
            struct Error {
                let type: Model.ErrorType
                let title: String
                let message: String
            }
        }
    }
    
    struct Request {
        
        struct Submit {
            let password: String
            let confirmation: String
        }
        
        struct ChangePassword {
            let userId: String
            let password: String
        }
    }
}
