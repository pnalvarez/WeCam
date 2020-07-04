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
            static let textField = UIFont(name: "Roboto-Regular", size: 12)
            static let forgetButton = UIFont(name: "Roboto-Regular", size: 12)
            static let signUp = UIFont(name: "Roboto-Regular", size: 12)
            static let enterButton = UIFont(name: "Roboto-Regular", size: 12)
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
        }
    }
    
    struct Models {
        
        struct Request {
            let email: String
            let password: String
        }
        
        struct Response {
            
            struct LoggedUser {
                
            }
            
            struct ForgetModel {
                
            }
            
            struct SignUpModel {
                
            }
        }
    }
    
    struct ViewModel {
        
        struct LoggedUser {
            
        }
        
        struct ForgetViewModel {
            
        }
        
        struct SignUpViewModel {
            
        }
    }
    
    struct Home {
        
        struct Response {
            
        }
    }
}
