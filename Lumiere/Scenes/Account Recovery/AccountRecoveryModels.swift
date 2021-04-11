//
//  AccountRecoveryModels.swift
//  WeCam
//
//  Created by Pedro Alvarez on 25/02/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit
import ObjectMapper

struct AccountRecovery {
    
    struct Constants {
        
        struct Colors {
            static let messageLbl = UIColor(rgb: 0x707070)
        }
        
        struct Fonts {
            static let messageLbl = ThemeFonts.RobotoRegular(14).rawValue
        }
        
        struct Texts {
            static let messageLblAccountSearch = "Encontre sua conta por e-mail ou telefone"
            static let messageLblSelectMethod = "Como deseja recuperar sua senha?"
            static let emailFormatErrorTitle = "Email inválido"
            static let emailFormatErrorMessage = "Por favor, insira um e-mail de formato válido para busca"
            static let genericErrorTitle = "Ocorreu um erro"
            static let succefullySentEmailTitle = "E-mail enviado"
            static let succeffullySentEmailMessage = "Um e-mail de mudança de senha foi enviado para o endereço de e-mail da conta em questão"
            static let sendEmailText = "Enviar e-mail"
        }
        
        struct Images { }
        
        struct BusinessLogic { }
    }
    
    struct Info {
        
        struct Received { }
        
        struct Response {
            
            final class User: Mappable {
                var userId: String?
                var name: String?
                var image: String?
                var ocupation: String?
                var email: String?
                var phone: String?
                
                init?(map: Map) { }
                
                func mapping(map: Map) {
                    userId <- map["userId"]
                    name <- map["name"]
                    image <- map["profile_image_url"]
                    ocupation <- map["professional_area"]
                    email <- map["email"]
                    phone <- map["phone"]
                }
            }
        }
        
        struct Model {
            
            enum RecoveryState {
                case accountSearch
                case selectMethod
            }
            
            enum RecoveryMethod: CaseIterable {
                case email
                case phone
                
                static func toArray() -> [RecoveryMethod] {
                    var array: [RecoveryMethod] = []
                    for value in RecoveryMethod.allCases {
                        array.append(value)
                    }
                    return array
                }
            }
            
            struct UpcomingRecoveryMethods {
                let methods: [RecoveryMethod]
            }
            
            struct Account {
                let userId: String
                let name: String
                let image: String
                let phone: String
                let email: String
                let ocupation: String
            }
            
            struct Error {
                let title: String
                let message: String
            }
        }
        
        struct ViewModel {
            
            enum RecoveryState {
                case accountSearch
                case selectMethod
            }
            
            enum RecoveryMethod {
                case email
                case phone
            }
            
            struct UpcomingRecoveryMethods {
                let methods: [RecoveryMethod]
            }
            
            struct Account {
                let name: String
                let image: String
                let phone: String
                let email: String
                let ocupation: String
            }
            
            struct Error {
                let title: String
                let message: String
            }
        }
    }
    
    struct Request {
        
        struct SearchAccount {
            let email: String
        }
        
        struct SendEmail { }
        
        struct SendRecoveryEmail {
            let email: String
        }
    }
}
