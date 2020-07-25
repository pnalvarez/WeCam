//
//  SignInModels.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 02/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

struct SignIn {
    
    struct Constants {
        
        struct Images {
            static let topLogo = "logo-apenas"
            static let bottomLogo = "tipografia-projeto 1"
        }
        
        struct Fonts {
            static let textFieldPlaceholder = ThemeFonts.RobotoRegular(12).rawValue
            static let forgetButton = ThemeFonts.RobotoRegular(12).rawValue
            static let signUp = ThemeFonts.RobotoRegular(12).rawValue
            static let enterButton = ThemeFonts.RobotoRegular(12).rawValue
            static let textFieldText = ThemeFonts.RobotoRegular(12).rawValue
        }
        
        struct Texts {
            static let emailTextField = "email"
            static let passwordTextField = "senha"
            static let forgetButton = "Esqueci minha senha"
            static let enterButton = "Entrar"
            static let signUp = "Cadastre-se"
        }
        
        struct Colors {
            static let textFieldBackground = UIColor(rgb: 0xededed)
            static let enterButtonBackground = UIColor(rgb: 0xe50c3c)
            static let enterButtonTextColor = UIColor(rgb: 0xffffff)
            static let backgroundColor = UIColor(rgb: 0xffffff)
            static let textFieldColor = UIColor(rgb: 0x222222)
        }
    }
    
    struct Models {
        
        struct Request {
            let email: String
            let password: String
        }
    }
    
    struct Response {
        
        enum SignInResponse {
            case success
            case error(Errors.ServerError)
        }
    }
    
    struct Errors {
        
        struct ServerError {
            let error: Error
        }
    }
    
    struct ViewModel {
        
        struct LoggedUser {
            
        }
        
        struct ForgetViewModel {
            
        }
        
        struct SignUpViewModel {
            
        }
        
        struct ServerError {
            let description: String
        }
    }
    
    struct Home {
        
        struct Response {
            
        }
    }
}
