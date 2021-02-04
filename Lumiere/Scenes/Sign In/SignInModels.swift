//
//  SignInModels.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 02/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit
import ObjectMapper

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
        }
        
        struct Texts {
            static let emailTextField = "email"
            static let passwordTextField = "senha"
            static let forgetButton = "Esqueci minha senha"
            static let enterButton = "Entrar"
            static let signUp = "Cadastre-se"
        }
        
        struct Colors {
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
        
        struct User {
            let id: String
            let name: String
            let email: String
            let phoneNumber: String
            let image: String?
            let ocupation: String
            let connectionsCount: String
        }
    }
    
    struct Response {
        
        final class LoggedUser: Mappable {
            
            var id: String?
            var name: String?
            var email: String?
            var phoneNumber: String?
            var image: String?
            var ocupation: String?
            var connectionsCount: String?
            
            init?(map: Map) { }
            
            func mapping(map: Map) {
                id <- map["id"]
                name <- map["name"]
                email <- map["email"]
                phoneNumber <- map["phone_number"]
                image <- map["profile_image_url"]
                ocupation <- map["professional_area"]
                connectionsCount <- map["connections_count"]
            }
        }
        
        enum SignInResponse {
            case success
            case error(Errors.ServerError)
        }
    }
    
    struct Errors {
        
        struct ServerError {
            let error: Error
        }
        
        enum InputError: String {
            case emailEmpty = "Informação vazia: E-mail"
            case emailInvalid = "E-mail inválido"
            case passwordEmpty = "Informação vazia: Senha"
        }
    }
    
    struct ViewModel {
        
        struct LoggedUser {
            
        }
        
        struct ForgetViewModel {
            
        }
        
        struct SignUpViewModel {
            
        }
        
        struct SignInError {
            let description: String
        }
    }
    
    struct Home {
        
        struct Response {
            
        }
    }
}
